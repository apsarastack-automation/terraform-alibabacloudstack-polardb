# --- PolarDB Instance Module ---
# This module creates and manages PolarDB instances, databases, accounts, and connections.

module "instance" {
  source = "./modules/polardb_instance"

  name           = var.name
  db_instance_id = var.db_instance_id

  engine            = var.engine
  engine_version    = var.engine_version
  db_instance_class = var.db_instance_class
  storage           = var.storage
  storage_type      = var.storage_type

  vswitch_id   = var.vswitch_id
  security_ips = var.security_ips
  parameters   = var.parameters

  databases = var.databases
  accounts  = var.accounts

  use_account_database_binding = var.use_account_database_binding

  db_connection_prefix = var.db_connection_prefix
  port                 = var.port

  tags = var.tags

  # Encryption settings
  encryption     = var.encryption
  encryption_key = var.encryption_key
  tde_status     = var.tde_status
}

# --- PolarDB Backup Policy Module ---
# This module manages backup policy for an existing PolarDB instance.
# The db_instance_id is passed as a parameter - this module does NOT create instances.

module "backup_policy" {
  source = "./modules/polardb_backup_policy"

  count = var.backup_policy != null ? 1 : 0

  db_instance_id = module.instance.db_instance_id

  backup_retention_period     = var.backup_policy.backup_retention_period
  preferred_backup_period     = var.backup_policy.preferred_backup_period
  preferred_backup_time       = var.backup_policy.preferred_backup_time
  enable_backup_log           = var.backup_policy.enable_backup_log
  compress_type               = var.backup_policy.compress_type
  backup_policy_mode          = var.backup_policy.backup_policy_mode
  backup_log                  = var.backup_policy.backup_log
  high_space_usage_protection = var.backup_policy.high_space_usage_protection
  local_log_retention_hours   = var.backup_policy.local_log_retention_hours
  local_log_retention_space   = var.backup_policy.local_log_retention_space
  log_backup_retention_period = var.backup_policy.log_backup_retention_period

  depends_on = [module.instance]
}
