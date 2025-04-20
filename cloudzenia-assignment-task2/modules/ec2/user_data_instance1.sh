#!/bin/bash

# Update system
sudo apt-get update -y

# Install Nginx and required dependencies
sudo apt-get install -y nginx wget

# Start and enable Nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# Configure Nginx for production
sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bak

# Create a basic production-ready configuration (you can modify it as per your requirement)
cat <<EOF | sudo tee /etc/nginx/sites-available/default
server {
    listen 80;
    server_name _;

    root /var/www/html;
    index index.html;

    # Try to serve static files directly, fallback to index.html
    location / {
        try_files \$uri \$uri/ =404;
    }

    # Enable logging
    access_log /var/log/nginx/access.log;
    error_log /var/log/nginx/error.log;

    # Handle 502 Bad Gateway (common with reverse proxies)
    error_page 502 /502.html;
    location = /502.html {
        root /usr/share/nginx/html;
        internal;
    }
}
EOF

# Test Nginx configuration
sudo nginx -t
if [ $? -ne 0 ]; then
    echo "Nginx configuration failed. Check the error logs for details."
    exit 1
fi

# Restart Nginx to apply changes
sudo systemctl restart nginx

# Create index.html to serve as a test page
echo "Hello from Instance" | sudo tee /var/www/html/index.html

# Ensure correct permissions on Nginx files and directories
sudo chown -R www-data:www-data /var/www/html

# Check Nginx logs for any error messages
sudo tail -n 20 /var/log/nginx/error.log

# Install CloudWatch Agent
cd /tmp
wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
sudo dpkg -i amazon-cloudwatch-agent.deb

# Create CloudWatch Agent Configuration
cat <<EOF | sudo tee /opt/aws/amazon-cloudwatch-agent/bin/config.json
{
  "agent": {
    "metrics_collection_interval": 60,
    "run_as_user": "root"
  },
  "metrics": {
    "append_dimensions": {
      "InstanceId": "\${aws:InstanceId}"
    },
    "metrics_collected": {
      "mem": {
        "measurement": [
          "mem_used_percent"
        ],
        "metrics_collection_interval": 60
      }
    }
  },
  "logs": {
    "logs_collected": {
      "files": {
        "collect_list": [
          {
            "file_path": "/var/log/nginx/access.log",
            "log_group_name": "/nginx/access",
            "log_stream_name": "{instance_id}-access",
            "timezone": "Local"
          },
          {
            "file_path": "/var/log/nginx/error.log",
            "log_group_name": "/nginx/error",
            "log_stream_name": "{instance_id}-error",
            "timezone": "Local"
          }
        ]
      }
    }
  }
}
EOF

# Start CloudWatch Agent
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
    -a fetch-config \
    -m ec2 \
    -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json \
    -s

# Final check for firewall rules to ensure HTTP traffic is allowed
sudo ufw allow 'Nginx Full'

# Check Nginx status and ensure no errors
sudo systemctl status nginx
