# 创建KMS加密的PostgreSQL实例

本示例创建启用KMS磁盘加密的PolarDB PostgreSQL实例。

## 使用方法

1. 配置变量（通过 `terraform.tfvars` 或命令行）：
   ```hcl
   name           = "my-polardb-postgres"
   instance_type  = "rds.pg.c1.large"
   vswitch_id     = "vsw-xxxxxxxx"
   encryption_key = "your-kms-key-id"
   role_arn       = "your-role-arn"  # 可选
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
| name | PolarDB PostgreSQL实例名称 | string | - | 是 |
| instance_type | 实例类型/规格 | string | - | 是 |
| engine_version | PostgreSQL引擎版本 | string | "14" | 否 |
| storage | 存储大小（GB） | number | 20 | 否 |
| storage_type | 存储类型 | string | "cloud_essd" | 否 |
| vswitch_id | 用于网络配置的交换机ID | string | - | 是 |
| zone_id | 实例可用区ID | string | "" | 否 |
| encryption_key | 用于磁盘加密的KMS密钥ID | string | - | 是 |
| role_arn | 用于KMS访问授权的ARN | string | "" | 否 |
| security_ips | 安全IP列表 | list(string) | [] | 否 |
| tags | 资源标签 | map(string) | {} | 否 |

## 输出变量

| 名称 | 描述 |
|------|------|
| db_instance_id | 创建的PolarDB实例ID |
| instance_name | PolarDB实例名称 |
| connection_string | 实例连接地址 |
| port | 数据库连接端口 |
| engine | 数据库引擎类型 |
| encryption_enabled | 是否启用了加密 |

## 注意事项

- 本示例需要预先创建KMS密钥用于加密。
- `encryption_key`参数启用云盘加密，启用后无法关闭。
- 使用加密时需要`role_arn`来授权POLARDB服务访问KMS。

