output "public_ip_of_demo_server" {
    description = "this is the public ip"
    value = aws_instance.demo-server.public_ip
}
output "private_ip_of_demo_server" {
    description = "this is the private ip"
    value = aws_instance.demo-server.private_ip
} 