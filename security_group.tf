#security group creation
resource "aws_security_group" "project_security_group" {
  name   = "project_security_group"
  vpc_id = aws_vpc.myvpc.id
   ingress {
    to_port     = 80
    from_port   = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    to_port     = 0
    from_port   = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
    
  }
}
