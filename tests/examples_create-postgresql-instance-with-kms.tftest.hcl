run "setup_vpc" {
  command = apply
  module {
    source = "./setup_vpc/simple_vpc"
  }
  variables {
    name = "tfpolardb"
  }
}

run "setup_kms" {
  command = apply
  module {
    source = "./setup_kms"
  }
  variables {
    name = "tfpolardb"
  }
}

run "validate" {
  command = apply
  module {
    source = "../examples/create-postgresql-instance-with-kms"
  }
  variables {
    name           = "tfpolardb-pg"
    engine         = "PolarDB_PG"
    engine_version = "14"
    vswitch_id     = run.setup_vpc.vswitch_id
    tde_status     = true
    encryption_key = run.setup_kms.kms_key_id
    role_arn       = run.setup_kms.kms_key_arn
  }

  assert {
    condition     = output.db_instance_id != ""
    error_message = "PolarDB PolarDB_PG instance creation failed"
  }

  assert {
    condition     = output.engine == "PolarDB_PG"
    error_message = "Engine should be PolarDB_PG"
  }

  assert {
    condition     = output.encryption_enabled == true
    error_message = "Encryption should be enabled"
  }
}
