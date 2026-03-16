# Use Existing PolarDB Instance

This example demonstrates how to create databases and accounts on an existing PolarDB instance without creating a new instance.

## Usage

1. Configure variables (via `terraform.tfvars` or CLI):
   ```hcl
   db_instance_id = "rm-xxxxxxxx"
   databases = {
     new_app_db = {
       character_set_name = "utf8mb4"
       description        = "New application database"
     }
   }
   accounts = {
     new_app_user = {
       password     = "SecurePassword123!"
       account_type = "Normal"
       account_privileges = {
         new_app_db = "ReadWrite"
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

3. Clean up (only removes databases and accounts, not the instance):
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
| databases | Map of databases to create | map(object) | {} | No |
| accounts | Map of accounts to create | map(object) | {} | No |

## Output Variables

| Name | Description |
|------|-------------|
| db_instance_id | ID of the PolarDB instance |
| instance_name | Name of the PolarDB instance |
| database_names | List of created database names |
| account_names | List of created account names |

## Notes

- This example assumes the PolarDB instance already exists.
- Running `terraform destroy` will only remove the databases and accounts created by this configuration, not the instance itself.
- Ensure the provided `db_instance_id` is valid and accessible.
