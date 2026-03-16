resource "alibabacloudstack_kms_key" "default" {
  description            = "Test KMS key for PolarDB encryption"
  pending_window_in_days = 7
  key_state              = "Enabled"
}
