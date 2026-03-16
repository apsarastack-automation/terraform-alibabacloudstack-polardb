# Create Backup Policy for Existing Instance

This example creates a backup policy for an existing PolarDB instance.

## Usage

1. Configure variables (via `terraform.tfvars` or CLI):
   ```hcl
   db_instance_id          = "rm-xxxxxxxx"
   backup_retention_period = 30
   preferred_backup_period = "Monday,Wednesday,Friday"
   preferred_backup_time   = "02:00Z-03:00Z"
   enable_backup_log       = 1
   compress_type           = 1
   ```

2. Run:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

3. Clean up (removes backup policy configuration):
   ```bash
   terraform destroy
   ```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5.6 |

## Provider

| Name | Version |
|------|---------|
| alibabacloudstack | >= 3.18.24, < 3.19.0 |

## Module

| Name | Source | Version |
|------|--------|---------|
| polardb | ../../modules/polardb_instance | n/a |

## Input Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| db_instance_id | ID of the existing PolarDB instance | string | - | Yes |
| backup_retention_period | Retention period of data backup files (7-730 days) | number | 7 | No |
| preferred_backup_period | Backup cycle (comma-separated days) | string | "Monday,Wednesday,Friday" | No |
| preferred_backup_time | Backup time in HH:mmZ-HH:mmZ format | string | "02:00Z-03:00Z" | No |
| enable_backup_log | Whether to enable log backup (1=enabled, 0=disabled) | number | 1 | No |
| compress_type | Backup compression method (0-8) | number | 1 | No |

## Output Variables

| Name | Description |
|------|-------------|
| db_instance_id | ID of the PolarDB instance |
| instance_name | Name of the PolarDB instance |
| backup_policy_applied | Whether the backup policy was applied |
| backup_retention_period | The retention period configured |
| preferred_backup_period | The backup cycle configured |
| preferred_backup_time | The backup time configured |

## Notes

- This example assumes the PolarDB instance already exists.
- The backup policy will be applied to the existing instance.
- Running `terraform destroy` will remove the backup policy configuration from Terraform state, but the actual backup policy on the instance may remain.
- Valid values for `compress_type`: 0 (no compression), 1 (zlib), 2 (parallel zlib), 4 (quicklz), 8 (MySQL 8.0 quicklz).

