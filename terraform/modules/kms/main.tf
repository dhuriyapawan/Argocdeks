# modules/kms/main.tf

resource "aws_kms_key" "main" {
  description             = "KMS Key for ${var.environment} environment"
  deletion_window_in_days = var.deletion_window_in_days
  enable_key_rotation     = true

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Id": "key-default-policy",
  "Statement": [
    {
      "Sid": "Enable IAM User Permissions",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${var.account_id}:root"
      },
      "Action": "kms:*",
      "Resource": "*"
    }
  ]
}
EOF

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-kms-key"
    }
  )
}

resource "aws_kms_alias" "main" {
  name          = "alias/${var.environment}-key"
  target_key_id = aws_kms_key.main.key_id
}
