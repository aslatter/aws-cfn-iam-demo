
variable "aws_profile" {
  type = string
}

variable "aws_account_id" {
  type = string
}

provider "aws" {
  profile             = var.aws_profile
  allowed_account_ids = [var.aws_account_id]
  region              = "us-east-1"
}

resource "aws_cloudformation_stack" "iam" {
  name          = "iam-stack"
  capabilities  = ["CAPABILITY_NAMED_IAM"]
  template_body = file("./iam.template.yaml")
  parameters = {
    DeploymentRoleTrustPolicy = jsonencode({
      Version : "2012-10-17",
      Statement : [
        {
          Effect : "Allow",
          Principal : {
            AWS : "arn:aws:iam::${var.aws_account_id}:root"
          },
          Action : "sts:AssumeRole"
          Condition : {
            ArnLike : {
              "aws:PrincipalArn" : "arn:aws:iam::${var.aws_account_id}:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_AdministratorAccess_*"
            }
          }
        }
      ]
    })
  }
}
