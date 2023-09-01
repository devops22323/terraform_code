# Creating custom VPC
resource "aws_vpc" "ntier" {
    cidr_block = var.vpc_cidr_range
    tags = {
    "Name" = "Ntier-VPC"
  }
  
}

### Creating Public Subnets
resource "aws_subnet" "public_subnets" {
  count             = length(var.public_subnets_cidr)
  vpc_id            = aws_vpc.ntier.id
  cidr_block        = element(var.public_subnets_cidr, count.index)
  availability_zone = element(var.azs, count.index)
 
  tags = {
   Name = "Public Subnet - ${count.index + 1}"
 }
}


### Creating Private Subnets
resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnets_cidr)
  vpc_id            = aws_vpc.ntier.id
  cidr_block        = element(var.private_subnets_cidr, count.index)
  availability_zone = element(var.azs, count.index)
 
  tags = {
   Name = "Private Subnet - ${count.index + 1}"
 }
}

### Creating an IGW and attach to VPC
resource "aws_internet_gateway" "ntier_igw" {
  vpc_id = aws_vpc.ntier.id
  tags = {
    Name = "Ntier-IGW"
  }
}

### Creating a SG for Webservers
# Create Security Group - Web Traffic
resource "aws_security_group" "web-sg" {
  name        = "web-sg"
  ingress {
    description = "Allow Port 22"
    from_port   = local.ssh_port
    to_port     = local.ssh_port
    protocol    = local.tcp
    cidr_blocks = [ local.any_where ]
  }
  ingress {
    description = "Allow Port 80"
    from_port   = local.http_port
    to_port     = local.http_port
    protocol    = local.tcp
    cidr_blocks = [ local.any_where ]
  }
  ingress {
    description = "Allow Port 443"
    from_port   = local.https_port
    to_port     = local.https_port
    protocol    = local.tcp
    cidr_blocks = [ local.any_where]
  }  
  egress {
    description = "Allow all ip and ports outbound"    
    from_port   = local.all_ports
    to_port     = local.all_ports
    protocol    = local.any_protocol
    cidr_blocks = [ local.any_where]
  }

  tags = {
    Name = "web-sg"
  }
}

# Launch Configuration for ASG
resource "aws_launch_configuration" "web-instance-lc" {
  name_prefix   = "web-instance-lc"
  image_id      = "ami-0ccbb4123e662e194" # Ubuntu AMI from ap-southeast-4
  instance_type = "t3.micro"
  key_name = var.instance_keypair
  security_groups = [ "aws_security_group.web-sg.id" ]
  user_data     = <<-EOF
              #!/bin/bash
              apt install -y nginx
              echo "Hello World" > /var/www/html/index.html
              service nginx start
              EOF
}

# Auto Scaling Group
resource "aws_autoscaling_group" "web-asg" {
  name                 = "web-asg"
  # Attach ASG to public subnets for external access
  availability_zones = [ "ap-southeast-4a" ]
  launch_configuration = aws_launch_configuration.web-instance-lc.name
  min_size             = 2
  max_size             = 4
  desired_capacity     = 2
  
  tag {
    key                 = "Name"
    value               = "Asg-web-instance"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}


