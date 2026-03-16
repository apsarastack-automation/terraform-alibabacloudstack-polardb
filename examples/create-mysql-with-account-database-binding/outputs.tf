output "db_instance_id" {
  description = "The ID of the PolarDB instance."
  value       = module.polardb.db_instance_id
}

output "connection_string" {
  description = "The connection string of the PolarDB instance."
  value       = module.polardb.connection_string
}

output "port" {
  description = "The database connection port."
  value       = module.polardb.port
}

output "database_names" {
  description = "List of created database names."
  value       = module.polardb.database_names
}

output "account_names" {
  description = "List of created account names."
  value       = module.polardb.account_names
}

output "binding_mode" {
  description = "The mode used for account-database privilege binding."
  value       = "account_database_binding"
}
