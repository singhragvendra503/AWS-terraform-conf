# Create Aws key-pairs
resource "aws_key_pair" "key-tf" {
  key_name   = "key-tf"
  public_key = file("~/.ssh/id_rsa.pub")
}
# Create AWS security group
resource "aws_security_group" "demo-tf" {
  name        = "demo-tf"
  description = "Create security group using tf"
  dynamic "ingress" {
    for_each = var.ports
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
# Filter ami dynamically
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["${var.image_name}"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
# Create Aws instance  
resource "aws_instance" "web_server" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = var.instance_type
  key_name        = "key-tf"
  security_groups = ["demo-tf"]
  tags = {
    Name = "web_server"
  }
}