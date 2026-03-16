# 阿里云 PolarDB Terraform 模块

该模块用于在阿里云 Stack 上管理 PolarDB 实例及相关资源，支持：
- **创建新的 PolarDB 实例** 并配置数据库
- **为现有的 PolarDB 实例创建数据库和账号**
- **为实例配置备份策略**
- **管理数据库连接**
- **管理账号数据库权限**（通过 account_privilege 或 account_database_binding）

## 支持资源

* [alibabacloudstack_polardb_dbinstance](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/polardb_dbinstance)
* [alibabacloudstack_polardb_database](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/polardb_database)
* [alibabacloudstack_polardb_account](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/polardb_account)
* [alibabacloudstack_polardb_account_privilege](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/polardb_account_privilege)
* [alibabacloudstack_polardb_account_database_binding](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/polardb_account_database_binding)
* [alibabacloudstack_polardb_backuppolicy](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/polardb_backuppolicy)
* [alibabacloudstack_polardb_dbconnection](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/polardb_dbconnection)

## 使用方法

### 场景 1：创建新的 PolarDB 实例并配置数据库和账号

```hcl
module "polardb" {
  source = "./terraform-alibabacloudstack-polardb"

  name        = "my-polardb-instance"
  engine      = "MySQL"
  engine_version = "8.0"
  instance_type = "rds.mysql.c1.large"
  storage     = 20
  storage_type = "local_ssd"
  vswitch_id  = "vsw-xxxxxxxx"
  
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

### 场景 2：为现有 PolarDB 实例创建数据库和账号

```hcl
module "polardb" {
  source = "./terraform-alibabacloudstack-polardb"

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

### 场景 3：配置备份策略

```hcl
module "polardb" {
  source = "./terraform-alibabacloudstack-polardb"

  name           = "my-polardb-instance"
  engine         = "MySQL"
  engine_version = "8.0"
  instance_type  = "rds.mysql.c1.large"
  storage        = 20
  vswitch_id     = "vsw-xxxxxxxx"
  
  backup_policy = {
    backup_retention_period = 7
    preferred_backup_period = "Monday,Wednesday,Friday"
    preferred_backup_time   = "02:00Z-03:00Z"
    enable_backup_log       = 1
  }
}
```

### 场景 4：使用 account_database_binding 管理权限（替代方案）

```hcl
module "polardb" {
  source = "./terraform-alibabacloudstack-polardb"

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

> ⚠️ **关键约束**：
> - `db_instance_id` 和 `name` **必须设置且仅能设置一个**。
> - 创建新实例时，`instance_type` 是必需的。
> - 当提供 `db_instance_id` 时，不会创建新实例。
> - `use_account_database_binding` 控制是否使用较新的 `account_database_binding` 资源替代 `account_privilege`。

## 要求

| 名称 | 版本 |
|------|------|
| terraform | >= 1.5.6 |

## 提供商

| 名称 | 版本 |
|------|------|
| alibabacloudstack | >= 3.18.24, < 3.19.0 |

## 输入变量

| 名称 | 描述 | 类型 | 默认值 | 必需 |
|------|------|------|--------|------|
| **name** | **新 PolarDB 实例的名称。仅在 `db_instance_id` 未设置时使用。** | `string` | `""` | 否 |
| **db_instance_id** | **已有 PolarDB 实例的 ID。如果设置，则不会创建新实例。** | `string` | `""` | 否 |
| engine | 数据库引擎类型 | `string` | `"MySQL"` | 否 |
| engine_version | 数据库引擎版本 | `string` | `"8.0"` | 否 |
| **instance_type** | **实例类型/规格（创建新实例时必需）** | `string` | `""` | 否 |
| storage | 存储大小（GB） | `number` | `20` | 否 |
| storage_type | 存储类型 | `string` | `"local_ssd"` | 否 |
| description | 实例描述 | `string` | `""` | 否 |
| vswitch_id | 交换机 ID，用于网络配置 | `string` | `""` | 否 |
| vpc_id | VPC ID，用于网络配置 | `string` | `""` | 否 |
| zone_id | 实例可用区 ID | `string` | `""` | 否 |
| instance_charge_type | 实例付费类型 | `string` | `"PostPaid"` | 否 |
| security_ips | 安全 IP 列表 | `list(string)` | `[]` | 否 |
| parameters | 数据库参数 | `map(string)` | `{}` | 否 |
| databases | 要创建的数据库映射 | `map(object)` | `{}` | 否 |
| accounts | 要创建的账号映射 | `map(object)` | `{}` | 否 |
| use_account_database_binding | 使用 account_database_binding 资源管理权限 | `bool` | `false` | 否 |
| backup_policy | 备份策略配置 | `object` | `null` | 否 |
| db_connection_prefix | 连接前缀 | `string` | `""` | 否 |
| port | 数据库端口 | `number` | `3306` | 否 |
| tags | 资源标签 | `map(string)` | `{}` | 否 |

> 💡 **互斥规则**：
> - `db_instance_id` 和 `name`：二选一
> - 当设置 `db_instance_id` 时，`name` 将被忽略

## 输出变量

| 名称 | 描述 |
|------|------|
| db_instance_id | PolarDB 实例 ID |
| instance_name | PolarDB 实例名称 |
| connection_string | 实例连接地址 |
| port | 数据库连接端口 |
| database_names | 创建的数据库名称列表 |
| account_names | 创建的账号名称列表 |
| vswitch_id | 实例使用的交换机 ID |
| vpc_id | 实例使用的 VPC ID |

## 注意事项

* 当提供 `db_instance_id` 时，模块将使用已有实例，不会创建新实例。
* 数据库和账号管理可以独立于实例创建进行。
* 备份策略配置是可选的，仅在提供时才会应用。
* 设置 `use_account_database_binding = true` 可使用较新的 `account_database_binding` 资源管理账号权限。

## 提交问题

如果您在使用此模块时遇到任何问题，请提交 [provider issue](https://github.com/aliyun/terraform-provider-alibabacloudstack/issues/new) 并告知我们。

**注意：** 不建议在此仓库上提交 issue。

## 作者

由阿里云 Terraform 团队创建和维护

## 许可证

MIT 许可证。详情请参见 LICENSE。

## 参考

* [Terraform-Provider-Alibabacloudstack Github](https://github.com/aliyun/terraform-provider-alibabacloudstack)
* [Terraform-Provider-Alibabacloudstack Release](https://registry.terraform.io/providers/aliyun/alibabacloudstack)
* [Terraform-Provider-Alibabacloudstack 文档](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs)
