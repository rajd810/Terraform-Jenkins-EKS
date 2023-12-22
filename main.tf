#Create VPC

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "jenkins-vpc"
  cidr = var.vpc_cidr

  azs            = data.aws_availability_zones.azs
  public_subnets = var.public_subnets

  enable_dns_hostnames = true

  tags = {
    Name        = "jenkins-vpc"
    terraform   = "true"
    Environment = "dev"
  }

  public_subnet_tags = {
    Name        = "jenkins-subnet"
  }
}


#Create Security group

module "sg" {
    source      = "terraform-aws-modules/security-group/aws"

    name        = "jenkins-sg"
    description = "Security Group for Jenkins Server"
    vpc_id      = module.vpc.default_vpc_id

    ingress_with_cidr_blocks = [
        {
            from_port   = 8080
            to_port     = 8090
            protocol    = "tcp"
            description = "HTTP"
            cidr_blocks  = "0.0.0.0/0"
        },
        {
            from_port   = 22
            to_port     = 22
            protocol    = "tcp"
            description = "HTTP"
            cidr_blocks = "0.0.0.0/0"
        },    
    ]

    egress_with_cidr_blocks = [
        {
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_blocks = "0.0.0.0/0"
        }
    ]

    tags = {
        Name = "jenkins-sg"
    }
}



#Create EC2