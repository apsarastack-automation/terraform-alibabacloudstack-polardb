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
    name           = "tfpolardb-existing"
    engine         = "MySQL"
    engine_version = "8.0"
    vswitch_id     = run.setup_vpc.vswitch_id
  }
}

run "validate" {
  command = apply
  module {
    source = "../examples/use-existing-instance"
  }
  variables {
    db_instance_id = run.setup_instance.db_instance_id
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
  }
  
  assert {
    condition     = length(output.database_names) == 2
    error_message = "The number of databases does not match"
  }
}
