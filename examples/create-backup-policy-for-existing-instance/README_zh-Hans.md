# 为已有实例创建备份策略

本示例为已存在的PolarDB实例创建备份策略。

## 使用方法

1. 配置变量（通过 `terraform.tfvars` 或命令行）：
   ```hcl
   db_instance_id          = "rm-xxxxxxxx"
   backup_retention_period = 30
   preferred_backup_period = "Monday,Wednesday,Friday"
   preferred_backup_time   = "02:00Z-03:00Z"
   enable_backup_log       = 1
   compress_type           = 1
   ```

2. 执行：
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

3. 清理（移除备份策略配置）：
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
| db_instance_id | 已有PolarDB实例的ID | string | - | 是 |
| backup_retention_period | 数据备份文件保留天数（7-730天） | number | 7 | 否 |
| preferred_backup_period | 备份周期（逗号分隔的日期） | string | "Monday,Wednesday,Friday" | 否 |
| preferred_backup_time | 备份时间，格式HH:mmZ-HH:mmZ | string | "02:00Z-03:00Z" | 否 |
| enable_backup_log | 是否启用日志备份（1=启用，0=禁用） | number | 1 | 否 |
| compress_type | 备份压缩方式（0-8） | number | 1 | 否 |

## 输出变量

| 名称 | 描述 |
|------|------|
| db_instance_id | PolarDB实例ID |
| instance_name | PolarDB实例名称 |
| backup_policy_applied | 是否已应用备份策略 |
| backup_retention_period | 配置的保留天数 |
| preferred_backup_period | 配置的备份周期 |
| preferred_backup_time | 配置的备份时间 |

## 注意事项

- 本示例假定PolarDB实例已存在。
- 备份策略将应用到已有实例上。
- 执行`terraform destroy`会从Terraform状态中移除备份策略配置，但实例上的实际备份策略可能会保留。
- `compress_type`的有效值：0（不压缩）、1（zlib）、2（并行zlib）、4（quicklz）、8（MySQL 8.0 quicklz）。

