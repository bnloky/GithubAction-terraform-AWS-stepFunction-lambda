# Create an archive file
data "archive_file" "init" {
  type        = "zip"
  source_file = "${path.module}/Example.py"
  output_path = "${path.module}/Example.zip"
}

# Create an S3 bucket
resource "aws_s3_bucket" "mybucket1995" {
  bucket = "mys3bucketfordyanamodb"
  acl    = "private"

  tags = {
    Name = "mybucket1995-1"
  }
}

# Upload zip file to S3 bucket
resource "aws_s3_bucket_object" "object" {
  bucket = aws_s3_bucket.mybucket1995.id
  key    = "Example.zip"
  source = "${path.module}/Example.zip" 
}  

# IAM role for Lambda
resource "aws_iam_role" "lambda_role" {
  name = "My_lambda_role"
  assume_role_policy = file("Lambdafunction/lambda_assume_role_policy.json")
}
  
# IAM role-policy for Lambda
resource "aws_iam_role_policy" "lambda_policy" {
  name        = "My-lambda_policy"
  role        = aws_iam_role.lambda_role.id
  policy      = file("Lambdafunction/lambda_policy.json")
}
  
# AWS Lambda function
resource "aws_lambda_function" "test_lambda" {
  function_name = "Example"
  s3_bucket     = aws_s3_bucket.mybucket1995.id
  s3_key        = "Example.zip"
  role          = aws_iam_role.lambda_role.arn
  handler       = "Example.handler"
  runtime       = "python3.8"
}

## output to be consumed by other module
output "pyhtonLambdaArn" {
  value = aws_lambda_function.test_lambda.arn
}


