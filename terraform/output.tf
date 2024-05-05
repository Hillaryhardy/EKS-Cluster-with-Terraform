# creating an output to fetch server IP
output "ec2_public_ip" {
  value = aws_instance.htapp-server.public_ip
}