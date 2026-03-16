# 阿里云 PolarDB 备份策略 Terraform 模块

该模块用于在阿里云 Stack 上为已存在的 PolarDB 实例管理备份策略。

## 功能特性

- 为已有 PolarDB 实例配置备份策略
- 支持数据备份和日志备份设置
- 可配置的备份保留期
- 支持备份压缩

## 重要说明

**本模块不创建 PolarDB 实例。** 它仅为已有实例管理备份策略。您必须提供已有 PolarDB 实例的有效 `db_instance_id`。

## 使用方法

### 基础用法

```hcl
module "backup_policy" {
  source = "./terraform-alibabacloudstack-polardb/modules/polardb_backup_policy"

  db_instance_id = "rm-xxxxxxxx"  # 必需：已有 PolarDB 实例的 ID

  backup_retention_period = 7
  preferred_backup_period = "Monday,Wednesday,Friday"
  preferred_backup_time   = "02:00Z-03:00Z"
  enable_backup_log       = 1
  compress_type           = 1
}
```

### 高级用法（所有参数）

```hcl
module "backup_policy" {
  source = "./terraform-alibabacloudstack-polardb/modules/polardb_backup_policy"

  db_instance_id = "rm-xxxxxxxx"

  backup_retention_period     = 30
  preferred_backup_period     = "Monday,Tuesday,Wednesday,Thursday,Friday"
  preferred_backup_time       = "03:00Z-04:00Z"
  enable_backup_log           = 1
  compress_type               = 4
  backup_policy_mode          = "DataBackupPolicy"
  backup_log                  = "Enable"
  high_space_usage_protection = "Enable"
  local_log_retention_hours   = 48
  local_log_retention_space   = 30
  log_backup_retention_period = 30
}
```

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
| **db_instance_id** | **（必需）已有 PolarDB 实例的 ID。** | `string` | — | 是 |
| backup_retention_period | 数据备份文件保留天数（7-730天） | `number` | `7` | 否 |
| preferred_backup_period | 备份周期（逗号分隔的日期） | `string` | `"Monday,Wednesday,Friday"` | 否 |
| preferred_backup_time | 备份时间，格式 HH:mmZ-HH:mmZ | `string` | `"02:00Z-03:00Z"` | 否 |
| enable_backup_log | 是否启用日志备份（1=启用，0=禁用） | `number` | `1` | 否 |
| compress_type | 备份压缩方式（0-8） | `number` | `1` | 否 |
| backup_policy_mode | 备份策略模式 | `string` | `"DataBackupPolicy"` | 否 |
| backup_log | 日志备份开关 | `string` | `"Enable"` | 否 |
| high_space_usage_protection | 空间使用高时是否强制清理 Binlog | `string` | `"Enable"` | 否 |
| local_log_retention_hours | 日志备份本地保留小时数 | `number` | `24` | 否 |
| local_log_retention_space | 本地日志最大循环空间使用率 | `number` | `20` | 否 |
| log_backup_retention_period | 日志备份文件保留天数 | `number` | `7` | 否 |

## 输出变量

| 名称 | 描述 |
|------|------|
| db_instance_id | PolarDB 实例 ID |
| backup_policy_applied | 是否已应用备份策略 |
| backup_retention_period | 配置的保留天数 |
| preferred_backup_period | 配置的备份周期 |
| preferred_backup_time | 配置的备份时间 |
| enable_backup_log | 是否启用日志备份 |
| compress_type | 备份压缩方式 |

## 注意事项

- 本模块需要已存在的 PolarDB 实例。如果 `db_instance_id` 无效或实例不存在，模块将失败。
- 执行 `terraform destroy` 会从 Terraform 状态中移除备份策略配置，但实例上的实际备份策略可能会保留。
- `compress_type` 的有效值：0（不压缩）、1（zlib）、2（并行 zlib）、4（quicklz）、8（MySQL 8.0 quicklz）。

## 许可证

MIT 许可证。详见 LICENSE。
