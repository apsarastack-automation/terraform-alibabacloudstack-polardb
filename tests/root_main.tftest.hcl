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
    source = "../"
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
  }

  assert {
    condition     = output.db_instance_id != ""
    error_message = "PolarDB instance ID should not be empty."
  }

  assert {
    condition     = output.instance_name == "tfpolardb"
    error_message = "Instance name should match the input."
  }

  assert {
    condition     = length(output.database_names) == 1
    error_message = "Exactly one database should be created."
  }
}
