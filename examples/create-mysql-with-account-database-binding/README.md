# Create MySQL Instance with Account-Database Binding

This example creates a PolarDB MySQL instance with databases and accounts, using the `account_database_binding` resource to manage privileges.

## Usage

1. Configure variables (via `terraform.tfvars` or CLI):
   ```hcl
   name          = "my-polardb-mysql"
   instance_type = "rds.mysql.c1.large"
   vswitch_id    = "vsw-xxxxxxxx"
   
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
| name | Name of the PolarDB MySQL instance | string | - | Yes |
| instance_type | Instance type/class | string | - | Yes |
| engine_version | MySQL engine version | string | "8.0" | No |
| storage | Storage size in GB | number | 20 | No |
| storage_type | Storage type | string | "local_ssd" | No |
| vswitch_id | VSwitch ID for network configuration | string | - | Yes |
| zone_id | Zone ID for instance | string | "" | No |
| security_ips | List of security IPs | list(string) | [] | No |
| databases | Map of databases to create | map(object) | {} | No |
| accounts | Map of accounts with privileges | map(object) | {} | No |
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
| binding_mode | The mode used for privilege binding |

## Notes

- This example uses `use_account_database_binding = true` to use the newer `account_database_binding` resource.
- The `account_privileges` map defines which databases each account can access and with what privilege level.
- Supported privilege values: `ReadWrite`, `ReadOnly`, `DDLOnly`, `DMLOnly`, `ReadIndex`.

