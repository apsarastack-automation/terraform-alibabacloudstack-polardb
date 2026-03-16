# --- Data Sources ---

data "alibabacloudstack_polardb_dbinstances" "default" {
  ids = [coalesce(var.db_instance_id, "fake_id")]
}

data "alibabacloudstack_zones" "default" {
  available_resource_creation = "VSwitch"
}

data "alibabacloudstack_polardb_instance_types" "anyone" {
  engine    = var.engine
  sorted_by = "CPU"
}

# --- Locals ---

locals {
  # Determine if we need to create a new instance
  create_instance = var.db_instance_id == ""

  # Get the zone ID
  zone_id = data.alibabacloudstack_zones.default.zones[0].id

  instance_id = local.create_instance ? alibabacloudstack_polardb_dbinstance.default.0.id : var.db_instance_id

  db_instance_class = var.db_instance_class != "" ? var.db_instance_class : data.alibabacloudstack_polardb_instance_types.anyone.instance_types[0].id
  storage_type      = var.storage_type != "" ? var.storage_type : data.alibabacloudstack_polardb_instance_types.anyone.instance_types[0].storage_type

}

# --- PolarDB Instance Resource ---
# This module creates and manages PolarDB instances.
# For backup policy management, use the polardb_backup_policy module separately.

resource "alibabacloudstack_polardb_dbinstance" "default" {
  count = local.create_instance ? 1 : 0

  instance_name            = var.name
  engine                   = var.engine
  engine_version           = var.engine_version
  db_instance_class        = local.db_instance_class
  db_instance_storage_type = local.storage_type
  db_instance_storage      = var.storage
  vswitch_id               = var.vswitch_id
  zone_id                  = local.zone_id
  security_ips             = var.security_ips
  tags                     = var.tags

  # Encryption settings
  encryption     = var.encryption
  encryption_key = var.encryption_key != "" ? var.encryption_key : null
  tde_status     = var.tde_status != "" ? var.tde_status : null
}

# --- PolarDB Database Resources ---

resource "alibabacloudstack_polardb_database" "default" {
  for_each = var.databases

  data_base_instance_id = local.instance_id
  data_base_name        = each.key
  character_set_name    = each.value.character_set_name
  data_base_description = each.value.description

  depends_on = [alibabacloudstack_polardb_dbinstance.default]
}

# --- PolarDB Account Resources ---

resource "alibabacloudstack_polardb_account" "default" {
  for_each = var.accounts

  data_base_instance_id = local.instance_id
  account_name          = each.key
  account_password      = each.value.password
  account_type          = each.value.account_type

  depends_on = [alibabacloudstack_polardb_dbinstance.default]
}

# --- PolarDB Account Database Binding Resources (Alternative to Account Privilege) ---

resource "alibabacloudstack_polardb_account_database_binding" "default" {
  for_each = var.use_account_database_binding ? var.accounts : {}

  db_instance_id = local.create_instance ? alibabacloudstack_polardb_dbinstance.default[0].id : var.db_instance_id
  account_name   = each.key

  dynamic "database_privileges" {
    for_each = each.value.account_privileges
    content {
      db_name   = database_privileges.key
      privilege = database_privileges.value
    }
  }

  depends_on = [
    alibabacloudstack_polardb_account.default,
    alibabacloudstack_polardb_database.default
  ]
}

# --- PolarDB Connection Resource ---

resource "alibabacloudstack_polardb_dbconnection" "default" {
  count = var.db_connection_prefix != "" ? 1 : 0

  instance_id       = local.create_instance ? alibabacloudstack_polardb_dbinstance.default[0].id : var.db_instance_id
  connection_prefix = var.db_connection_prefix
  port              = var.port

  depends_on = [alibabacloudstack_polardb_dbinstance.default]
}
