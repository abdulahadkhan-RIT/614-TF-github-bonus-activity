terraform {
  backend "s3" {
    bucket         = "bonusactivity"  
    key            = "terraformbonus.tfstate"           
    region         = "us-east-1"                  
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"
  aws_region = var.aws_region
}

module "networking" {
  source = "./modules/networking"
  vpc_id = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_id
}

module "security" {
  source = "./modules/security"
  vpc_id = module.vpc.vpc_id
}

module "rds" {
  source = "./modules/rds"
  subnet_ids = [module.vpc.private_subnet_id, module.vpc.public_subnet_id]
  security_group_id = module.security.rds_security_group_id
  username = var.db_username
  password = var.db_password
}

module "ec2" {
  source = "./modules/ec2"
  subnet_id = module.vpc.public_subnet_id
  security_group_id = module.security.ec2_security_group_id
  key_name = var.key_name
  db_name = "wordpressdb"
  db_username = var.db_username
  db_password = var.db_password
  db_endpoint = module.rds.endpoint
}
