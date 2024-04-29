data "aws_iam_policy_document" "instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "consul_policy" {
  name        = "aws-iampolicy-for-consul"
  path        = "/"
  description = "Policy for Consul"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:DescribeInstances"
        ],
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_role" "app_role" {
  name                = "${var.prefix}-role"
  assume_role_policy  = data.aws_iam_policy_document.instance_assume_role_policy.json
  managed_policy_arns = [
    aws_iam_policy.consul_policy.arn
  ]
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.prefix}-profile"
  role = aws_iam_role.app_role.name
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group_rule" "http_from_all" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = data.aws_security_group.default.id
}

resource "aws_security_group_rule" "https_from_all" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = data.aws_security_group.default.id
}

resource "aws_security_group_rule" "consul_ui_from_all" {
  type              = "ingress"
  from_port         = 8500
  to_port           = 8500
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = data.aws_security_group.default.id
}

resource "aws_security_group_rule" "ssh_from_ic" {
  type              = "ingress"
  description       = "AWS Instance Connect IP Address (ap-southeast-1)"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["3.0.5.32/29"]
  security_group_id = data.aws_security_group.default.id
}