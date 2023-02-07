resource "aws_key_pair" "sshkey" {
  key_name   = "ssh-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC4gm9LiqaYQO6ey20UyrdpzZUXn/Zt8V6GVzZ/0EtK+/lK4rvLz7siL45qdu4tGDiv++9+WDXosaYKTu/MgGBlVlfuABGrkUa05Ir/uLfTO5AVPI5iIkyvDlXNoDijZMSUuM4NuqMDK3sh6B8LkFgnDbP0v+raB1D8FIqHl2l6dk1SkXMErdHtAncA3ZnzfeRwFmDNH1JaOOlCEd5wLElDSYcFKJCUxpq+/oJfiS7kjM3na6ebldIJWztKGLuGIwmVaa+Y6IS8earKmlghLj7PSuZRTfeKdCpEJRKe1NiU0GW0N54lbYD131jZAQs3p6hpyPl+czetTUDC7nyWlqqf vscode@53a5ef772c35"
}


resource "aws_network_interface" "eni" {
  count =3
  subnet_id   = aws_subnet.subnet[count.index].id
  private_ips = cidrhost("${var.subnet_cidr[count.index]}", 5)

 }

# resource "aws_eip" "pip" {
#   vpc                       = true
#   network_interface         = aws_network_interface.frontend.id
#   associate_with_private_ip = "10.10.0.6"
#   depends_on = [
#     aws_instance.frontend
#   ]
# }



# resource "aws_instance" "frontend" {
#   ami           = "ami-04bad3c587fe60d89"
#   instance_type = "t2.micro"
#   key_name      = "ssh-key"

#   network_interface {
#     network_interface_id = aws_network_interface.frontend.id
#     device_index         = 0
#   }

# }

# # route table assosiation

# resource "aws_route_table_association" "rt" {
#   subnet_id      = aws_subnet.frontend_subnet.id
#   route_table_id = aws_route_table.rt.id
# }

# # scurity group assosiation

# resource "aws_network_interface_sg_attachment" "sg_attachment" {
#   security_group_id    = aws_security_group.allow_inbound.id
#   network_interface_id = aws_instance.frontend.primary_network_interface_id
# }