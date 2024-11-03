provider "aws" {
  region = "us-east-2"
}

module "ecr-repo" {
  source = "./modules/ecr-repo"
  name   = "sample-app"
}

module "eks-cluster" {
  source               = "./modules/eks-cluster"
  name                 = "eks-sample"
  eks_version          = "1.29"
  instance_type        = "t2.micro"
  min_worker_nodes     = 1
  max_worker_nodes     = 10
  desired_worker_nodes = 2
}
