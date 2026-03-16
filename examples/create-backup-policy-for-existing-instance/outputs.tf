output "db_instance_id" {
  description = "The ID of the PolarDB instance."
  value       = module.backup_policy.db_instance_id
}

output "backup_policy_applied" {
  description = "Whether the backup policy was applied."
  value       = module.backup_policy.backup_policy_applied
}

output "backup_retention_period" {
  description = "The retention period of data backup files."
  value       = module.backup_policy.backup_retention_period
}

output "preferred_backup_period" {
  description = "The backup cycle."
  value       = module.backup_policy.preferred_backup_period
}

output "preferred_backup_time" {
  description = "The backup time."
  value       = module.backup_policy.preferred_backup_time
}
