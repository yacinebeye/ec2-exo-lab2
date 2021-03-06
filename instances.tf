resource "aws_instance" "my_public_server" {
  ami                    = data.aws_ami.aws_basic_linux.id
  instance_type          = var.ec2_type
  subnet_id              = data.aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.my_public_app2_sg.id]
  key_name               = var.my_keypair

  tags = {
    Name = "public_server"
  }
}

resource "aws_instance" "my_private_server" {
  ami                    = data.aws_ami.aws_basic_linux.id
  instance_type          = var.ec2_type
  subnet_id              = data.aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.my_private_app2_sg.id]
  key_name               = var.my_keypair
  count                  = var.number_of_instances
  tags = {
    Name = "private_server_${count.index + 1}"
  }
}