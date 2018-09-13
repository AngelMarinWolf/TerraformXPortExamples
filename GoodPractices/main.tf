############################
# Configure the AWS Provider
############################
provider "aws" {
  access_key    = "${var.aws_access_key}"
  secret_key    = "${var.aws_secret_key}"
  region        = "${var.aws_region}"
}

############################
# SSH Key registration
############################
resource "aws_key_pair" "public_key" {
  key_name   = "terraform-example"
  /*
  the keyword "file" allows import any kind of file into the
  terraform script, in this case is importing the public key
  that will be registered on AWS as a Key pair.
  */
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

  /*
  inside of this bloc you can add as much tags as you want and be applied
  to the instance. Almost the resourses blocks allows allocate tags.
  */
  tags {
    Name = "Terraform Instance"
    Environment = "Development"
  }
}
