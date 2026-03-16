variable "name" {
  description = "The name of the PolarDB instance."
  type        = string
}

variable "engine" {
  description = "The database engine type."
  type        = string
  default     = "MySQL"
}

variable "engine_version" {
  description = "The database engine version."
  type        = string
  default     = "8.0"
}

variable "security_ips" {
  description = "List of security IPs that are allowed to access the instance."
  type        = list(string)
  default     = []
}

variable "databases" {
  description = "Map of databases to create."
  type = map(object({
    character_set_name = optional(string, "utf8mb4")
    description        = optional(string, "")
  }))
  default = {}
}

variable "accounts" {
  description = "Map of accounts to create."
  type = map(object({
    password           = string
    account_type       = optional(string, "Normal")
    account_privileges = optional(map(string), {})
  }))
  default = {}
}

variable "db_connection_prefix" {
  description = "The connection prefix for the database connection."
  type        = string
  default     = ""
}

variable "port" {
  description = "The port number for the database connection."
  type        = number
  default     = 3306
}

variable "tags" {
  description = "Tags to assign to the resources."
  type        = map(string)
  default     = {}
}

variable "vswitch_id" {
  type = string
}