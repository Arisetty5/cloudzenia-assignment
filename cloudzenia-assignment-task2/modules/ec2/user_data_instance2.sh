#!/bin/bash
# Exit immediately if a command exits with a non-zero status
set -e

# Update system
sudo apt-get update -y

# Install Docker, Nginx, and Wget in one go
sudo apt-get install -y docker.io nginx wget

# Start and enable Docker and Nginx
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl start nginx
sudo systemctl enable nginx

# Pull and run the Docker container
sudo docker run -d --name namaste-app -p 8080:8080 arisetty5/cloudzenia-microservice:v1

# Wait for Docker container to be fully running
sleep 10

# Configure Nginx as a Reverse Proxy
sudo tee /etc/nginx/sites-available/default > /dev/null <<EOF
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://localhost:8080/;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    }
}
EOF

# Test Nginx config before restart
sudo nginx -t

# Restart Nginx to apply new config
sudo systemctl restart nginx

# Install CloudWatch Agent
cd /tmp
wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
sudo dpkg -i amazon-cloudwatch-agent.deb

# Create CloudWatch Agent configuration
sudo tee /opt/aws/amazon-cloudwatch-agent/bin/config.json > /dev/null <<EOF
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

# Confirm Docker and Nginx are active
sudo systemctl status docker
sudo systemctl status nginx
