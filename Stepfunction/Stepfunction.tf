variable “pythonfunctionapparn” {
}

#2 AS Step function role
resource “aws_iam_role” "step_function_role” {

name = "cloudquickpocsstepfunction-role™
assume_role_policy = <<-EOF
{

2012-10-17",
Statement: [

“Action”: "sts:AssumeRole”,
“principal”: {

"Service": “states.amazonaws.com"
}
“Effect

"Allow",
‘StepFunctionAssumeRole”

## Aws Step function role-policy

resource “aws_iam role policy” "step function policy” {
"cqpdstepfunctionrole-policy”
aws_iam_role.step_function_role.id
policy = <<-EOF
{

"Version": "2012-10-17",

“Resource”: “${var.pythonfunctionapparn}”

ANS State function - State machine
esource "aws_sfn_state machine” "sfn_state_machine” {
nane “cloudquickpocsstepfunction™
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