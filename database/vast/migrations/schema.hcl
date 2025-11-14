table "app_version" {
  schema = schema.public
  column "created_at" {
    null = false
    type = timestamptz
  }
  column "created_by" {
    null = false
    type = character_varying(255)
  }
  column "updated_at" {
    null = false
    type = timestamptz
  }
  column "updated_by" {
    null = false
    type = character_varying(255)
  }
  column "version" {
    null = false
    type = character_varying(10)
  }
  column "changelog" {
    null = false
    type = text
  }
  column "status" {
    null = false
    type = character_varying(255)
  }
  primary_key {
    columns = [column.version]
  }
}
table "bank" {
  schema = schema.public
  column "created_at" {
    null = false
    type = timestamptz
  }
  column "created_by" {
    null = false
    type = character_varying(255)
  }
  column "updated_at" {
    null = false
    type = timestamptz
  }
  column "updated_by" {
    null = false
    type = character_varying(255)
  }
  column "bank_code" {
    null = false
    type = character_varying(255)
  }
  column "bank_name" {
    null = true
    type = character_varying(255)
  }
  primary_key {
    columns = [column.bank_code]
  }
}
table "bank_account" {
  schema = schema.public
  column "created_at" {
    null = false
    type = timestamptz
  }
  column "created_by" {
    null = false
    type = character_varying(255)
  }
  column "updated_at" {
    null = false
    type = timestamptz
  }
  column "updated_by" {
    null = false
    type = character_varying(255)
  }
  column "customer_code" {
    null = false
    type = character_varying(255)
  }
  column "package_name" {
    null = false
    type = character_varying(255)
  }
  column "bank_code" {
    null = false
    type = character_varying(255)
  }
  column "bank_account_number" {
    null = false
    type = character_varying(255)
  }
  column "bank_account_name" {
    null = false
    type = character_varying(255)
  }
  column "bank_credential" {
    null = false
    type = jsonb
  }
  column "is_active" {
    null = false
    type = boolean
  }
  primary_key {
    columns = [column.customer_code, column.bank_account_number]
  }
  foreign_key "bank_account_bank_code_package_name_fkey" {
    columns     = [column.bank_code, column.package_name]
    ref_columns = [table.bank_app.column.bank_code, table.bank_app.column.package_name]
    on_update   = NO_ACTION
    on_delete   = RESTRICT
  }
  foreign_key "bank_account_customer_code_fkey" {
    columns     = [column.customer_code]
    ref_columns = [table.customer.column.customer_code]
    on_update   = NO_ACTION
    on_delete   = RESTRICT
  }
}
table "bank_account_archive" {
  schema = schema.public
  column "created_at" {
    null = false
    type = timestamptz
  }
  column "created_by" {
    null = false
    type = character_varying(255)
  }
  column "updated_at" {
    null = false
    type = timestamptz
  }
  column "updated_by" {
    null = false
    type = character_varying(255)
  }
  column "deleted_at" {
    null = false
    type = timestamptz
  }
  column "deleted_by" {
    null = false
    type = character_varying(255)
  }
  column "customer_code" {
    null = false
    type = character_varying(255)
  }
  column "package_name" {
    null = false
    type = character_varying(255)
  }
  column "bank_code" {
    null = false
    type = character_varying(255)
  }
  column "bank_account_number" {
    null = false
    type = character_varying(255)
  }
  column "bank_account_name" {
    null = false
    type = character_varying(255)
  }
  column "bank_credential" {
    null = false
    type = jsonb
  }
  column "is_active" {
    null = false
    type = boolean
  }
}
table "bank_account_auto_transfer_setting" {
  schema = schema.public
  column "created_at" {
    null = false
    type = timestamptz
  }
  column "created_by" {
    null = false
    type = character_varying(255)
  }
  column "updated_at" {
    null = false
    type = timestamptz
  }
  column "updated_by" {
    null = false
    type = character_varying(255)
  }
  column "customer_code" {
    null = false
    type = character_varying(255)
  }
  column "bank_account_number" {
    null = false
    type = character_varying(255)
  }
  column "bank_destination_account_name" {
    null = false
    type = character_varying(255)
  }
  column "bank_destination_account_number" {
    null = false
    type = character_varying(255)
  }
  column "min_amount_transfer" {
    null = false
    type = bigint
  }
  primary_key {
    columns = [column.customer_code, column.bank_account_number]
  }
  foreign_key "bank_account_auto_transfer_se_customer_code_bank_account_n_fkey" {
    columns     = [column.customer_code, column.bank_account_number]
    ref_columns = [table.bank_account.column.customer_code, table.bank_account.column.bank_account_number]
    on_update   = NO_ACTION
    on_delete   = RESTRICT
  }
}
table "bank_account_withdraw_setting" {
  schema = schema.public
  column "created_at" {
    null = false
    type = timestamptz
  }
  column "created_by" {
    null = false
    type = character_varying(255)
  }
  column "updated_at" {
    null = false
    type = timestamptz
  }
  column "updated_by" {
    null = false
    type = character_varying(255)
  }
  column "customer_code" {
    null = false
    type = character_varying(255)
  }
  column "bank_account_number" {
    null = false
    type = character_varying(255)
  }
  column "max_wd_amount" {
    null = false
    type = bigint
  }
  primary_key {
    columns = [column.customer_code, column.bank_account_number]
  }
  foreign_key "bank_account_withdraw_setting_customer_code_bank_account_n_fkey" {
    columns     = [column.customer_code, column.bank_account_number]
    ref_columns = [table.bank_account.column.customer_code, table.bank_account.column.bank_account_number]
    on_update   = NO_ACTION
    on_delete   = RESTRICT
  }
}
table "bank_app" {
  schema = schema.public
  column "created_at" {
    null = false
    type = timestamptz
  }
  column "created_by" {
    null = false
    type = character_varying(255)
  }
  column "updated_at" {
    null = false
    type = timestamptz
  }
  column "updated_by" {
    null = false
    type = character_varying(255)
  }
  column "bank_code" {
    null = false
    type = character_varying(255)
  }
  column "package_name" {
    null = false
    type = character_varying(255)
  }
  column "app_name" {
    null = false
    type = character_varying(255)
  }
  column "meta_data" {
    null = false
    type = jsonb
  }
  primary_key {
    columns = [column.bank_code, column.package_name]
  }
  foreign_key "bank_app_bank_code_fkey" {
    columns     = [column.bank_code]
    ref_columns = [table.bank.column.bank_code]
    on_update   = NO_ACTION
    on_delete   = RESTRICT
  }
}
table "brand_account" {
  schema = schema.public
  column "created_at" {
    null = false
    type = timestamptz
  }
  column "created_by" {
    null = false
    type = character_varying(255)
  }
  column "updated_at" {
    null = false
    type = timestamptz
  }
  column "updated_by" {
    null = false
    type = character_varying(255)
  }
  column "customer_code" {
    null = false
    type = character_varying(255)
  }
  column "engine" {
    null = false
    type = character_varying(255)
  }
  column "username" {
    null = false
    type = character_varying(255)
  }
  column "password_hash" {
    null = false
    type = text
  }
  primary_key {
    columns = [column.customer_code, column.engine, column.username]
  }
  foreign_key "brand_account_customer_code_engine_fkey" {
    columns     = [column.customer_code, column.engine]
    ref_columns = [table.brand_config.column.customer_code, table.brand_config.column.engine]
    on_update   = NO_ACTION
    on_delete   = RESTRICT
  }
}
table "brand_config" {
  schema = schema.public
  column "created_at" {
    null = false
    type = timestamptz
  }
  column "created_by" {
    null = false
    type = character_varying(255)
  }
  column "updated_at" {
    null = false
    type = timestamptz
  }
  column "updated_by" {
    null = false
    type = character_varying(255)
  }
  column "customer_code" {
    null = false
    type = character_varying(255)
  }
  column "engine" {
    null = false
    type = character_varying(255)
  }
  column "panel_url" {
    null = false
    type = text
  }
  primary_key {
    columns = [column.customer_code, column.engine]
  }
  foreign_key "brand_config_customer_code_fkey" {
    columns     = [column.customer_code]
    ref_columns = [table.customer.column.customer_code]
    on_update   = NO_ACTION
    on_delete   = RESTRICT
  }
}
table "customer" {
  schema = schema.public
  column "created_at" {
    null = false
    type = timestamptz
  }
  column "created_by" {
    null = false
    type = character_varying(255)
  }
  column "updated_at" {
    null = false
    type = timestamptz
  }
  column "updated_by" {
    null = false
    type = character_varying(255)
  }
  column "customer_code" {
    null = false
    type = character_varying(255)
  }
  column "customer_name" {
    null = false
    type = character_varying(255)
  }
  primary_key {
    columns = [column.customer_code]
  }
}
table "permission" {
  schema = schema.public
  column "code" {
    null = false
    type = character_varying(255)
  }
  column "description" {
    null = true
    type = character_varying(255)
  }
  primary_key {
    columns = [column.code]
  }
}
table "role" {
  schema = schema.public
  column "id" {
    null = false
    type = bigint
    identity {
      generated = BY_DEFAULT
    }
  }
  column "created_at" {
    null = false
    type = timestamptz
  }
  column "created_by" {
    null = false
    type = character_varying(255)
  }
  column "updated_at" {
    null = false
    type = timestamptz
  }
  column "updated_by" {
    null = false
    type = character_varying(255)
  }
  column "customer_code" {
    null = false
    type = character_varying(255)
  }
  column "role_name" {
    null = false
    type = character_varying(255)
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "role_customer_code_fkey" {
    columns     = [column.customer_code]
    ref_columns = [table.customer.column.customer_code]
    on_update   = NO_ACTION
    on_delete   = RESTRICT
  }
  index "role_customer_code_role_name_idx" {
    unique  = true
    columns = [column.customer_code, column.role_name]
  }
}
table "role_permission" {
  schema = schema.public
  column "id" {
    null = false
    type = bigint
    identity {
      generated = BY_DEFAULT
    }
  }
  column "role_id" {
    null = false
    type = bigint
  }
  column "permission_code" {
    null = false
    type = character_varying(255)
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "role_permission_permission_code_fkey" {
    columns     = [column.permission_code]
    ref_columns = [table.permission.column.code]
    on_update   = NO_ACTION
    on_delete   = RESTRICT
  }
  foreign_key "role_permission_role_id_fkey" {
    columns     = [column.role_id]
    ref_columns = [table.role.column.id]
    on_update   = NO_ACTION
    on_delete   = RESTRICT
  }
}
table "subscription" {
  schema = schema.public
  column "created_at" {
    null = false
    type = timestamptz
  }
  column "created_by" {
    null = false
    type = character_varying(255)
  }
  column "updated_at" {
    null = false
    type = timestamptz
  }
  column "updated_by" {
    null = false
    type = character_varying(255)
  }
  column "customer_code" {
    null = false
    type = character_varying(255)
  }
  column "start_date" {
    null = false
    type = timestamptz
  }
  column "end_date" {
    null = false
    type = timestamptz
  }
  column "status" {
    null    = false
    type    = character_varying
    comment = "ACTIVE, EXPIRED, IN_ACTIVE"
  }
  primary_key {
    columns = [column.customer_code]
  }
  foreign_key "subscription_customer_code_fkey" {
    columns     = [column.customer_code]
    ref_columns = [table.customer.column.customer_code]
    on_update   = NO_ACTION
    on_delete   = RESTRICT
  }
}
table "transaction_deposit" {
  schema = schema.public
  column "id" {
    null = false
    type = bigint
    identity {
      generated = BY_DEFAULT
    }
  }
  column "created_at" {
    null = false
    type = timestamptz
  }
  column "created_by" {
    null = false
    type = character_varying(255)
  }
  column "updated_at" {
    null = false
    type = timestamptz
  }
  column "updated_by" {
    null = false
    type = character_varying(255)
  }
  column "customer_code" {
    null = false
    type = character_varying(255)
  }
  column "mutation_date" {
    null = false
    type = timestamptz
  }
  column "mutation_no" {
    null = false
    type = character_varying(255)
  }
  column "bank_code" {
    null = false
    type = character_varying(255)
  }
  column "bank_account_name" {
    null = false
    type = character_varying(255)
  }
  column "bank_account_number" {
    null = false
    type = character_varying(255)
  }
  column "transferred_from" {
    null = false
    type = character_varying(255)
  }
  column "amount" {
    null = false
    type = numeric(22,5)
  }
  column "status" {
    null    = false
    type    = character_varying(255)
    comment = "WAITING, MATCHING, SUCCESS, DONE_BY_USER, FAILED,NO_MATCH"
  }
  column "approved_at" {
    null = true
    type = timestamptz
  }
  column "player_username" {
    null = true
    type = character_varying(255)
  }
  column "deposit_number" {
    null = true
    type = character_varying(255)
  }
  column "remark" {
    null = true
    type = character_varying(255)
  }
  primary_key {
    columns = [column.id, column.customer_code]
  }
  foreign_key "transaction_deposit_customer_code_fkey" {
    columns     = [column.customer_code]
    ref_columns = [table.customer.column.customer_code]
    on_update   = NO_ACTION
    on_delete   = RESTRICT
  }
  partition {
    type    = LIST
    columns = [column.customer_code]
  }
}
table "transaction_withdraw" {
  schema = schema.public
  column "id" {
    null = false
    type = bigint
    identity {
      generated = BY_DEFAULT
    }
  }
  column "created_at" {
    null = false
    type = timestamptz
  }
  column "created_by" {
    null = false
    type = character_varying(255)
  }
  column "updated_at" {
    null = false
    type = timestamptz
  }
  column "updated_by" {
    null = false
    type = character_varying(255)
  }
  column "customer_code" {
    null = false
    type = character_varying(255)
  }
  column "bank_code" {
    null = false
    type = character_varying(255)
  }
  column "bank_account_name" {
    null = false
    type = character_varying(255)
  }
  column "bank_account_number" {
    null = false
    type = character_varying(255)
  }
  column "bank_destination_account_name" {
    null = false
    type = character_varying(255)
  }
  column "bank_destination_account_number" {
    null = false
    type = character_varying(255)
  }
  column "transaction_type" {
    null    = false
    type    = character_varying(255)
    comment = "WD, AUTO_TF"
  }
  column "amount" {
    null = false
    type = numeric(22,5)
  }
  column "status" {
    null    = false
    type    = character_varying(255)
    comment = "WAITING, MATCHING, SUCCESS, DONE_BY_USER, FAILED, NO_MATCH"
  }
  column "transferred_at" {
    null = true
    type = timestamptz
  }
  column "player_username" {
    null = true
    type = character_varying(255)
  }
  column "withdraw_number" {
    null = true
    type = character_varying(255)
  }
  column "remark" {
    null = true
    type = character_varying(255)
  }
  primary_key {
    columns = [column.id, column.customer_code]
  }
  foreign_key "transaction_withdraw_customer_code_fkey" {
    columns     = [column.customer_code]
    ref_columns = [table.customer.column.customer_code]
    on_update   = NO_ACTION
    on_delete   = RESTRICT
  }
  partition {
    type    = LIST
    columns = [column.customer_code]
  }
}
table "trusted_device" {
  schema = schema.public
  column "created_at" {
    null = false
    type = timestamptz
  }
  column "created_by" {
    null = false
    type = character_varying(255)
  }
  column "updated_at" {
    null = false
    type = timestamptz
  }
  column "updated_by" {
    null = false
    type = character_varying(255)
  }
  column "customer_code" {
    null = false
    type = character_varying(255)
  }
  column "username" {
    null = false
    type = character_varying(255)
  }
  column "hwid" {
    null = false
    type = character_varying(255)
  }
  column "registered_at" {
    null = false
    type = timestamptz
  }
  primary_key {
    columns = [column.customer_code, column.username]
  }
  foreign_key "trusted_device_customer_code_username_fkey" {
    columns     = [column.customer_code, column.username]
    ref_columns = [table.user.column.customer_code, table.user.column.username]
    on_update   = NO_ACTION
    on_delete   = RESTRICT
  }
}
table "user" {
  schema = schema.public
  column "created_at" {
    null = false
    type = timestamptz
  }
  column "created_by" {
    null = false
    type = character_varying(255)
  }
  column "updated_at" {
    null = false
    type = timestamptz
  }
  column "updated_by" {
    null = false
    type = character_varying(255)
  }
  column "customer_code" {
    null = false
    type = character_varying(255)
  }
  column "username" {
    null = false
    type = character_varying(255)
  }
  column "status" {
    null    = false
    type    = character_varying(255)
    comment = "ACTIVE, INACTIVE, LOCKED"
  }
  column "login_type" {
    null    = false
    type    = character_varying(255)
    comment = "WEB, DESKTOP"
  }
  column "display_name" {
    null = true
    type = character_varying(255)
  }
  primary_key {
    columns = [column.customer_code, column.username]
  }
  foreign_key "user_customer_code_fkey" {
    columns     = [column.customer_code]
    ref_columns = [table.customer.column.customer_code]
    on_update   = NO_ACTION
    on_delete   = RESTRICT
  }
  index "ux_user_customer_desktop" {
    unique  = true
    columns = [column.customer_code]
    where   = "((login_type)::text = 'DESKTOP'::text)"
  }
}
table "user_auth_history" {
  schema = schema.public
  column "id" {
    null = false
    type = bigint
    identity {
      generated = BY_DEFAULT
    }
  }
  column "created_at" {
    null    = false
    type    = timestamptz
    default = sql("now()")
  }
  column "created_by" {
    null = false
    type = character_varying(255)
  }
  column "updated_at" {
    null    = false
    type    = timestamptz
    default = sql("now()")
  }
  column "updated_by" {
    null = false
    type = character_varying(255)
  }
  column "customer_code" {
    null = false
    type = character_varying(255)
  }
  column "username" {
    null = false
    type = character_varying(255)
  }
  column "ip_address" {
    null = false
    type = character_varying(255)
  }
  column "user_agent" {
    null = false
    type = character_varying(255)
  }
  column "last_location" {
    null = false
    type = character_varying(255)
  }
  column "last_source" {
    null    = false
    type    = character_varying(255)
    comment = "WEB, DEKSTOP, etc.."
  }
  column "history_type" {
    null    = false
    type    = character_varying(255)
    comment = "LOGIN, LOGOUT, INVALID_PASSWORD, etc.."
  }
  column "fail_reason" {
    null = false
    type = text
  }
  column "fail_attempts" {
    null = false
    type = integer
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "user_auth_history_customer_code_username_fkey" {
    columns     = [column.customer_code, column.username]
    ref_columns = [table.user.column.customer_code, table.user.column.username]
    on_update   = NO_ACTION
    on_delete   = RESTRICT
  }
}
table "user_credential" {
  schema = schema.public
  column "created_at" {
    null = false
    type = timestamptz
  }
  column "created_by" {
    null = false
    type = character_varying(255)
  }
  column "updated_at" {
    null = false
    type = timestamptz
  }
  column "updated_by" {
    null = false
    type = character_varying(255)
  }
  column "customer_code" {
    null = false
    type = character_varying(255)
  }
  column "username" {
    null = false
    type = character_varying(255)
  }
  column "password_hash" {
    null = false
    type = text
  }
  primary_key {
    columns = [column.customer_code, column.username]
  }
  foreign_key "user_credential_customer_code_username_fkey" {
    columns     = [column.customer_code, column.username]
    ref_columns = [table.user.column.customer_code, table.user.column.username]
    on_update   = NO_ACTION
    on_delete   = RESTRICT
  }
}
table "user_role" {
  schema = schema.public
  column "customer_code" {
    null = false
    type = character_varying(255)
  }
  column "username" {
    null = false
    type = character_varying(255)
  }
  column "role_id" {
    null = true
    type = bigint
  }
  primary_key {
    columns = [column.customer_code, column.username]
  }
  foreign_key "user_role_customer_code_username_fkey" {
    columns     = [column.customer_code, column.username]
    ref_columns = [table.user.column.customer_code, table.user.column.username]
    on_update   = NO_ACTION
    on_delete   = RESTRICT
  }
  foreign_key "user_role_role_id_fkey" {
    columns     = [column.role_id]
    ref_columns = [table.role.column.id]
    on_update   = NO_ACTION
    on_delete   = RESTRICT
  }
}
schema "public" {
  comment = "standard public schema"
}
