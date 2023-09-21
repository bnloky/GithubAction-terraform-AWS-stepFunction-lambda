provider "aws" {
  region = "ap-south-1"
}

terraform {
  backend "s3" {
    bucket         = "my-dynamodb-tffilestore"
    key            = "terraform1.tfstate"
    region         = "ap-south-1"  # Replace with your desired region
    encrypt        = true
  }
}


module "awslambdafunction" {
  source = "./Lambdafunction"
}

module "awsstepfunction" {
  source               = "./Stepfunction"
  pythonfunctionapparn = module.awslambdafunction.pythonfunctionapparn
}


