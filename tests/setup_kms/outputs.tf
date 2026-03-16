output "kms_key_id" {
  description = "The ID of the created KMS key."
  value       = alibabacloudstack_kms_key.default.id
}

output "kms_key_arn" {
  description = "The ARN of the created KMS key."
  value       = alibabacloudstack_kms_key.default.arn
}
