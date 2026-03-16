output "db_instance_id" {
  description = "The ID of the PolarDB instance for which the backup policy is configured."
  value       = var.db_instance_id
}

output "backup_policy_applied" {
  description = "Whether the backup policy was applied."
  value       = true
}

output "backup_retention_period" {
  description = "The retention period of data backup files."
  value       = var.backup_retention_period
}

output "preferred_backup_period" {
  description = "The backup cycle."
  value       = var.preferred_backup_period
}

output "preferred_backup_time" {
  description = "The backup time."
  value       = var.preferred_backup_time
}

output "enable_backup_log" {
  description = "Whether log backup is enabled."
  value       = var.enable_backup_log
}

output "compress_type" {
  description = "The backup compression method."
  value       = var.compress_type
}
