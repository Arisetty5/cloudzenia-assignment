# Cloudzenia Assignment 🚀

This repository contains the Terraform-based infrastructure setup for the **Cloudzenia Cloud DevOps Challenge**.

The project is divided into two main tasks, each representing a practical deployment scenario using various AWS services and tools.

---

## 📁 Tasks Overview

### ✅ [Task 1: ECS with ALB, RDS, and SecretsManager](./cloudzenia-assignment-task1)

- Deploys a **WordPress** application on **ECS Fargate**.
- Includes a **custom Node.js microservice**.
- Uses **RDS** (MySQL) for the WordPress database.
- Stores sensitive data in **AWS Secrets Manager**.
- Uses an **Application Load Balancer** to route traffic to the services.
- Infrastructure is defined using **Terraform**.
- CI/CD is implemented using **GitHub Actions** to build, push, and deploy the microservice Docker image.

### ✅ [Task 2: EC2 with Domain Mapping and NGINX](./cloudzenia-assignment-task2)

- Deploys **two EC2 instances** in private subnets.
- Each instance is provisioned with **NGINX** and **Docker**.
- One serves content via NGINX directly, and the other proxies to a Docker container.
- Traffic is routed through an **Application Load Balancer** deployed in public subnets.
- **CloudWatch** is configured to monitor RAM and collect NGINX access logs.
- No SSL certificates or domain-based routing are configured — traffic is served via the ALB DNS endpoint.

---

## 🧰 Tools & Technologies

- **AWS Services:** EC2, ECS, RDS, ALB, Secrets Manager, CloudWatch
- **Terraform:** Infrastructure as Code (IaC)
- **Docker:** Containerization
- **NGINX:** Web Server and Reverse Proxy
- **GitHub Actions:** Continuous Integration / Deployment

---

## 📦 Repository Structure

```plaintext
cloudzenia-assignment/
├── cloudzenia-assignment-task1/     # Task 1 - ECS, RDS, SecretsManager, ALB
├── cloudzenia-assignment-task2/     # Task 2 - EC2, NGINX, Docker, ALB
└── README.md                         # Root-level readme (this file)
```

Each task folder contains its own `README.md` with full setup instructions, configurations, and endpoint details.

---

## 🚀 How to Use

1. **Clone the repository:**

   ```bash
   git clone https://github.com/<your-username>/cloudzenia-assignment.git
   cd cloudzenia-assignment
   ```

2. **Explore each task folder:**

   Navigate into `cloudzenia-assignment-task1` or `cloudzenia-assignment-task2` to view Terraform code and readme files specific to each task.

3. **Deploy Infrastructure:**

   Follow the instructions in the respective task readmes to deploy infrastructure using Terraform.

---

## 📬 Contact

Feel free to reach out if you have any questions or feedback:

**Author:** Arisetty5  
**GitHub:** [github.com/Arisetty5](https://github.com/Arisetty5)

---

**Made with ☁️ Terraform + ❤️ AWS**
