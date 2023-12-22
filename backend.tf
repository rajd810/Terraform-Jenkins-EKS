# This TF shows the S3 Connection with key

terraform {
  backend "s3" {
    bucket = "terraform-eks-bck"
    key    = "jenkins/terraform.tfstate"
    region = "us-east-1"
  }
}