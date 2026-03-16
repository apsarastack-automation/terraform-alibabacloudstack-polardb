data "alibabacloudstack_zones" "existing" {
  available_resource_creation = "VSwitch"
}

resource "alibabacloudstack_vpc_vpc" "existing" {
  cidr_block = "172.16.0.0/16"
  vpc_name   = "${var.name}-vpc"
}

resource "alibabacloudstack_vpc_vswitch" "existing" {
  vpc_id       = alibabacloudstack_vpc_vpc.existing.id
  cidr_block   = "172.16.0.0/24"
  zone_id      = data.alibabacloudstack_zones.existing.zones[0].id
  vswitch_name = "${var.name}-vswitch"
}
