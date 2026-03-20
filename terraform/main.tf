provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_security_group" "web_sg" {
  name = "web-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami           = "ami-0ba8d27d35e9915fb"
  instance_type = "t3.micro"
  key_name      = "Docker-key"

  security_groups = [aws_security_group.web_sg.name]

  tags = {
    Name = "DevOps-Project-Server"
  }
}

output "public_ip" {
  value = aws_instance.web.public_ip
}
