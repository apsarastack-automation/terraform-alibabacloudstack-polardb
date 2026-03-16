# Create PostgreSQL Instance with KMS Encryption

This example creates a PolarDB PostgreSQL instance with KMS disk encryption enabled.

## Usage

1. Configure variables (via `terraform.tfvars` or CLI):
   ```hcl
   name           = "my-polardb-postgres"
   instance_type  = "rds.pg.c1.large"
   vswitch_id     = "vsw-xxxxxxxx"
   encryption_key = "your-kms-key-id"
   role_arn       = "your-role-arn"  # Optional
   ```

2. Run:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

3. Clean up:
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
| name | Name of the PolarDB PostgreSQL instance | string | - | Yes |
| instance_type | Instance type/class | string | - | Yes |
| engine_version | PostgreSQL engine version | string | "14" | No |
| storage | Storage size in GB | number | 20 | No |
| storage_type | Storage type | string | "cloud_essd" | No |
| vswitch_id | VSwitch ID for network configuration | string | - | Yes |
| zone_id | Zone ID for instance | string | "" | No |
| encryption_key | KMS key ID for disk encryption | string | - | Yes |
| role_arn | ARN for KMS access authorization | string | "" | No |
| security_ips | List of security IPs | list(string) | [] | No |
| tags | Tags for resources | map(string) | {} | No |

## Output Variables

| Name | Description |
|------|-------------|
| db_instance_id | ID of the created PolarDB instance |
| instance_name | Name of the PolarDB instance |
| connection_string | Connection string of the instance |
| port | Database connection port |
| engine | Database engine type |
| encryption_enabled | Whether encryption is enabled |

## Notes

- This example requires a pre-created KMS key for encryption.
- The `encryption_key` parameter enables cloud disk encryption and cannot be turned off after it is enabled.
- The `role_arn` is required when using encryption to authorize POLARDB service to access KMS.

