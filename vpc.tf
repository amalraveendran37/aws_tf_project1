# creating vpc 
resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "my_vpc"
  }
}

# public subnet

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.0.0/26"
  map_public_ip_on_launch = true
  tags = {
    name = "my_public_subnet"
  }
  availability_zone = "us-east-1a"
}

#public subnet 2
resource "aws_subnet" "public_subnet_2" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "10.0.0.64/26"
  map_public_ip_on_launch = true
  tags = {
    name= "my_public_subnet_2"
  }
  availability_zone = "us-east-1b"
}

# private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.0.128/25"
  tags = {
    name = "my_private_subnet"
  }
}

# public route table
resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    name = "public_route_table"

  }
}

# private routetable
resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    name = "private_route_table"
  }
}
# public routetable association
resource "aws_route_table_association" "public_routetable_association" {
  route_table_id = aws_route_table.public_route.id
  subnet_id      = aws_subnet.public_subnet.id
}
# public routetable 2 association
resource "aws_route_table_association" "public_routetable_association_2" {
  route_table_id = aws_route_table.public_route.id
  subnet_id      = aws_subnet.public_subnet_2.id
}

#private routetable association
resource "aws_route_table_association" "private_routetable_association" {
  route_table_id = aws_route_table.private_route.id
  subnet_id      = aws_subnet.private_subnet.id

}

# internet gateway

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    name = "internet_gateway"
  }

}

# public route
resource "aws_route" "public_route_rule" {
  route_table_id         = aws_route_table.public_route.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gateway.id
}

#private route
resource "aws_route" "private_route_rule" {
  route_table_id         = aws_route_table.private_route.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id

}

#nat gateway
resource "aws_nat_gateway" "nat_gateway" {
  subnet_id = aws_subnet.private_subnet.id
  allocation_id = aws_eip.project_elastic_ip.id
  depends_on = [ aws_eip.project_elastic_ip ]
}

#elastic ip
resource "aws_eip" "project_elastic_ip" {
  domain = "vpc"

  
}