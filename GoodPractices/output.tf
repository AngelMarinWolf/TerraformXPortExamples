###############################
# Export Public IP
###############################
output "instanceIP" {
  description = "Retunrns the Public IP of the EC2 instance."
  value       = "${aws_instance.instance.public_ip}"
}
