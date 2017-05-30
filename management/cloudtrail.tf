/**
 * Terraform Demo
 * By: Mark
 */

resource "aws_cloudtrail" "hvag-cloudtrail" {
    name                          = "hvag-cloudtrail"
    s3_bucket_name                = "${aws_s3_bucket.hvag-cloudtrail.id}"
    s3_key_prefix                 = "tf-demo"
    include_global_service_events = true
    is_multi_region_trail         = true
    enable_log_file_validation    = true
}


resource "aws_s3_bucket" "hvag-cloudtrail" {
    bucket        = "hvag-cloudtrail"
    force_destroy = true

    policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [

        {
            "Sid": "AWSCloudTrailAclCheck",
            "Effect": "Allow",
            "Principal": { "Service": "cloudtrail.amazonaws.com" },
            "Action": "s3:GetBucketAcl",
            "Resource": "arn:aws:s3:::hvag-cloudtrail"
        },

        {
            "Sid": "AWSCloudTrailWrite",
            "Effect": "Allow",
            "Principal": { "Service": "cloudtrail.amazonaws.com" },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::hvag-cloudtrail/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        }

    ]
}
POLICY
}
