resource "aws_instance" "consul_client_frontend_1" {
  ami                         = "ami-015f72d56355ebc27"
  instance_type               = "t3.micro"
  vpc_security_group_ids      = [data.aws_security_group.default.id]
  subnet_id                   = aws_subnet.public_subnets[0].id
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.instance_profile.name

  tags = {
    Name                    = "${var.prefix}-consul-client-frontend-1"
    "consul-cluster-server" = true
  }

  user_data = templatefile("${path.module}/script/consul-client-frontend.tftpl", {
    INSTANCE_NAME = "${var.prefix}-consul-client-frontend-1"
  })
}

resource "aws_instance" "consul_client_backend_1" {
  ami                         = "ami-015f72d56355ebc27"
  instance_type               = "t3.micro"
  vpc_security_group_ids      = [data.aws_security_group.default.id]
  subnet_id                   = aws_subnet.public_subnets[0].id
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.instance_profile.name

  tags = {
    Name                    = "${var.prefix}-consul-client-backend-1"
    "consul-cluster-server" = true
  }

  user_data = templatefile("${path.module}/script/consul-client-backend.tftpl", {
    INSTANCE_NAME = "${var.prefix}-consul-client-backend-1"
  })
}
