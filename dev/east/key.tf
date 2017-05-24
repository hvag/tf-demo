/**
 * Terraform Demo
 * By: Mark
 */

resource "aws_key_pair" "TF-Demo-Dev-Key" {
    key_name = "TF-Demo-Dev-Key"
    public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}
