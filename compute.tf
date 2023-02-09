resource "aws_key_pair" "sshkey" {
  key_name   = "ssh-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC4gm9LiqaYQO6ey20UyrdpzZUXn/Zt8V6GVzZ/0EtK+/lK4rvLz7siL45qdu4tGDiv++9+WDXosaYKTu/MgGBlVlfuABGrkUa05Ir/uLfTO5AVPI5iIkyvDlXNoDijZMSUuM4NuqMDK3sh6B8LkFgnDbP0v+raB1D8FIqHl2l6dk1SkXMErdHtAncA3ZnzfeRwFmDNH1JaOOlCEd5wLElDSYcFKJCUxpq+/oJfiS7kjM3na6ebldIJWztKGLuGIwmVaa+Y6IS8earKmlghLj7PSuZRTfeKdCpEJRKe1NiU0GW0N54lbYD131jZAQs3p6hpyPl+czetTUDC7nyWlqqf vscode@53a5ef772c35"
}


resource "aws_network_interface" "eni" {
  count       = 3
  subnet_id   = aws_subnet.subnet[count.index].id
  private_ips = [cidrhost(var.subnet_cidr[count.index], 5)]

  tags = {
    Name = var.tag[count.index]
  }
}

resource "aws_eip" "pip" {
  count                     = 2
  vpc                       = true
  network_interface         = aws_network_interface.eni[count.index].id
  associate_with_private_ip = cidrhost(var.subnet_cidr[count.index], 5)
  depends_on = [
    aws_instance.ec2
  ]

}



resource "aws_instance" "ec2" {
  count         = 3
  ami           = "ami-04bad3c587fe60d89"
  instance_type = "t2.micro"
  key_name      = "ssh-key"

  network_interface {
    network_interface_id = aws_network_interface.eni[count.index].id
    device_index         = 0
  }

  tags = {
    Name = "${var.tag[count.index]}-server"
  }

}

# route table assosiation

resource "aws_route_table_association" "rt" {
  count =2
  subnet_id      = aws_subnet.subnet[count.index].id
  route_table_id = aws_route_table.rt.id
}

# scurity group assosiation for jumphost

resource "aws_network_interface_sg_attachment" "jumphost" {
  security_group_id    = aws_security_group.jumphost_inbound.id
  network_interface_id = aws_instance.ec2[0].primary_network_interface_id
}

# scurity group assosiation for jumphost

resource "aws_network_interface_sg_attachment" "webserver" {
  security_group_id    = aws_security_group.web_inbound.id
  network_interface_id = aws_instance.ec2[1].primary_network_interface_id
}