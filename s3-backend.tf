/**
 * Terraform Test
 * By: Mark
 */

terraform {
    backend "s3" {
        bucket = "hvag-tfdemo-state"
        key    = "terraform.tfstate"
        region = "us-east-1"
    }
}
