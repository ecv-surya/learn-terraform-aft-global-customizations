# Break Glass Access Role for Emergency Access from Management Account
resource "aws_iam_role" "break_glass_access" {
  name = "AFT-BreakGlassAccess"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_organizations_organization.current.master_account_id}:root"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name        = "AFT Break Glass Access Role"
    Purpose     = "Emergency access from management account"
    Environment = "AFT"
  }
}

# Attach AdministratorAccess policy for break glass scenarios
resource "aws_iam_role_policy_attachment" "break_glass_admin_access" {
  role       = aws_iam_role.break_glass_access.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}


# Data source to get organization information
data "aws_organizations_organization" "current" {}

