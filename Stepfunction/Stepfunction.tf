variable "pythonfunctionapparn" {
}

# AS Step function role
resource "aws_iam_role" "My_step_function_role" {
  name = "Demo-stepfunction-role"
  assume_role_olicy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "states.amazonaws.com"
        }
      }
    ]
  })
}

# AWS Step function role-policy
resource "aws_iam_role_policy" "My_step_function_policy" {
  name        = "Demo-stepfunctionrole-policy"
  role        = aws_iam_role.My_step_function_role.id
  description = "Policy for Step Function Role"
  policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Action   = "lambda:InvokeFunction",
        Effect   = "Allow",
        Resource = "${var.pythonfunctionapparn}"
      }
      # Add other permissions as needed
    ]
  })
}

# AWS Step Function State machine
resource "aws_sfn_state_machine" "sfn_state_machine" {
  name     = "Demo-stepfunction"
  role_arn = aws_iam_role.My_step_function_role.arn

  definition = jsonencode({
    Comment = "Invoke AWS Lambda from AWS Step Functions with Terraform",
    StartAt = "ExampleLambdaFunctionApp",
    States  = {
      "ExampleLambdaFunctionApp" = {
        Type     = "Task",
        Resource = "${var.pythonfunctionapparn}"
        End      = true
      }
    }
  }
  )
}
