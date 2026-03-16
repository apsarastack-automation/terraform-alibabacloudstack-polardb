module "polardb" {
  source = "../../modules/polardb_instance"

  name           = var.name
  engine         = "MySQL"
  engine_version = var.engine_version
  vswitch_id     = var.vswitch_id

  security_ips = var.security_ips

  # Enable account_database_binding for privilege management
  use_account_database_binding = true

  # Create databases
  databases = var.databases

  # Create accounts with privileges
  accounts = var.accounts

  tags = var.tags
}
