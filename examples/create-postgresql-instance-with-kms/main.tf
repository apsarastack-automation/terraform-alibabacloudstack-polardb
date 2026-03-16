module "polardb" {
  source = "../../modules/polardb_instance"

  name           = var.name
  engine         = var.engine
  engine_version = var.engine_version
  vswitch_id     = var.vswitch_id

  # Enable encryption with KMS key
  tde_status     = var.tde_status
  encryption_key = var.encryption_key

  security_ips = var.security_ips

  tags = var.tags
}

# $env:ALIBABACLOUDSTACK_ASAPI_ENDPOINT="internal.asapi.cn-wulan-env205-d01.intra.env205.shuguang.com"
# $env:ALIBABACLOUDSTACK_POPGW_DOMAIN="inter.env205.shuguang.com"
# $env:ALIBABACLOUDSTACK_ACCESS_KEY="48DXKvonhmOJcrd1"
# $env:ALIBABACLOUDSTACK_SECRET_KEY="fYgrvBSR9AlMovUBgDsQ393cZVWzVm"
# $env:ALIBABACLOUDSTACK_INSECURE="true"
# $env:ALIBABACLOUDSTACK_PROTOCOL="HTTP"
# $env:ALIBABACLOUDSTACK_REGION="cn-wulan-env205-d01"
# $env:ALIBABACLOUDSTACK_RESOURCE_GROUP_SET="ld_test"
# $env:TF_ACC="1"