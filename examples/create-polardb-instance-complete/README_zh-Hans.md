# 创建完整的 PolarDB 实例

本示例创建完整的 PolarDB 实例配置，包括：
- VPC 和 VSwitch 资源
- 指定配置的 PolarDB 实例
- 多个不同字符集的数据库
- 带权限的数据库账号
- 备份策略配置
- 数据库连接配置

## 使用方法

1. 配置变量（通过 `terraform.tfvars` 或命令行）：
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

2. 执行：
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

3. 清理：
   ```bash
   terraform destroy
   ```

## 要求

| 名称 | 版本 |
|------|------|
| terraform | >= 1.5.6 |

## 提供商

| 名称 | 版本 |
|------|------|
| alibabacloudstack | >= 3.18.24, < 3.19.0 |

## 模块

| 名称 | 来源 | 版本 |
|------|------|------|
| polardb | ../../modules/polardb_instance | n/a |

## 输入变量

| 名称 | 描述 | 类型 | 默认值 | 必需 |
|------|------|------|--------|------|
| name | PolarDB 实例名称 | string | - | 是 |
| instance_type | 实例类型/规格 | string | - | 是 |
| engine | 数据库引擎类型 | string | MySQL | 否 |
| engine_version | 数据库引擎版本 | string | 8.0 | 否 |
| storage | 存储大小（GB） | number | 20 | 否 |
| storage_type | 存储类型 | string | local_ssd | 否 |
| security_ips | 安全 IP 列表 | list(string) | [] | 否 |
| databases | 要创建的数据库映射 | map(object) | {} | 否 |
| accounts | 要创建的账号映射 | map(object) | {} | 否 |
| backup_policy | 备份策略配置 | object | null | 否 |
| db_connection_prefix | 连接前缀 | string | "" | 否 |
| port | 数据库端口 | number | 3306 | 否 |
| tags | 资源标签 | map(string) | {} | 否 |

## 输出变量

| 名称 | 描述 |
|------|------|
| db_instance_id | 创建的 PolarDB 实例 ID |
| instance_name | PolarDB 实例名称 |
| connection_string | 实例连接地址 |
| port | 数据库连接端口 |
| database_names | 创建的数据库名称列表 |
| account_names | 创建的账号名称列表 |
| vswitch_id | 创建的交换机 ID |
| vpc_id | 创建的 VPC ID |

## 注意事项

- 本示例为 PolarDB 实例创建新的 VPC 和 VSwitch。
- `instance_type` 必须与选择的 `engine` 和 `engine_version` 兼容。
- 账号密码应安全提供（例如，通过环境变量或密钥管理）。
