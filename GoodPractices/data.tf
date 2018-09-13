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
  /*
  The next filter will search for all the security groups
  that match wiht the word "default" and will create an
  object wiht the data of them.
  */
  filter {
    name   = "group-name"
    values = ["*default*"]
  }
}
