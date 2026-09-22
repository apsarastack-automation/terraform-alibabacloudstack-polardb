output "db_instance_id" {
  description = "The ID of the PolarDB instance."
  value       = local.create_instance ? alibabacloudstack_polardb_dbinstance.default[0].id : var.db_instance_id
}

output "instance_name" {
  description = "The description (name) of the PolarDB instance."
  value       = local.create_instance ? alibabacloudstack_polardb_dbinstance.default[0].db_instance_description : var.name
}

output "connection_string" {
  description = "The connection string of the PolarDB instance."
  value       = length(alibabacloudstack_polardb_dbconnection.default) > 0 ? alibabacloudstack_polardb_dbconnection.default[0].connection_string : null
}

output "port" {
  description = "The database connection port."
  value       = var.port
}

output "database_names" {
  description = "List of created database names."
  value       = keys(alibabacloudstack_polardb_database.default)
}

output "account_names" {
  description = "List of created account names."
  value       = keys(alibabacloudstack_polardb_account.default)
}

output "vswitch_id" {
  description = "The ID of the VSwitch used by the instance."
  value       = var.vswitch_id
}

