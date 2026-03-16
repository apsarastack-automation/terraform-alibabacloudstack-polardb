# Alibaba Cloud PolarDB Instance Terraform Module

This module manages Alibaba Cloud PolarDB instances and related resources on Alibaba Cloud Stack, supporting:
- **Creating a new PolarDB instance** and configuring databases
- **Creating databases and accounts for an existing PolarDB instance**
- **Managing database connections**
- **Managing account database privileges** (via account_privilege or account_database_binding)

## Important Note

**Backup policy management has been moved to a separate module.** To configure backup policies, use the `polardb_backup_policy` module instead. This separation allows you to manage backup policies independently from instance creation.

## Supported Resources

* [alibabacloudstack_polardb_dbinstance](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/polardb_dbinstance)
* [alibabacloudstack_polardb_database](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/polardb_database)
* [alibabacloudstack_polardb_account](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/polardb_account)
* [alibabacloudstack_polardb_account_privilege](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/polardb_account_privilege)
* [alibabacloudstack_polardb_account_database_binding](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/polardb_account_database_binding)
* [alibabacloudstack_polardb_dbconnection](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/polardb_dbconnection)

## Usage Examples

### Scenario 1: Create a new PolarDB instance with databases and accounts

```hcl
module "polardb" {
  source = "./terraform-alibabacloudstack-polardb/modules/polardb_instance"

  name           = "my-polardb-instance"
  engine         = "MySQL"
  engine_version = "8.0"
  instance_type  = "rds.mysql.c1.large"
  storage        = 20
  storage_type   = "local_ssd"
  vswitch_id     = "vsw-xxxxxxxx"
  
  databases = {
    mydb = {
      character_set_name = "utf8mb4"
      description        = "My application database"
    }
  }
  
  accounts = {
    app_user = {
      password           = "SecurePassword123!"
      account_type       = "Normal"
      account_privileges = {
        mydb = "ReadWrite"
      }
    }
  }
}
```

### Scenario 2: Create databases and accounts for an existing PolarDB instance

```hcl
module "polardb" {
  source = "./terraform-alibabacloudstack-polardb/modules/polardb_instance"

  db_instance_id = "rm-xxxxxxxx"
  
  databases = {
    newdb = {
      character_set_name = "utf8mb4"
    }
  }
  
  accounts = {
    newuser = {
      password     = "SecurePassword123!"
      account_type = "Normal"
    }
  }
}
```

### Scenario 3: Use account_database_binding for privileges (Alternative)

```hcl
module "polardb" {
  source = "./terraform-alibabacloudstack-polardb/modules/polardb_instance"

  name           = "my-polardb-instance"
  engine         = "MySQL"
  engine_version = "8.0"
  instance_type  = "rds.mysql.c1.large"
  storage        = 20
  vswitch_id     = "vsw-xxxxxxxx"
  
  use_account_database_binding = true
  
  databases = {
    mydb = {
      character_set_name = "utf8mb4"
    }
  }
  
  accounts = {
    app_user = {
      password     = "SecurePassword123!"
      account_type = "Normal"
      account_privileges = {
        mydb = "ReadWrite"
      }
    }
  }
}
```

### Scenario 4: Configure backup policy using separate module

```hcl
# First, create the instance
module "polardb" {
  source = "./terraform-alibabacloudstack-polardb/modules/polardb_instance"

  name           = "my-polardb-instance"
  engine         = "MySQL"
  engine_version = "8.0"
  instance_type  = "rds.mysql.c1.large"
  storage        = 20
  vswitch_id     = "vsw-xxxxxxxx"
}

# Then, configure backup policy separately
module "backup_policy" {
  source = "./terraform-alibabacloudstack-polardb/modules/polardb_backup_policy"

  db_instance_id = module.polardb.db_instance_id

  backup_retention_period = 7
  preferred_backup_period = "Monday,Wednesday,Friday"
  preferred_backup_time   = "02:00Z-03:00Z"
  enable_backup_log       = 1
}
```

> ⚠️ **Key Constraints**:
> - `db_instance_id` and `name` are **mutually exclusive**: exactly one must be set.
> - When creating a new instance, `instance_type` is required.
> - When `db_instance_id` is provided, no new instance will be created.

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
| **name** | **Name for a new PolarDB instance. Used only when `db_instance_id` is not set.** | `string` | `""` | No |
| **db_instance_id** | **ID of an existing PolarDB instance. If set, no new instance will be created.** | `string` | `""` | No |
| engine | Database engine type | `string` | `"MySQL"` | No |
| engine_version | Database engine version | `string` | `"8.0"` | No |
| **instance_type** | **Instance type/class (required when creating new instance)** | `string` | `""` | No |
| storage | Storage size in GB | `number` | `20` | No |
| storage_type | Storage type | `string` | `"local_ssd"` | No |
| description | Instance description | `string` | `""` | No |
| vswitch_id | VSwitch ID for network configuration | `string` | `""` | No |
| zone_id | Zone ID for instance | `string` | `""` | No |
| instance_charge_type | Instance charge type | `string` | `"PostPaid"` | No |
| security_ips | List of security IPs | `list(string)` | `[]` | No |
| parameters | Database parameters | `map(string)` | `{}` | No |
| databases | Map of databases to create | `map(object)` | `{}` | No |
| accounts | Map of accounts to create | `map(object)` | `{}` | No |
| use_account_database_binding | Use account_database_binding resource for privileges | `bool` | `false` | No |
| db_connection_prefix | Connection prefix | `string` | `""` | No |
| port | Database port | `number` | `3306` | No |
| tags | Tags for resources | `map(string)` | `{}` | No |

> 💡 **Mutual Exclusion Rules**:
> - `db_instance_id` and `name`: choose exactly one.
> - When `db_instance_id` is set, `name` is ignored.

## Output Values

| Name | Description |
|------|-------------|
| db_instance_id | ID of the PolarDB instance |
| instance_name | Name of the PolarDB instance |
| connection_string | Connection string of the instance |
| port | Database connection port |
| database_names | List of created database names |
| account_names | List of created account names |
| vswitch_id | ID of the VSwitch used by the instance |

## Notes

* When `db_instance_id` is provided, the module will use the existing instance and not create a new one.
* Database and account management can be done independently of instance creation.
* **For backup policy configuration, use the separate `polardb_backup_policy` module.**
* Set `use_account_database_binding = true` to use the newer `account_database_binding` resource for managing account privileges.

## Related Modules

* [polardb_backup_policy](../polardb_backup_policy/) - For managing backup policies separately

## Reporting Issues

If you encounter any issues while using this module, please open an issue in the [provider repository](https://github.com/aliyun/terraform-provider-alibabacloudstack/issues/new).

> **Note**: Please do **not** open issues in this module's repository.

## Authors

Created and maintained by the Alibaba Cloud Terraform Team.

## License

MIT License. See LICENSE for details.

## References

* [Terraform Provider for Alibaba Cloud Stack (GitHub)](https://github.com/aliyun/terraform-provider-alibabacloudstack)
* [Terraform Provider Registry](https://registry.terraform.io/providers/aliyun/alibabacloudstack)
* [Provider Documentation](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs)
