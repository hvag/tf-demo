/**
 * Terraform Demo
 * By: Mark
 */

terraform {
    backend "s3" {
        bucket  = "hvag-tfdemo-state"
        region  = "us-east-1"
        key     = "east/terraform.tfstate"
        encrypt = "true"
    }
}
