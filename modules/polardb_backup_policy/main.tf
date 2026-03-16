# --- PolarDB Backup Policy Resource ---
# This module manages backup policy for an existing PolarDB instance.
# The db_instance_id must be provided as a parameter - this module does NOT create instances.

resource "alibabacloudstack_polardb_backuppolicy" "default" {
  db_instance_id              = var.db_instance_id
  backup_retention_period     = var.backup_retention_period
  preferred_backup_period     = var.preferred_backup_period
  preferred_backup_time       = var.preferred_backup_time
  enable_backup_log           = var.enable_backup_log
  compress_type               = var.compress_type
  backup_policy_mode          = var.backup_policy_mode
  backup_log                  = var.backup_log
  high_space_usage_protection = var.high_space_usage_protection
  local_log_retention_hours   = var.local_log_retention_hours
  local_log_retention_space   = var.local_log_retention_space
  log_backup_retention_period = var.log_backup_retention_period
}
