module "polardb" {
  source = "../../modules/polardb_instance"

  db_instance_id = var.db_instance_id

  databases = var.databases
  accounts  = var.accounts
}
