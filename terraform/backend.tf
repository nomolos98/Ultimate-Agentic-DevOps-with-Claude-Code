# Terraform state backend configuration
#
# INITIAL SETUP:
# 1. First run: terraform init (without this backend block enabled)
# 2. Run: terraform apply (to create the S3 bucket and other resources)
# 3. Then uncomment the backend block below
# 4. Finally run: terraform init -migrate-state (to migrate state to S3)
#
# This approach ensures the state bucket is created before Terraform tries to use it.

# terraform {
#   backend "s3" {
#     bucket         = "portfolio-site-terraform-state-ACCOUNT-ID"
#     key            = "portfolio-site/terraform.tfstate"
#     region         = "ap-south-1"
#     encrypt        = true
#     dynamodb_table = "terraform-locks"
#   }
# }
