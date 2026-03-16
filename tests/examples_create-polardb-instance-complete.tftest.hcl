run "setup_vpc" {
  command = apply
  module {
    source = "./setup_vpc/simple_vpc"
  }
  variables {
    name = "tfpolardb"
  }
}

run "validate" {
  command = apply
  module {
    source = "../examples/create-polardb-instance-complete"
  }
  variables {
    name           = "tfpolardb"
    engine         = "MySQL"
    engine_version = "8.0"
    vswitch_id     = run.setup_vpc.vswitch_id
    
    databases = {
      testdb = {
        character_set_name = "utf8mb4"
        description        = "Test database"
      }
    }
    
    accounts = {}
    
    backup_policy = {
      backup_retention_period = 7
      preferred_backup_period = "Monday,Wednesday,Friday"
      preferred_backup_time   = "02:00Z-03:00Z"
      enable_backup_log       = 1
      compress_type           = 1
    }
    
    db_connection_prefix = "testdb"
    port                 = 3306
  }
  
  assert {
    condition     = output.db_instance_id != ""
    error_message = "PolarDB instance creation failed"
  }
  
  assert {
    condition     = length(output.database_names) == 1
    error_message = "The number of databases does not match"
  }
}
