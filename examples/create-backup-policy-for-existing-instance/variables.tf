variable "db_instance_id" {
  description = "The ID of an existing PolarDB instance."
  type        = string
}

variable "backup_retention_period" {
  description = "The retention period of data backup files. Valid values: 7 to 730."
  type        = number
  default     = 7
}

variable "preferred_backup_period" {
  description = "The backup cycle. Separate multiple values with commas. Valid values: Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday."
  type        = string
  default     = "Monday,Wednesday,Friday"
}

variable "preferred_backup_time" {
  description = "The backup time in format HH:mmZ-HH:mmZ (UTC time)."
  type        = string
  default     = "02:00Z-03:00Z"
}

variable "enable_backup_log" {
  description = "Whether to enable log backup. Valid values: 1 (enabled), 0 (disabled)."
  type        = number
  default     = 1
}

variable "compress_type" {
  description = "The backup compression method. Valid values: 0 (no compression), 1 (zlib), 2 (parallel zlib), 4 (quicklz), 8 (MySQL 8.0 quicklz)."
  type        = number
  default     = 1
}
