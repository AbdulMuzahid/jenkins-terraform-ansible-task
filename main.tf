  tags = {
    Name = "my-elastic-ip-007"
  }
}
resource "aws_instance" "ec2-ec2_ubuntuServer" {
  ami           = "ami-075449515af5df0d1"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.subnet.id
  security_groups = [aws_security_group.my_sg.id]
  key_name = "Linux-Testing"
  tags = {
    Name = "ec2_ubuntuServer"
  }
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install apache2 -y
              sudo systemctl enable apache2
              sudo systemctl start apache2
              EOF
  }
  resource "aws_s3_bucket" "s3_bucket" {
 bucket = "s3terraform129"
    acl = "private"
  }
resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = "terraform-state-lock"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20
 attribute {
  name = "LockID"
    type = "S"
  }
}
terraform {
  backend "s3" {
    bucket = "s3terraform129"
    dynamodb_table = "terraform-state-lock"
    key    = "terraform.tfstate"
    region = "eu-north-1"
  }
}
