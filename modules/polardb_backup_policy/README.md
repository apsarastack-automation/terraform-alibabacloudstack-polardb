# Alibaba Cloud PolarDB Backup Policy Terraform Module

This module manages backup policies for existing PolarDB instances on Alibaba Cloud Stack.

## Features

- Configures backup policy for an existing PolarDB instance
- Supports data backup and log backup settings
- Configurable backup retention periods
- Supports backup compression

## Important Note

**This module does NOT create PolarDB instances.** It only manages backup policies for existing instances. You must provide a valid `db_instance_id` of an existing PolarDB instance.

## Usage

### Basic Usage

```hcl
module "backup_policy" {
  source = "./terraform-alibabacloudstack-polardb/modules/polardb_backup_policy"

  db_instance_id = "rm-xxxxxxxx"  # Required: ID of existing PolarDB instance

  backup_retention_period = 7
  preferred_backup_period = "Monday,Wednesday,Friday"
  preferred_backup_time   = "02:00Z-03:00Z"
  enable_backup_log       = 1
  compress_type           = 1
}
```

### Advanced Usage with All Parameters

```hcl
module "backup_policy" {
  source = "./terraform-alibabacloudstack-polardb/modules/polardb_backup_policy"

  db_instance_id = "rm-xxxxxxxx"

  backup_retention_period     = 30
  preferred_backup_period     = "Monday,Tuesday,Wednesday,Thursday,Friday"
  preferred_backup_time       = "03:00Z-04:00Z"
  enable_backup_log           = 1
  compress_type               = 4
  backup_policy_mode          = "DataBackupPolicy"
  backup_log                  = "Enable"
  high_space_usage_protection = "Enable"
  local_log_retention_hours   = 48
  local_log_retention_space   = 30
  log_backup_retention_period = 30
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5.6 |

## Providers

| Name | Version |
|------|---------|
| alibabacloudstack | >= 3.18.24, < 3.19.0 |

## Input Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| **db_instance_id** | **(Required) The ID of the existing PolarDB instance.** | `string` | — | Yes |
| backup_retention_period | Retention period of data backup files (7-730 days) | `number` | `7` | No |
| preferred_backup_period | Backup cycle (comma-separated days) | `string` | `"Monday,Wednesday,Friday"` | No |
| preferred_backup_time | Backup time in HH:mmZ-HH:mmZ format | `string` | `"02:00Z-03:00Z"` | No |
| enable_backup_log | Whether to enable log backup (1=enabled, 0=disabled) | `number` | `1` | No |
| compress_type | Backup compression method (0-8) | `number` | `1` | No |
| backup_policy_mode | Backup policy mode | `string` | `"DataBackupPolicy"` | No |
| backup_log | Log backup switch | `string` | `"Enable"` | No |
| high_space_usage_protection | Whether to force Binlog cleanup when space is high | `string` | `"Enable"` | No |
| local_log_retention_hours | Log backup local retention hours | `number` | `24` | No |
| local_log_retention_space | Maximum circular space usage of local logs | `number` | `20` | No |
| log_backup_retention_period | Retention period of log backup files | `number` | `7` | No |

## Output Variables

| Name | Description |
|------|-------------|
| db_instance_id | The ID of the PolarDB instance |
| backup_policy_applied | Whether the backup policy was applied |
| backup_retention_period | The retention period configured |
| preferred_backup_period | The backup cycle configured |
| preferred_backup_time | The backup time configured |
| enable_backup_log | Whether log backup is enabled |
| compress_type | The backup compression method |

## Notes

- This module requires an existing PolarDB instance. It will fail if the `db_instance_id` is invalid or the instance does not exist.
- Running `terraform destroy` will remove the backup policy configuration from Terraform state, but the actual backup policy on the instance may remain.
- Valid values for `compress_type`: 0 (no compression), 1 (zlib), 2 (parallel zlib), 4 (quicklz), 8 (MySQL 8.0 quicklz).

## License

MIT License. See LICENSE for details.
