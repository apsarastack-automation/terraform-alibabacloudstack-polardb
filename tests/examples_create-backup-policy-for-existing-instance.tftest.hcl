run "setup_vpc" {
  command = apply
  module {
    source = "./setup_vpc/simple_vpc"
  }
  variables {
    name = "tfpolardb"
  }
}

run "setup_instance" {
  command = apply
  module {
    source = "../modules/polardb_instance"
  }
  variables {
    name           = "tfpolardb-backup"
    engine         = "MySQL"
    engine_version = "8.0"
    vswitch_id     = run.setup_vpc.vswitch_id
  }
}

run "validate" {
  command = apply
  module {
    source = "../examples/create-backup-policy-for-existing-instance"
  }
  variables {
    db_instance_id          = run.setup_instance.db_instance_id
    backup_retention_period = 14
    preferred_backup_period = "Monday,Wednesday,Friday,Sunday"
    preferred_backup_time   = "03:00Z-04:00Z"
    enable_backup_log       = 1
    compress_type           = 1
  }
  
  assert {
    condition     = output.db_instance_id != ""
    error_message = "Instance ID should match the existing instance"
  }
  
  assert {
    condition     = output.backup_policy_applied == true
    error_message = "Backup policy should be applied"
  }
  
  assert {
    condition     = output.backup_retention_period == 14
    error_message = "Backup retention period should be 14 days"
  }
  
  assert {
    condition     = output.preferred_backup_period == "Monday,Wednesday,Friday,Sunday"
    error_message = "Backup period should match the configured value"
  }
}
