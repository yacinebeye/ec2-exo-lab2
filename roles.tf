
# CREATE POLICIES:
# POLICY 1 == Assume Role

data "aws_iam_policy_document" "instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# CREATE A ROLE
resource "aws_iam_role" "dashboard_server_role" {
  name               = "dashboard_server_role"
  assume_role_policy = data.aws_iam_policy_document.instance_assume_role_policy.json
}


# POLICY 2 == PERMISSIONS TO ACCES SUBNETS AND INSTANCES
data "aws_iam_policy_document" "list_instances_and_subnets_doc" {
  statement {
    sid = "1"

    actions = [
      "ec2:DescribeInstances",
      "ec2:DescribeSubnets"
    ]

    resources = [
      "*"
    ]
  }
}
resource "aws_iam_policy" "list_instances_and_subnets" {
  name        = "List-all-instances-policy"
  description = "List all instances and subnets for the dashboard"
  policy      = data.aws_iam_policy_document.list_instances_and_subnets_doc.json
}

# ATTACH ALL POLICIES TO THE ROLE 
resource "aws_iam_role_policy_attachment" "list_instances_attch" {
  role       = aws_iam_role.dashboard_server_role.name
  policy_arn = aws_iam_policy.list_instances_and_subnets.arn
}

# CREATE AN INSTANCE PROFILE FROM THAT ROLE
resource "aws_iam_instance_profile" "dashboard_server_profile" {
  role = aws_iam_role.dashboard_server_role.name
}

# ATTACH THE INSTANCE PROFILE TO THE PUBLIC INSTANCE 