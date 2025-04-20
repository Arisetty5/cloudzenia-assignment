# 🌐 ECS Cluster with WordPress, Custom Microservice, RDS & SecretsManager

## 📌 Project Overview

This project provisions a complete AWS infrastructure using **Terraform**, deploying a production-like environment for running a WordPress site and a custom microservice using **Amazon ECS**, **RDS**, **SecretsManager**, and an **Application Load Balancer (ALB)**. The system supports auto-scaling, secure secret storage, and is configured for monitoring and deployment automation via **GitHub Actions**.

---

## 🧱 Architecture Overview

- **ECS Cluster** deployed in private subnets
- **WordPress** and a **Custom Node.js Microservice** as ECS services
- **RDS** for WordPress database, secured via **AWS SecretsManager**
- **Application Load Balancer (ALB)** in public subnets for routing traffic
- **Terraform modules** for reusable infrastructure setup
- **GitHub Actions** for CI/CD of the microservice

---

## 🛠️ Tech Stack

- **AWS ECS (Fargate)**
- **Amazon RDS (MySQL)**
- **SecretsManager**
- **ALB (Application Load Balancer)**
- **Terraform**
- **Docker**
- **GitHub Actions**

---

## 🚀 Infrastructure Components

### ECS Cluster & Services

- ECS Cluster deployed in **private subnets**
- 2 ECS Services:
  - **WordPress** (using official WordPress Docker image)
  - **Custom Node.js Microservice**
- Auto-scaling enabled based on **CPU and memory thresholds**

### Microservice Details

- Lightweight **Node.js** app responding with `"Hello from Microservice"`
- Dockerized for deployment to ECS
- Built and deployed via **GitHub Actions**


### RDS (MySQL)

- RDS instance deployed in **private subnets**
- **Custom database user/password**
- **Automated backups** enabled
- **No auto-rotation** of credentials

### AWS SecretsManager

- RDS credentials securely stored in SecretsManager
- ECS task definitions reference secrets securely
- ECS IAM roles granted least-privilege access to SecretsManager

### Application Load Balancer (ALB)

- ALB deployed in **public subnets**
- Routes HTTP traffic to:
  - WordPress container
  - Microservice container
- **No domain names configured**
- **No SSL/TLS setup**; only HTTP access via ALB DNS
- Sample ALB URL:  
  `http://ecs-task1-alb-1234567890.us-east-1.elb.amazonaws.com`

---

## 🧪 Access Endpoints

| Service           | Endpoint URL                                       |
|-------------------|----------------------------------------------------|
| WordPress         | http://ecs-task1-alb-105468745.us-east-1.elb.amazonaws.com/wordpress |
| Microservice      | http://ecs-task1-alb-106955468.us-east-1.elb.amazonaws.com/microservice |

> ⚠️ HTTPS/SSL and domain-based routing are not implemented in this project.

---

## 📦 GitHub Actions CI/CD (Microservice)

- Configured under `.github/workflows/deploy.yml`
- Triggers on push to `main` branch
- Workflow:
  1. Build Docker image for microservice
  2. Push image to **Docker Hub**
  3. Update ECS service with new image

---

## ⚙️ Deployment Instructions

### Step 1: Clone the Repository

```bash
git clone <your-repo-url>
cd cloudzenia-assignment-task1
```

### Step 2: Initialize Terraform

```bash
terraform init
```

### Step 3: Apply the Terraform Configuration

```bash
terraform apply
```

### Step 4: Clean Up Resources

```bash
terraform destroy
```

---

## ✅ Output Summary

```hcl
alb_dns_name         = "ecs-task1-alb-107765244.us-east-1.elb.amazonaws.com"
wordpress_service    = "ecs-task1-alb-105468745.us-east-1.elb.amazonaws.com"
microservice_service = "ecs-task1-alb-106955468.us-east-1.elb.amazonaws.com"
```
