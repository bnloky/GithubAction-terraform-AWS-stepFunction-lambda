## Get the lambda function been create.
variable "pythonfunctionapparn" {
}

## Aws step function role 
resource “aws_iam_role” "step_function_role” {
name = "my-stepfunction-role™
assume_role_policy = <<-EOF
 {
   "Version": 2012-10-17",
   "Statement": [
      {
        “Action”: "sts:AssumeRole”,
        “principal”: {
          "Service": “states.amazonaws.com"
        },
        “Effect": "Allow",
        "Sid": "StepFunctionAssumeRole”
      }
   ]
  }
  EOF
}

## Aws Step function role-policy
resource “aws_iam_role_policy” "step_function_policy” {
name    = "My-stepfunctionrole-policy”
role    = aws_iam_role.step_function_role.id

policy = <<-EOF
{
  "Version": "2012-10-17",
  "Statement": [
     {
       "Action": [
          "lambda:InvokeFunction"
       ],
       "Effect": "Allow",
       “Resource”: “${var.pythonfunctionapparn}”
      }
    ]
  }
  EOF
}

##AWS State function - State machine
resource "aws_sfn_state machine” "My_state_machine” {
name     =  "My-demo-stepfunction"
role_arn = aws_iam_role.step_function_role.arn

definition = <<EOF
{
  “Comment”: "Invoke AWS Lambda from AWS Step Functions with Terraform",
  “StartAt": “ExampleLambdaFunctionApp”,
  “States": {
    "ExampleLambdaFunctionApp": {
        "Type": "Task",
        "Resource": "${var.pythonfunctionapparn}",
        "End": true
       }
    } 
  }
   EOF
}   