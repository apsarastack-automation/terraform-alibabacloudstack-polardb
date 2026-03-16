# --- Instance Outputs ---

output "db_instance_id" {
  description = "The ID of the PolarDB instance."
  value       = module.instance.db_instance_id
}

output "connection_string" {
  description = "The connection string of the PolarDB instance."
  value       = module.instance.connection_string
}

output "port" {
  description = "The database connection port."
  value       = module.instance.port
}

output "database_names" {
  description = "List of created database names."
  value       = module.instance.database_names
}

output "account_names" {
  description = "List of created account names."
  value       = module.instance.account_names
}

# --- Backup Policy Outputs ---

output "backup_policy_applied" {
  description = "Whether the backup policy was applied."
  value       = var.backup_policy != null ? module.backup_policy[0].backup_policy_applied : false
}

output "backup_retention_period" {
  description = "The retention period of data backup files."
  value       = var.backup_policy != null ? module.backup_policy[0].backup_retention_period : null
}

output "preferred_backup_period" {
  description = "The backup cycle."
  value       = var.backup_policy != null ? module.backup_policy[0].preferred_backup_period : null
}

output "preferred_backup_time" {
  description = "The backup time."
  value       = var.backup_policy != null ? module.backup_policy[0].preferred_backup_time : null
}
