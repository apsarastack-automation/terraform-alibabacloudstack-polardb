module "polardb" {
  source = "../../modules/polardb_instance"

  name           = var.name
  engine         = var.engine
  engine_version = var.engine_version
  vswitch_id     = var.vswitch_id

  security_ips = var.security_ips

  databases            = var.databases
  accounts             = var.accounts
  db_connection_prefix = var.db_connection_prefix
  port                 = var.port

  tags = var.tags
}
