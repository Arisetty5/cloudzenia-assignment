# 🚀 EC2 with Docker, NGINX & Application Load Balancer - AWS Infrastructure Deployment

## 📌 Project Overview

This project sets up a simple yet functional cloud infrastructure on AWS using **Terraform**. The setup includes two EC2 instances deployed in private subnets, each running **NGINX** and **Docker**. An **Application Load Balancer (ALB)** is configured in public subnets to route HTTP traffic to these instances. The infrastructure also integrates **CloudWatch** for monitoring system metrics and logging access data from NGINX.

---

## 🧱 Architecture Summary

- **Two EC2 Instances** in private subnets
- **Elastic IPs** for public access
- **NGINX** for serving content and reverse proxying
- **Docker** containers running on internal ports
- **Application Load Balancer (ALB)** for routing HTTP traffic
- **CloudWatch** for logs and RAM metrics
- **Terraform Modules** for reusable infrastructure code

---

## 🛠️ Tech Stack

- **AWS** (EC2, VPC, Subnets, ALB, CloudWatch)
- **Terraform** (Infrastructure as Code)
- **Docker**
- **NGINX**

---

## 🚀 Infrastructure Components

### EC2 Instances

- **2 EC2 Instances** in private subnets
- **Elastic IPs** attached for public access
- Instance 1 runs **NGINX** serving plain text (`"Hello from Instance"`)
- Instance 2 runs **NGINX** as a reverse proxy to a Docker container on port `8080` responding with `"Namaste from Container"`

### Elastic IPs

| Instance        | Elastic IP      |
|----------------|------------------|
| Instance 1     | `3.92.123.62`    |
| Instance 2     | `18.233.22.2`    |

### Application Load Balancer (ALB)

- Deployed in **public subnets**
- Routes HTTP traffic to both EC2 instances
- ALB DNS Name:  
  `http://cloudzenia-task2-alb-103359261.us-east-1.elb.amazonaws.com`
- No SSL or HTTPS enforced
- Used for basic HTTP-based routing

### NGINX Configuration

- Installed on both EC2 instances
- Instance 1 serves a static text response: `"Hello from Instance"`
- Instance 2 forwards requests to a Docker container via reverse proxy

### Docker Configuration

- Docker installed on Instance 2
- A simple containerized web app runs on port `8080`
- Responds with: `"Namaste from Container"`

---

## 📊 Monitoring and Observability

### CloudWatch Metrics

- CloudWatch Agent installed on both EC2 instances
- RAM and CPU metrics are pushed to **CloudWatch Metrics**

### CloudWatch Logs

- NGINX access logs (`/var/log/nginx/access.log`) are forwarded to **CloudWatch Logs**
- Log group can be monitored directly from the AWS Console

---

## 🧪 Access Endpoints

| Component        | Access URL                                       |
|------------------|--------------------------------------------------|
| EC2 Instance 1   | http://3.92.123.62                                |
| EC2 Instance 2   | http://18.233.22.2                                |
| Load Balancer    | http://cloudzenia-task2-alb-103359261.us-east-1.elb.amazonaws.com |

> All endpoints are accessible over **HTTP only**. Domain names and SSL certificates are **not configured** in this project.

---

## ⚙️ Deployment Instructions

### Step 1: Clone the Repository

```bash
git clone <your-repo-url>
cd cloudzenia-assignment-task2
```

### Step 2: Initialize Terraform

```bash
terraform init
```

### Step 3: Deploy the Infrastructure

```bash
terraform apply
```

### Step 4: Destroy Infrastructure (Cleanup)

```bash
terraform destroy
```

---

## ✅ Output Summary

```hcl
alb_dns_name       = "cloudzenia-task2-alb-103359261.us-east-1.elb.amazonaws.com"
instance1_public_ip = "3.92.123.62"
instance2_public_ip = "18.233.22.2"
```





