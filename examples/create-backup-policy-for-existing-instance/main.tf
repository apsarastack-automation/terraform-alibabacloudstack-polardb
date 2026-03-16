# This example demonstrates how to create a backup policy for an existing PolarDB instance.
# The db_instance_id is passed as a parameter - this module does NOT create the instance.

module "backup_policy" {
  source = "../../modules/polardb_backup_policy"

  db_instance_id = var.db_instance_id

  backup_retention_period = var.backup_retention_period
  preferred_backup_period = var.preferred_backup_period
  preferred_backup_time   = var.preferred_backup_time
  enable_backup_log       = var.enable_backup_log
  compress_type           = var.compress_type
}
