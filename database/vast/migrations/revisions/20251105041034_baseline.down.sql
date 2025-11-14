-- reverse: create "user_role" table
DROP TABLE "public"."user_role";
-- reverse: create "user_credential" table
DROP TABLE "public"."user_credential";
-- reverse: set comment to column: "history_type" on table: "user_auth_history"
COMMENT ON COLUMN "public"."user_auth_history"."history_type" IS NULL;
-- reverse: set comment to column: "last_source" on table: "user_auth_history"
COMMENT ON COLUMN "public"."user_auth_history"."last_source" IS NULL;
-- reverse: create "user_auth_history" table
DROP TABLE "public"."user_auth_history";
-- reverse: create "trusted_device" table
DROP TABLE "public"."trusted_device";
-- reverse: set comment to column: "login_type" on table: "user"
COMMENT ON COLUMN "public"."user"."login_type" IS NULL;
-- reverse: set comment to column: "status" on table: "user"
COMMENT ON COLUMN "public"."user"."status" IS NULL;
-- reverse: create index "ux_user_customer_desktop" to table: "user"
DROP INDEX "public"."ux_user_customer_desktop";
-- reverse: create "user" table
DROP TABLE "public"."user";
-- reverse: set comment to column: "status" on table: "transaction_withdraw"
COMMENT ON COLUMN "public"."transaction_withdraw"."status" IS NULL;
-- reverse: set comment to column: "transaction_type" on table: "transaction_withdraw"
COMMENT ON COLUMN "public"."transaction_withdraw"."transaction_type" IS NULL;
-- reverse: create "transaction_withdraw" table
DROP TABLE "public"."transaction_withdraw";
-- reverse: set comment to column: "status" on table: "transaction_deposit"
COMMENT ON COLUMN "public"."transaction_deposit"."status" IS NULL;
-- reverse: create "transaction_deposit" table
DROP TABLE "public"."transaction_deposit";
-- reverse: set comment to column: "status" on table: "subscription"
COMMENT ON COLUMN "public"."subscription"."status" IS NULL;
-- reverse: create "subscription" table
DROP TABLE "public"."subscription";
-- reverse: create "role_permission" table
DROP TABLE "public"."role_permission";
-- reverse: create "permission" table
DROP TABLE "public"."permission";
-- reverse: create index "role_customer_code_role_name_idx" to table: "role"
DROP INDEX "public"."role_customer_code_role_name_idx";
-- reverse: create "role" table
DROP TABLE "public"."role";
-- reverse: create "brand_account" table
DROP TABLE "public"."brand_account";
-- reverse: create "brand_config" table
DROP TABLE "public"."brand_config";
-- reverse: create "bank_account_withdraw_setting" table
DROP TABLE "public"."bank_account_withdraw_setting";
-- reverse: create "bank_account_auto_transfer_setting" table
DROP TABLE "public"."bank_account_auto_transfer_setting";
-- reverse: create "bank_account" table
DROP TABLE "public"."bank_account";
-- reverse: create "customer" table
DROP TABLE "public"."customer";
-- reverse: create "bank_app" table
DROP TABLE "public"."bank_app";
-- reverse: create "app_version" table
DROP TABLE "public"."app_version";
-- reverse: create "bank_account_archive" table
DROP TABLE "public"."bank_account_archive";
-- reverse: create "bank" table
DROP TABLE "public"."bank";
