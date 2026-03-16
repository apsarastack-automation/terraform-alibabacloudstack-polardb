variable "db_instance_id" {
  description = "The ID of an existing PolarDB instance."
  type        = string
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
