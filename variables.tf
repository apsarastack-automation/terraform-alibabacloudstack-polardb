variable "name" {
  description = "The name of the PolarDB instance."
  type        = string
  default     = ""
}

variable "db_instance_id" {
  description = "The ID of an existing PolarDB instance. If set, no new instance will be created."
  type        = string
  default     = ""
}

variable "engine" {
  description = "The database engine type. Valid values: PolarDB_PG MySQL PolarDB_PPAS."
  type        = string
  default     = "MySQL"
}

variable "engine_version" {
  description = "The database engine version."
  type        = string
  default     = "8.0"
}

variable "db_instance_class" {
  description = "The instance type/class of the PolarDB instance."
  type        = string
  default     = ""
}

variable "storage" {
  description = "The storage size of the instance in GB."
  type        = number
  default     = 20
}

variable "storage_type" {
  description = "The storage type of the instance. Valid values: local_ssd, cloud_ssd, cloud_essd."
  type        = string
  default     = "local_ssd"
}

variable "vswitch_id" {
  description = "The ID of the VSwitch for network configuration."
  type        = string
  default     = ""
}

variable "security_ips" {
  description = "List of security IPs that are allowed to access the instance."
  type        = list(string)
  default     = []
}

variable "parameters" {
  description = "Map of database parameters to set."
  type        = map(string)
  default     = {}
}

variable "databases" {
  description = "Map of databases to create. Key is database name, value is database configuration."
  type = map(object({
    character_set_name = optional(string, "utf8mb4")
    description        = optional(string, "")
  }))
  default = {}
}

variable "accounts" {
  description = "Map of accounts to create. Key is account name, value is account configuration."
  type = map(object({
    password           = string
    account_type       = optional(string, "Normal")
    account_privileges = optional(map(string), {})
  }))
  default = {}
}

variable "use_account_database_binding" {
  description = "Whether to use alibabacloudstack_polardb_account_database_binding resource instead of alibabacloudstack_polardb_account_privilege for account privileges."
  type        = bool
  default     = false
}

# Backup policy is managed by a separate submodule: polardb_backup_policy
# This allows managing backup policies independently from instance creation.
variable "backup_policy" {
  description = "Backup policy configuration object. Set to null to skip backup policy creation."
  type = object({
    backup_retention_period     = optional(number, 7)
    preferred_backup_period     = optional(string, "Monday,Wednesday,Friday")
    preferred_backup_time       = optional(string, "02:00Z-03:00Z")
    enable_backup_log           = optional(number, 1)
    compress_type               = optional(number, 1)
    backup_policy_mode          = optional(string, "DataBackupPolicy")
    backup_log                  = optional(string, "Enable")
    high_space_usage_protection = optional(string, "Enable")
    local_log_retention_hours   = optional(number, 24)
    local_log_retention_space   = optional(number, 20)
    log_backup_retention_period = optional(number, 7)
  })
  default = null
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

variable "encryption" {
  description = "Whether encryption is enabled for the instance."
  type        = bool
  default     = false
}

variable "encryption_key" {
  description = "The key ID of the disk encryption in the same region."
  type        = string
  default     = ""
}

variable "role_arn" {
  description = "The Global Resource Descriptor (ARN) that authorizes the POLARDB cloud service account to access KMS."
  type        = string
  default     = ""
}

variable "tde_status" {
  description = "The Transparent Data Encryption (TDE) status of the instance."
  type        = string
  default     = ""
}
