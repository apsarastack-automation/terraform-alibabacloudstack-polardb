# Create Complete PolarDB Instance

This example creates a complete PolarDB instance setup including:
- VPC and VSwitch resources
- PolarDB instance with specified configuration
- Multiple databases with different character sets
- Database accounts with privileges
- Backup policy configuration
- Database connection configuration

## Usage

1. Configure variables (via `terraform.tfvars` or CLI):
   ```hcl
   name          = "my-polardb-complete"
   instance_type = "rds.mysql.c1.large"
   databases = {
     app_db = {
       character_set_name = "utf8mb4"
       description        = "Application database"
     }
     log_db = {
       character_set_name = "utf8"
       description        = "Log database"
     }
   }
   accounts = {
     app_user = {
       password     = "SecurePassword123!"
       account_type = "Normal"
       account_privileges = {
         app_db = "ReadWrite"
       }
     }
     readonly_user = {
       password     = "ReadOnlyPass123!"
       account_type = "Normal"
       account_privileges = {
         app_db = "ReadOnly"
         log_db = "ReadOnly"
       }
     }
   }
   backup_policy = {
     backup_retention_period = 7
     preferred_backup_period = "Monday,Wednesday,Friday"
     preferred_backup_time   = "02:00Z-03:00Z"
     enable_backup_log       = 1
   }
   db_connection_prefix = "mydb"
   port                 = 3306
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
| name | Name of the PolarDB instance | string | - | Yes |
| instance_type | Instance type/class | string | - | Yes |
| engine | Database engine type | string | MySQL | No |
| engine_version | Database engine version | string | 8.0 | No |
| storage | Storage size in GB | number | 20 | No |
| storage_type | Storage type | string | local_ssd | No |
| security_ips | List of security IPs | list(string) | [] | No |
| databases | Map of databases to create | map(object) | {} | No |
| accounts | Map of accounts to create | map(object) | {} | No |
| backup_policy | Backup policy configuration | object | null | No |
| db_connection_prefix | Connection prefix | string | "" | No |
| port | Database port | number | 3306 | No |
| tags | Tags for resources | map(string) | {} | No |

## Output Variables

| Name | Description |
|------|-------------|
| db_instance_id | ID of the created PolarDB instance |
| instance_name | Name of the PolarDB instance |
| connection_string | Connection string of the instance |
| port | Database connection port |
| database_names | List of created database names |
| account_names | List of created account names |
| vswitch_id | ID of the created VSwitch |
| vpc_id | ID of the created VPC |

## Notes

- This example creates a new VPC and VSwitch for the PolarDB instance.
- The `instance_type` must be compatible with the selected `engine` and `engine_version`.
- Account passwords should be provided securely (e.g., via environment variables or secrets management).
