################
# EC2 Instance #
################
resource "aws_instance" "ubuntu-server" {
  ami           = var.aws_ami
  instance_type = "t3.micro"
  key_name      = "ec2-key-home-task"
  user_data     = file("${path.module}/ansible-linux-dist.sh")
  tags = {
    Name = "ubuntu"
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.ubuntu-server.public_dns} > ./modules/ec2/inventory"
  }
}
output "ip" {
  value = aws_instance.ubuntu-server.public_ip
}

output "publicName" {
  value = aws_instance.ubuntu-server.public_dns
}

###################
# Security Groups #
###################
resource "aws_security_group" "ec2_sg" {
  name   = "ec2_sg"
  vpc_id = var.vpc_id

  ingress {
    description = "HTTP port"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "ssh port"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS port"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "HTTPS port"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "HTTP port"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2_sg"
  }
}