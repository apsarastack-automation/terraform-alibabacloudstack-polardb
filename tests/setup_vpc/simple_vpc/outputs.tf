output "vpc_id" {
  description = "The ID of the created VPC."
  value       = alibabacloudstack_vpc_vpc.existing.id
}

output "vswitch_id" {
  description = "The ID of the created VSwitch."
  value       = alibabacloudstack_vpc_vswitch.existing.id
}
