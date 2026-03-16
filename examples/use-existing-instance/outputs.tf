output "db_instance_id" {
  description = "The ID of the PolarDB instance."
  value       = module.polardb.db_instance_id
}

output "database_names" {
  description = "List of created database names."
  value       = module.polardb.database_names
}

output "account_names" {
  description = "List of created account names."
  value       = module.polardb.account_names
}
