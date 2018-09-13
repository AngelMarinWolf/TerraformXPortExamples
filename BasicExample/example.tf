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

############################
# Configure the AWS Provider
############################
provider "aws" {
  access_key    = "${var.aws_access_key}"
  secret_key    = "${var.aws_secret_key}"
  region        = "${var.aws_region}"
}

###############################
# Searching for Ubuntu Image
###############################
data "aws_ami" "ubuntu" {
  most_recent = true # If more than one result is returned, use the most recent AMI.

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

#######################################
# Searching for Default Security Group
#######################################
data "aws_security_groups" "default" {
  filter {
    name   = "group-name"
    values = ["*default*"]
  }
}

############################
# SSH Key registration
############################
resource "aws_key_pair" "public_key" {
  key_name   = "terraform-example"
  public_key = "${file("./templates/keys/terraform-example.pub")}"
}

###############################
# Configuration of EC2 Insance
###############################
resource "aws_instance" "instance" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "${var.instance_type}"
  key_name      = "${aws_key_pair.public_key.key_name}"

  vpc_security_group_ids  = ["${data.aws_security_groups.default.ids}"]
  availability_zone       = "${var.aws_region}a"

  associate_public_ip_address = true

  tags {
    Name = "Terraform Instance"
    Environment = "Development"
  }
}

###############################
# Export Public IP
###############################
output "instanceIP" {
  description = "Retunrns the Public IP of the EC2 instance."
  value       = "${aws_instance.instance.public_ip}"
}
