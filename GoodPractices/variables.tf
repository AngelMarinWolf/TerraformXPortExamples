############################
# Declaration of variables
############################
variable "aws_access_key" {
  type        = "string"
  description = "Credentials provided by Amazon IAM."
}
variable "aws_secret_key" {
  type        = "string"
  description = "Credentials provided by Amazon IAM."
}
variable "aws_region" {
  type        = "string"
  default     = "us-west-1"
  description = "Credentials provided by Amazon IAM."
}
variable "instance_type" {
  type        = "string"
  default     = "t2.micro"
  description = "Define the tier level or class of the EC2 Instances."
}
