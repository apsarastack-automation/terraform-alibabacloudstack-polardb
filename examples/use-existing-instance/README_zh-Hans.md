# 使用已有 PolarDB 实例

本示例演示如何在已有的 PolarDB 实例上创建数据库和账号，而不创建新实例。

## 使用方法

1. 配置变量（通过 `terraform.tfvars` 或命令行）：
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

2. 执行：
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

3. 清理（仅删除数据库和账号，不删除实例）：
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
| db_instance_id | 已有 PolarDB 实例的 ID | string | - | 是 |
| databases | 要创建的数据库映射 | map(object) | {} | 否 |
| accounts | 要创建的账号映射 | map(object) | {} | 否 |

## 输出变量

| 名称 | 描述 |
|------|------|
| db_instance_id | PolarDB 实例 ID |
| instance_name | PolarDB 实例名称 |
| database_names | 创建的数据库名称列表 |
| account_names | 创建的账号名称列表 |

## 注意事项

- 本示例假定 PolarDB 实例已存在。
- 运行 `terraform destroy` 仅删除本配置创建的数据库和账号，不会删除实例本身。
- 确保提供的 `db_instance_id` 有效且可访问。
