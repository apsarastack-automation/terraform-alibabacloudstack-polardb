# 创建MySQL实例并绑定账号数据库

本示例创建PolarDB MySQL实例，并使用`account_database_binding`资源管理数据库、账号和权限绑定。

## 使用方法

1. 配置变量（通过 `terraform.tfvars` 或命令行）：
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
| name | PolarDB MySQL实例名称 | string | - | 是 |
| instance_type | 实例类型/规格 | string | - | 是 |
| engine_version | MySQL引擎版本 | string | "8.0" | 否 |
| storage | 存储大小（GB） | number | 20 | 否 |
| storage_type | 存储类型 | string | "local_ssd" | 否 |
| vswitch_id | 用于网络配置的交换机ID | string | - | 是 |
| zone_id | 实例可用区ID | string | "" | 否 |
| security_ips | 安全IP列表 | list(string) | [] | 否 |
| databases | 要创建的数据库映射 | map(object) | {} | 否 |
| accounts | 带权限的账号映射 | map(object) | {} | 否 |
| tags | 资源标签 | map(string) | {} | 否 |

## 输出变量

| 名称 | 描述 |
|------|------|
| db_instance_id | 创建的PolarDB实例ID |
| instance_name | PolarDB实例名称 |
| connection_string | 实例连接地址 |
| port | 数据库连接端口 |
| database_names | 创建的数据库名称列表 |
| account_names | 创建的账号名称列表 |
| binding_mode | 用于权限绑定的模式 |

## 注意事项

- 本示例使用`use_account_database_binding = true`来使用较新的`account_database_binding`资源。
- `account_privileges`映射定义了每个账号可以访问哪些数据库以及具有什么权限级别。
- 支持的权限值：`ReadWrite`、`ReadOnly`、`DDLOnly`、`DMLOnly`、`ReadIndex`。

