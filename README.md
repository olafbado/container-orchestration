### Container Orchestration on AWS with EKS
This project automates the deployment of a containerized application on AWS using a combination of Terraform, Docker, AWS Elastic Container Registry (ECR), and Elastic Kubernetes Service (EKS). The objective is to provision the necessary infrastructure on AWS, build and push a Docker image of a simple Node.js application to ECR, and deploy it on an EKS cluster with a Kubernetes-managed load balancer.

### Setup Instructions

#### 1. Provision Infrastructure using Terraform
```bash
terraform init
terraform apply
```
#### 2. Build and Push Docker Image to ECR
```bash
# Set up a multi-platform builder for Docker:
docker buildx create --use --platform=linux/amd64,linux/arm64 --name multi-platform-builder
# Authenticate Docker to ECR:
aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin <ECR_IMAGE_URI>
# Build and push the Docker image to ECR:
docker buildx build --platform=linux/amd64,linux/arm64 -t <ECR_IMAGE_URI>:v1 --push .
```
#### 3. Update image in `sample-app-deployment.yaml` file with ECR Image URI
#### 4. Deploy the app to EKS
```bash
# Update kubeconfig to connect to EKS cluster:
aws eks update-kubeconfig --region us-east-2 --name eks-sample
# Verify EKS nodes are ready:
kubectl get nodes
# Deploy the app to EKS:
kubectl apply -f sample-app-deployment.yaml
kubectl apply -f sample-app-service.yaml
```
#### 5. Access the Application
```bash
# Get the Load Balancer `EXTERNAL_IP` and type it in a web browser:
kubectl get svc
```