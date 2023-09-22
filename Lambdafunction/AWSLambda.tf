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
    Name = "mybucket1995"
  }
}

# Upload zip file to S3 bucket
resource "aws_s3_bucket_object" "object" {
  bucket = aws_s3_bucket.mybucket1995.id
  key    = "Example.zip"
  source = data.archive_file.init.output_path
}

# IAM role for Lambda
resource "aws_iam_role" "lambda_role" {
  name = "My-lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# IAM role-policy for Lambda
resource "aws_iam_policy" "lambda_policy" {
  name        = "My-lambda_policy"
  description = "Policy for Lambda execution"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = "s3:GetObject",
        Effect   = "Allow",
        Resource = aws_s3_bucket.mybucket1995.arn
      }
      # Add other permissions as needed
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  policy_arn = aws_iam_policy.lambda_policy.arn
  role       = aws_iam_role.lambda_role.name
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

output "pythonlambdaarn" {
  pythonfunctionapparn = module.awslambdafunction.pythonfunctionapparn
}