-- create "bank" table
CREATE TABLE "public"."bank" (
  "created_at" timestamptz NOT NULL,
  "created_by" character varying(255) NOT NULL,
  "updated_at" timestamptz NOT NULL,
  "updated_by" character varying(255) NOT NULL,
  "bank_code" character varying(255) NOT NULL,
  "bank_name" character varying(255) NULL,
  PRIMARY KEY ("bank_code")
);
-- create "bank_account_archive" table
CREATE TABLE "public"."bank_account_archive" (
  "created_at" timestamptz NOT NULL,
  "created_by" character varying(255) NOT NULL,
  "updated_at" timestamptz NOT NULL,
  "updated_by" character varying(255) NOT NULL,
  "deleted_at" timestamptz NOT NULL,
  "deleted_by" character varying(255) NOT NULL,
  "customer_code" character varying(255) NOT NULL,
  "package_name" character varying(255) NOT NULL,
  "bank_code" character varying(255) NOT NULL,
  "bank_account_number" character varying(255) NOT NULL,
  "bank_account_name" character varying(255) NOT NULL,
  "bank_credential" jsonb NOT NULL,
  "is_active" boolean NOT NULL
);
-- create "app_version" table
CREATE TABLE "public"."app_version" (
  "created_at" timestamptz NOT NULL,
  "created_by" character varying(255) NOT NULL,
  "updated_at" timestamptz NOT NULL,
  "updated_by" character varying(255) NOT NULL,
  "version" character varying(255) NOT NULL,
  "changelog" text NOT NULL,
  "status" character varying(255) NOT NULL,
  PRIMARY KEY ("version")
);
-- create "bank_app" table
CREATE TABLE "public"."bank_app" (
  "created_at" timestamptz NOT NULL,
  "created_by" character varying(255) NOT NULL,
  "updated_at" timestamptz NOT NULL,
  "updated_by" character varying(255) NOT NULL,
  "bank_code" character varying(255) NOT NULL,
  "package_name" character varying(255) NOT NULL,
  "app_name" character varying(255) NOT NULL,
  "meta_data" jsonb NOT NULL,
  PRIMARY KEY ("bank_code", "package_name"),
  CONSTRAINT "bank_app_bank_code_fkey" FOREIGN KEY ("bank_code") REFERENCES "public"."bank" ("bank_code") ON UPDATE NO ACTION ON DELETE RESTRICT
);
-- create "customer" table
CREATE TABLE "public"."customer" (
  "created_at" timestamptz NOT NULL,
  "created_by" character varying(255) NOT NULL,
  "updated_at" timestamptz NOT NULL,
  "updated_by" character varying(255) NOT NULL,
  "customer_code" character varying(255) NOT NULL,
  "customer_name" character varying(255) NOT NULL,
  PRIMARY KEY ("customer_code")
);
-- create "bank_account" table
CREATE TABLE "public"."bank_account" (
  "created_at" timestamptz NOT NULL,
  "created_by" character varying(255) NOT NULL,
  "updated_at" timestamptz NOT NULL,
  "updated_by" character varying(255) NOT NULL,
  "customer_code" character varying(255) NOT NULL,
  "package_name" character varying(255) NOT NULL,
  "bank_code" character varying(255) NOT NULL,
  "bank_account_number" character varying(255) NOT NULL,
  "bank_account_name" character varying(255) NOT NULL,
  "bank_credential" jsonb NOT NULL,
  "is_active" boolean NOT NULL,
  PRIMARY KEY ("customer_code", "bank_account_number"),
  CONSTRAINT "bank_account_bank_code_package_name_fkey" FOREIGN KEY ("bank_code", "package_name") REFERENCES "public"."bank_app" ("bank_code", "package_name") ON UPDATE NO ACTION ON DELETE RESTRICT,
  CONSTRAINT "bank_account_customer_code_fkey" FOREIGN KEY ("customer_code") REFERENCES "public"."customer" ("customer_code") ON UPDATE NO ACTION ON DELETE RESTRICT
);
-- create "bank_account_auto_transfer_setting" table
CREATE TABLE "public"."bank_account_auto_transfer_setting" (
  "created_at" timestamptz NOT NULL,
  "created_by" character varying(255) NOT NULL,
  "updated_at" timestamptz NOT NULL,
  "updated_by" character varying(255) NOT NULL,
  "customer_code" character varying(255) NOT NULL,
  "bank_account_number" character varying(255) NOT NULL,
  "bank_destination_account_name" character varying(255) NOT NULL,
  "bank_destination_account_number" character varying(255) NOT NULL,
  "min_amount_transfer" bigint NOT NULL,
  PRIMARY KEY ("customer_code", "bank_account_number"),
  CONSTRAINT "bank_account_auto_transfer_se_customer_code_bank_account_n_fkey" FOREIGN KEY ("customer_code", "bank_account_number") REFERENCES "public"."bank_account" ("customer_code", "bank_account_number") ON UPDATE NO ACTION ON DELETE RESTRICT
);
-- create "bank_account_withdraw_setting" table
CREATE TABLE "public"."bank_account_withdraw_setting" (
  "created_at" timestamptz NOT NULL,
  "created_by" character varying(255) NOT NULL,
  "updated_at" timestamptz NOT NULL,
  "updated_by" character varying(255) NOT NULL,
  "customer_code" character varying(255) NOT NULL,
  "bank_account_number" character varying(255) NOT NULL,
  "max_wd_amount" bigint NOT NULL,
  PRIMARY KEY ("customer_code", "bank_account_number"),
  CONSTRAINT "bank_account_withdraw_setting_customer_code_bank_account_n_fkey" FOREIGN KEY ("customer_code", "bank_account_number") REFERENCES "public"."bank_account" ("customer_code", "bank_account_number") ON UPDATE NO ACTION ON DELETE RESTRICT
);
-- create "brand_config" table
CREATE TABLE "public"."brand_config" (
  "created_at" timestamptz NOT NULL,
  "created_by" character varying(255) NOT NULL,
  "updated_at" timestamptz NOT NULL,
  "updated_by" character varying(255) NOT NULL,
  "customer_code" character varying(255) NOT NULL,
  "engine" character varying(255) NOT NULL,
  "panel_url" text NOT NULL,
  PRIMARY KEY ("customer_code", "engine"),
  CONSTRAINT "brand_config_customer_code_fkey" FOREIGN KEY ("customer_code") REFERENCES "public"."customer" ("customer_code") ON UPDATE NO ACTION ON DELETE RESTRICT
);
-- create "brand_account" table
CREATE TABLE "public"."brand_account" (
  "created_at" timestamptz NOT NULL,
  "created_by" character varying(255) NOT NULL,
  "updated_at" timestamptz NOT NULL,
  "updated_by" character varying(255) NOT NULL,
  "customer_code" character varying(255) NOT NULL,
  "engine" character varying(255) NOT NULL,
  "username" character varying(255) NOT NULL,
  "password_hash" text NOT NULL,
  PRIMARY KEY ("customer_code", "engine", "username"),
  CONSTRAINT "brand_account_customer_code_engine_fkey" FOREIGN KEY ("customer_code", "engine") REFERENCES "public"."brand_config" ("customer_code", "engine") ON UPDATE NO ACTION ON DELETE RESTRICT
);
-- create "role" table
CREATE TABLE "public"."role" (
  "id" bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  "created_at" timestamptz NOT NULL,
  "created_by" character varying(255) NOT NULL,
  "updated_at" timestamptz NOT NULL,
  "updated_by" character varying(255) NOT NULL,
  "customer_code" character varying(255) NOT NULL,
  "role_name" character varying(255) NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "role_customer_code_fkey" FOREIGN KEY ("customer_code") REFERENCES "public"."customer" ("customer_code") ON UPDATE NO ACTION ON DELETE RESTRICT
);
-- create index "role_customer_code_role_name_idx" to table: "role"
CREATE UNIQUE INDEX "role_customer_code_role_name_idx" ON "public"."role" ("customer_code", "role_name");
-- create "permission" table
CREATE TABLE "public"."permission" (
  "code" character varying(255) NOT NULL,
  "description" character varying(255) NULL,
  PRIMARY KEY ("code")
);
-- create "role_permission" table
CREATE TABLE "public"."role_permission" (
  "id" bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  "role_id" bigint NOT NULL,
  "permission_code" character varying(255) NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "role_permission_permission_code_fkey" FOREIGN KEY ("permission_code") REFERENCES "public"."permission" ("code") ON UPDATE NO ACTION ON DELETE RESTRICT,
  CONSTRAINT "role_permission_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "public"."role" ("id") ON UPDATE NO ACTION ON DELETE RESTRICT
);
-- create "subscription" table
CREATE TABLE "public"."subscription" (
  "created_at" timestamptz NOT NULL,
  "created_by" character varying(255) NOT NULL,
  "updated_at" timestamptz NOT NULL,
  "updated_by" character varying(255) NOT NULL,
  "customer_code" character varying(255) NOT NULL,
  "start_date" timestamptz NOT NULL,
  "end_date" timestamptz NOT NULL,
  "status" character varying NOT NULL,
  PRIMARY KEY ("customer_code"),
  CONSTRAINT "subscription_customer_code_fkey" FOREIGN KEY ("customer_code") REFERENCES "public"."customer" ("customer_code") ON UPDATE NO ACTION ON DELETE RESTRICT
);
-- set comment to column: "status" on table: "subscription"
COMMENT ON COLUMN "public"."subscription"."status" IS 'ACTIVE, EXPIRED, IN_ACTIVE';
-- create "transaction_deposit" table
CREATE TABLE "public"."transaction_deposit" (
  "id" bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  "created_at" timestamptz NOT NULL,
  "created_by" character varying(255) NOT NULL,
  "updated_at" timestamptz NOT NULL,
  "updated_by" character varying(255) NOT NULL,
  "customer_code" character varying(255) NOT NULL,
  "mutation_date" timestamptz NOT NULL,
  "mutation_no" character varying(255) NOT NULL,
  "bank_code" character varying(255) NOT NULL,
  "bank_account_name" character varying(255) NOT NULL,
  "bank_account_number" character varying(255) NOT NULL,
  "transferred_from" character varying(255) NOT NULL,
  "amount" numeric(22,5) NOT NULL,
  "status" character varying(255) NOT NULL,
  "approved_at" timestamptz NULL,
  "player_username" character varying(255) NULL,
  "deposit_number" character varying(255) NULL,
  "remark" character varying(255) NULL,
  PRIMARY KEY ("id", "customer_code"),
  CONSTRAINT "transaction_deposit_customer_code_fkey" FOREIGN KEY ("customer_code") REFERENCES "public"."customer" ("customer_code") ON UPDATE NO ACTION ON DELETE RESTRICT
) PARTITION BY LIST ("customer_code");
-- set comment to column: "status" on table: "transaction_deposit"
COMMENT ON COLUMN "public"."transaction_deposit"."status" IS 'WAITING, MATCHING, SUCCESS, DONE_BY_USER, FAILED,NO_MATCH';
-- create "transaction_withdraw" table
CREATE TABLE "public"."transaction_withdraw" (
  "id" bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  "created_at" timestamptz NOT NULL,
  "created_by" character varying(255) NOT NULL,
  "updated_at" timestamptz NOT NULL,
  "updated_by" character varying(255) NOT NULL,
  "customer_code" character varying(255) NOT NULL,
  "bank_code" character varying(255) NOT NULL,
  "bank_account_name" character varying(255) NOT NULL,
  "bank_account_number" character varying(255) NOT NULL,
  "bank_destination_account_name" character varying(255) NOT NULL,
  "bank_destination_account_number" character varying(255) NOT NULL,
  "transaction_type" character varying(255) NOT NULL,
  "amount" numeric(22,5) NOT NULL,
  "status" character varying(255) NOT NULL,
  "transferred_at" timestamptz NULL,
  "player_username" character varying(255) NULL,
  "withdraw_number" character varying(255) NULL,
  "remark" character varying(255) NULL,
  PRIMARY KEY ("id", "customer_code"),
  CONSTRAINT "transaction_withdraw_customer_code_fkey" FOREIGN KEY ("customer_code") REFERENCES "public"."customer" ("customer_code") ON UPDATE NO ACTION ON DELETE RESTRICT
) PARTITION BY LIST ("customer_code");
-- set comment to column: "status" on table: "transaction_withdraw"
COMMENT ON COLUMN "public"."transaction_withdraw"."status" IS 'WAITING, SUCCESS, DONE_BY_USER, FAILED';
COMMENT ON COLUMN "public"."transaction_withdraw"."transaction_type" IS 'WD, AUTO_TF';
-- create "user" table
CREATE TABLE "public"."user" (
  "created_at" timestamptz NOT NULL,
  "created_by" character varying(255) NOT NULL,
  "updated_at" timestamptz NOT NULL,
  "updated_by" character varying(255) NOT NULL,
  "customer_code" character varying(255) NOT NULL,
  "username" character varying(255) NOT NULL,
  "status" character varying(255) NOT NULL,
  "login_type" character varying(255) NOT NULL,
  "display_name" character varying(255) NULL,
  PRIMARY KEY ("customer_code", "username"),
  CONSTRAINT "user_customer_code_fkey" FOREIGN KEY ("customer_code") REFERENCES "public"."customer" ("customer_code") ON UPDATE NO ACTION ON DELETE RESTRICT
);
-- set comment to column: "status" on table: "user"
COMMENT ON COLUMN "public"."user"."status" IS 'ACTIVE, INACTIVE, LOCKED';
-- set comment to column: "login_type" on table: "user"
COMMENT ON COLUMN "public"."user"."login_type" IS 'WEB, DESKTOP';
-- create "trusted_device" table
CREATE TABLE "public"."trusted_device" (
  "created_at" timestamptz NOT NULL,
  "created_by" character varying(255) NOT NULL,
  "updated_at" timestamptz NOT NULL,
  "updated_by" character varying(255) NOT NULL,
  "customer_code" character varying(255) NOT NULL,
  "username" character varying(255) NOT NULL,
  "hwid" character varying(255) NOT NULL,
  "registered_at" timestamptz NOT NULL,
  PRIMARY KEY ("customer_code", "username"),
  CONSTRAINT "trusted_device_customer_code_username_fkey" FOREIGN KEY ("customer_code", "username") REFERENCES "public"."user" ("customer_code", "username") ON UPDATE NO ACTION ON DELETE RESTRICT
);
-- create "user_auth_history" table
CREATE TABLE "public"."user_auth_history" (
  "id" bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  "created_at" timestamptz NOT NULL DEFAULT now(),
  "created_by" character varying(255) NOT NULL,
  "updated_at" timestamptz NOT NULL DEFAULT now(),
  "updated_by" character varying(255) NOT NULL,
  "customer_code" character varying(255) NOT NULL,
  "username" character varying(255) NOT NULL,
  "ip_address" character varying(255) NOT NULL,
  "user_agent" character varying(255) NOT NULL,
  "last_location" character varying(255) NOT NULL,
  "last_source" character varying(255) NOT NULL,
  "history_type" character varying(255) NOT NULL,
  "fail_reason" text NOT NULL,
  "fail_attempts" integer NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "user_auth_history_customer_code_username_fkey" FOREIGN KEY ("customer_code", "username") REFERENCES "public"."user" ("customer_code", "username") ON UPDATE NO ACTION ON DELETE RESTRICT
);
-- set comment to column: "last_source" on table: "user_auth_history"
COMMENT ON COLUMN "public"."user_auth_history"."last_source" IS 'WEB, DEKSTOP, etc..';
-- set comment to column: "history_type" on table: "user_auth_history"
COMMENT ON COLUMN "public"."user_auth_history"."history_type" IS 'LOGIN, LOGOUT, INVALID_PASSWORD, etc..';
-- create "user_credential" table
CREATE TABLE "public"."user_credential" (
  "created_at" timestamptz NOT NULL,
  "created_by" character varying(255) NOT NULL,
  "updated_at" timestamptz NOT NULL,
  "updated_by" character varying(255) NOT NULL,
  "customer_code" character varying(255) NOT NULL,
  "username" character varying(255) NOT NULL,
  "password_hash" text NOT NULL,
  PRIMARY KEY ("customer_code", "username"),
  CONSTRAINT "user_credential_customer_code_username_fkey" FOREIGN KEY ("customer_code", "username") REFERENCES "public"."user" ("customer_code", "username") ON UPDATE NO ACTION ON DELETE RESTRICT
);
-- create "user_role" table
CREATE TABLE "public"."user_role" (
  "customer_code" character varying(255) NOT NULL,
  "username" character varying(255) NOT NULL,
  "role_id" bigint NULL,
  PRIMARY KEY ("customer_code", "username"),
  CONSTRAINT "user_role_customer_code_username_fkey" FOREIGN KEY ("customer_code", "username") REFERENCES "public"."user" ("customer_code", "username") ON UPDATE NO ACTION ON DELETE RESTRICT,
  CONSTRAINT "user_role_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "public"."role" ("id") ON UPDATE NO ACTION ON DELETE RESTRICT
);
