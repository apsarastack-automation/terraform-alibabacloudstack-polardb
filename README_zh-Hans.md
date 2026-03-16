# 阿里云 PolarDB Terraform 模块

该模块用于在阿里云 Stack 上创建 **PolarDB 实例、数据库、账号、备份策略和连接配置**。

## 功能特性

- 创建新的 PolarDB 实例
- 管理实例内的 PolarDB 数据库
- 管理 PolarDB 账号和权限
- 配置实例的备份策略
- 管理数据库连接
- 支持使用已有 PolarDB 实例或创建新实例
- 支持使用 `account_privilege` 或 `account_database_binding` 管理权限

## 使用方法

### 基础用法：创建 PolarDB 实例并配置数据库和账号

```hcl
module "polardb" {
  source = "<模块路径>"

  name = "my-polardb-instance"
  
  # 实例配置
  engine         = "MySQL"
  engine_version = "8.0"
  instance_type  = "rds.mysql.c1.large"
  storage        = 20
  storage_type   = "local_ssd"
  
  # VPC 配置
  vswitch_id = "vsw-xxxxxxxx"
  
  # 数据库配置
  databases = {
    mydb = {
      character_set_name = "utf8mb4"
      description        = "My application database"
    }
  }
  
  # 账号配置
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

### 高级用法：启用备份策略

```hcl
module "polardb" {
  source = "<模块路径>"

  name           = "my-polardb-instance"
  engine         = "MySQL"
  engine_version = "8.0"
  instance_type  = "rds.mysql.c1.large"
  storage        = 20
  storage_type   = "local_ssd"
  vswitch_id     = "vsw-xxxxxxxx"
  
  # 备份策略配置
  backup_policy = {
    backup_retention_period = 7
    preferred_backup_period = "Monday,Wednesday,Friday"
    preferred_backup_time   = "02:00Z-03:00Z"
    enable_backup_log       = 1
  }
}
```

### 使用已有 PolarDB 实例

```hcl
module "polardb" {
  source = "<模块路径>"

  # 使用已有实例
  db_instance_id = "rm-xxxxxxxx"
  
  # 在已有实例上创建数据库和账号
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

## 环境依赖

### Terraform Core

| 名称 | 版本 |
|------|------|
| Terraform | >= 1.5.6 |

### 提供商

| 名称 | 版本 |
|------|------|
| alibabacloudstack | >= 3.18.24, < 3.19.0 |

## 模块变量

### 输入变量

| 名称 | 描述 | 类型 | 默认值 | 必需 |
|------|------|------|--------|------|
| `name` | PolarDB 实例名称 | `string` | `""` | 是（如果创建新实例） |
| `db_instance_id` | 已有 PolarDB 实例 ID | `string` | `""` | 否 |
| `engine` | 数据库引擎类型 | `string` | `"MySQL"` | 否 |
| `engine_version` | 数据库引擎版本 | `string` | `"8.0"` | 否 |
| `instance_type` | 实例类型/规格 | `string` | `""` | 是（如果创建新实例） |
| `storage` | 存储大小（GB） | `number` | `20` | 否 |
| `storage_type` | 存储类型 | `string` | `"local_ssd"` | 否 |
| `vswitch_id` | 交换机 ID，用于网络配置 | `string` | `""` | 否 |
| `vpc_id` | VPC ID，用于网络配置 | `string` | `""` | 否 |
| `zone_id` | 实例可用区 ID | `string` | `""` | 否 |
| `instance_charge_type` | 实例付费类型 | `string` | `"PostPaid"` | 否 |
| `security_ips` | 安全 IP 列表 | `list(string)` | `[]` | 否 |
| `parameters` | 数据库参数 | `map(string)` | `{}` | 否 |
| `databases` | 要创建的数据库映射 | `map(object)` | `{}` | 否 |
| `accounts` | 要创建的账号映射 | `map(object)` | `{}` | 否 |
| `use_account_database_binding` | 使用 account_database_binding 管理权限 | `bool` | `false` | 否 |
| `backup_policy` | 备份策略配置 | `object` | `null` | 否 |
| `db_connection_prefix` | 连接前缀 | `string` | `""` | 否 |
| `port` | 数据库端口 | `number` | `3306` | 否 |
| `tags` | 资源标签 | `map(string)` | `{}` | 否 |

### 输出变量

| 名称 | 描述 |
|------|------|
| `db_instance_id` | PolarDB 实例 ID |
| `instance_name` | PolarDB 实例名称 |
| `connection_string` | 实例连接地址 |
| `port` | 数据库连接端口 |
| `database_names` | 创建的数据库名称列表 |
| `account_names` | 创建的账号名称列表 |

## 示例

更多使用场景请参见 [`examples/`](./examples) 目录：
- `create-polardb-instance-complete` - 包含所有功能的完整示例
- `use-existing-instance` - 使用已有 PolarDB 实例的示例
- `create-instance-with-backup` - 配置备份策略的示例

## 注意事项

- 本模块支持创建新 PolarDB 实例和使用已有实例两种模式。
- 当提供 `db_instance_id` 时，模块不会创建新实例。
- 数据库和账号管理可以独立于实例创建进行。
- 备份策略配置是可选的，仅在提供时才会应用。
- 设置 `use_account_database_binding = true` 可使用较新的 `account_database_binding` 资源管理权限。

## 许可证

MIT 许可证。详情请参见 LICENSE。
