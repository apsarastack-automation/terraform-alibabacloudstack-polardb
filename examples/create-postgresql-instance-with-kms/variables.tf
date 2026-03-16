variable "name" {
  description = "The name of the PolarDB PostgreSQL instance."
  type        = string
}

variable "engine_version" {
  description = "The PostgreSQL engine version."
  type        = string
  default     = "14"
}

variable "engine" {
  description = "The PostgreSQL engine version."
  type        = string
  default     = "PolarDB_PG"
}

variable "vswitch_id" {
  description = "The ID of the VSwitch for network configuration."
  type        = string
}

variable "encryption_key" {
  description = "The key ID of the disk encryption in the same region. This parameter indicates that cloud disk encryption is enabled."
  type        = string
}

variable "tde_status" {
  type    = bool
  default = false
}


variable "security_ips" {
  description = "List of security IPs that are allowed to access the instance."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to assign to the resources."
  type        = map(string)
  default     = {}
}
