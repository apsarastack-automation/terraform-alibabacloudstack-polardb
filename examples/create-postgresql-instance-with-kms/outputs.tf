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

output "engine" {
  description = "The database engine type."
  value       = "PolarDB_PG"
}

output "encryption_enabled" {
  description = "Whether encryption is enabled for the instance."
  value       = true
}

