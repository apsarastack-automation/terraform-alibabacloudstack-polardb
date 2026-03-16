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
    source = "../examples/create-mysql-with-account-database-binding"
  }
  variables {
    name           = "tfpolardb-mysql-binding"
    engine_version = "8.0"
    vswitch_id     = run.setup_vpc.vswitch_id
    
    databases = {
      testdb1 = {
        character_set_name = "utf8mb4"
        description        = "Test database 1"
      }
      testdb2 = {
        character_set_name = "utf8"
        description        = "Test database 2"
      }
    }
    
    accounts = {
      testuser = {
        password     = "TestPassword123!"
        account_type = "Normal"
        account_privileges = {
          testdb1 = "ReadWrite"
          testdb2 = "ReadOnly"
        }
      }
    }
  }
  
  assert {
    condition     = output.db_instance_id != ""
    error_message = "PolarDB MySQL instance creation failed"
  }
  
  assert {
    condition     = length(output.database_names) == 2
    error_message = "The number of databases does not match"
  }
  
  assert {
    condition     = length(output.account_names) == 1
    error_message = "The number of accounts does not match"
  }
  
  assert {
    condition     = output.binding_mode == "account_database_binding"
    error_message = "Should use account_database_binding mode"
  }
}
