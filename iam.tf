// Role
resource "aws_iam_role" "rampup_role" {
  name = "rampup-role"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version"  : "2012-10-17",
    "Statement": [
        {
            "Action"   : "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid"   : ""
        }
    ]
}
EOF
  tags = {
    tag-key = "rampup-role"
  }
}

// Policy
resource "aws_iam_policy" "rampup_policy" {
  name        = "rampup-policy"
  path        = "/"
  description = "Policy for RampUp instance, access to s3 bucket"

  policy = <<EOF
{
  "Version"  : "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:ListBucket"
      ],
      "Effect"  : "Allow",
      "Resource": [
        "arn:aws:s3:::${var.bucket_name}"
        ]
    },
    {
      "Action": [
        "s3:GetObject",
        "s3:PutObject"
      ],
      "Effect"  : "Allow",
      "Resource": [
        "arn:aws:s3:::${var.bucket_name}/*"
        ]
    }
  ]
}
EOF
}

// Attach policy to role
resource "aws_iam_policy_attachment" "rampup_attach_policy" {
  name       = "rampup-attach-policy"
  roles      = ["${aws_iam_role.rampup_role.name}"]
  policy_arn = "${aws_iam_policy.rampup_policy.arn}"
}

// Instance Profile
resource "aws_iam_instance_profile" "rampup_instance_profile" {
  name = "rampup-instance-profile"
  role = "${aws_iam_role.rampup_role.name}"
}
