
variable "prefix" {
  type        = string
  description = "string used to prefix resource names and identify the project a resource belongs to"
}

variable "approved_arns" {
  type = list(string)
}

variable "enable_dynamodb" {
  type    = bool
  default = true
}

variable "force_destroy" {
  type    = bool
  default = false
}

output "bucket" {
  value = aws_s3_bucket.state.bucket
}

output "lock_tables" {
  value = { for k, v in aws_dynamodb_table.locking : k => v.arn }
}
