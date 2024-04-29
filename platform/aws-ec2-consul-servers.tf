resource "aws_instance" "consul_instance_1" {
  ami                         = "ami-015f72d56355ebc27"
  instance_type               = "t3.micro"
  vpc_security_group_ids      = [data.aws_security_group.default.id]
  subnet_id                   = aws_subnet.public_subnets[0].id
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.instance_profile.name

  tags = {
    Name                    = "${var.prefix}-consul-server-1"
    "consul-cluster-server" = true
  }

  user_data = templatefile("${path.module}/script/consul-server.tftpl", {})
}

resource "aws_instance" "consul_instance_2" {
  ami                         = "ami-015f72d56355ebc27"
  instance_type               = "t3.micro"
  vpc_security_group_ids      = [data.aws_security_group.default.id]
  subnet_id                   = aws_subnet.public_subnets[0].id
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.instance_profile.name

  tags = {
    Name                    = "${var.prefix}-consul-server-2"
    "consul-cluster-server" = true
  }

  user_data = templatefile("${path.module}/script/consul-server.tftpl", {})
}

resource "aws_instance" "consul_instance_3" {
  ami                         = "ami-015f72d56355ebc27"
  instance_type               = "t3.micro"
  vpc_security_group_ids      = [data.aws_security_group.default.id]
  subnet_id                   = aws_subnet.public_subnets[0].id
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.instance_profile.name

  tags = {
    Name                    = "${var.prefix}-consul-server-3"
    "consul-cluster-server" = true
  }

  user_data = templatefile("${path.module}/script/consul-server.tftpl", {})
}
