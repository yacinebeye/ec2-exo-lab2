resource "aws_security_group" "my_public_app2_sg" {
  name        = "my_public_app2_sg"
  description = "allow access to the server"
  vpc_id      = data.aws_vpc.main_vpc.id

  #INBOUND CONNECTIONS 
  ingress {
    description = "allow ssh into the EC2"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP into the EC2"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  #OUTBOUND CONNECTIONS
  egress {
    description = "allow acces to the world"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # TCP + UDP
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "my_private_app2_sg" {
  name        = "my_private_app2_sg"
  description = "allow access to the server"
  vpc_id      = data.aws_vpc.main_vpc.id

  #INBOUND CONNECTIONS 
  ingress {
    description = "allow ssh only to the public subnet private instance"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["192.168.1.0/24"]
  }

  #OUTBOUND CONNECTIONS
  egress {
    description = "allow acces to the world"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # TCP + UDP
    cidr_blocks = ["0.0.0.0/0"]
  }
}