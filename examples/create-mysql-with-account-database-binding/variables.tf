variable "name" {
  description = "The name of the PolarDB MySQL instance."
  type        = string
}

variable "engine_version" {
  description = "The MySQL engine version."
  type        = string
  default     = "8.0"
}

variable "vswitch_id" {
  description = "The ID of the VSwitch for network configuration."
  type        = string
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
  description = "Map of accounts to create with database privileges."
  type = map(object({
    password           = string
    account_type       = optional(string, "Normal")
    account_privileges = optional(map(string), {})
  }))
  default = {}
}

variable "tags" {
  description = "Tags to assign to the resources."
  type        = map(string)
  default     = {}
}
