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

## create a aws python lambda function
module "awslambdafunction" {
  source = "./Lambdafunction"
}

## crate AWS Stepfunction to invoke Aws lambda function
module "awsstepfunction" {
  source  = "./Stepfunction"
  pythonfunctionapparn = module.awslambdafunction.pythonLambdaArn
}