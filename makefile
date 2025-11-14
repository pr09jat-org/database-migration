# ============================
# 🔧 Configuration Variables
# ============================

# Atlas environment & migration settings
ATLAS_ENV       ?= local
ATLAS_CONFIG    ?= file://./database/vast/migrations/atlas.hcl
MIGRATION_DIR   ?= file://database/vast/migrations/revisions

# Database connections
DATABASE_URL    ?= postgres://postgres:postgres@localhost:5434/vast-db?sslmode=disable
DEV_DB          ?= postgres://postgres:Postgr3SQL-d3v@10.10.9.11:5432/vast-db?sslmode=disable

# Required migration ticket ID (e.g. V88-1234)
TICKET          ?=


.PHONY: help bob-models schema migrate-diff migrate-up mockery create-migration

help:
	@echo "📘 Available Makefile Commands:"
	@echo ""
	@echo "  make bob-models                            Generate Bob database models"
	@echo "  make schema                                Export schema.hcl from DEV_DB"
	@echo "  make migrate-diff TICKET=V88-1234          Generate migration with ticket name"
	@echo "  make migrate-up env=<dev,local>            Apply migrations using golang-migrate"
	@echo "  make mockery                               Create or Update mockery based on mockery.yml"
	@echo "  make create-migration TICKET=V88-1234      Create empty migration sql file with ticket number"
	@echo ""

bob-models:
	go run github.com/stephenafamo/bob/gen/bobgen-psql@v0.39.0 -c ./database/vast/bobgen.yaml

schema:
	atlas schema inspect -u "$(DEV_DB)" \
		--exclude "public.schema_migrations" > database/vast/migrations/schema.hcl

migrate-diff:
ifndef TICKET
	$(error TICKET is required. Usage: make migrate-diff TICKET=V88-1234)
endif
	atlas migrate diff $(TICKET) \
		--env $(ATLAS_ENV) \
		--config $(ATLAS_CONFIG)
	atlas migrate hash --dir $(MIGRATION_DIR)

migrate-up:
ifndef env
	$(error env is required. Usage: make migrate-up env=<dev,local>)
endif

ifeq ($(env),dev)
	migrate -source $(MIGRATION_DIR) -database $(DEV_DB) up
else ifeq ($(env),local)
	migrate -source $(MIGRATION_DIR) -database $(DATABASE_URL) up
else
	$(error unknown env '$(env)'; use dev or local)
endif

mockery:
	go run -mod=mod github.com/vektra/mockery/v2 --config mockery.yml

create-migration:
ifndef TICKET
	$(error TICKET is required. Usage: make create-migration TICKET=V88-1234)
endif
	migrate create -ext sql --dir database/vast/migrations/revisions $(TICKET)