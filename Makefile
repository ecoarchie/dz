include .env
export $(shell sed 's/=.*//' .env)

setup: start-db install-goose migrate-up

start-db:
	docker-compose up -d postgres

stop-db:
	docker-compose stop postgres

compose-down:
	docker-compose down

install-goose:
	@if [ ! -f $(GOOSE_BINARY) ]; then \
		echo "Downloading goose binary..."; \
		curl -L -o goose https://github.com/pressly/goose/releases/download/$(GOOSE_VERSION)/goose_linux_x86_64; \
		chmod +x goose; \
		sudo mv goose $(GOOSE_BINARY); \
		echo "goose installed to $(GOOSE_BINARY)"; \
	else \
		echo "goose already installed."; \
	fi

migrate-up:
	$(GOOSE_BINARY) postgres postgresql://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@$(POSTGRES_HOST):$(POSTGRES_PORT)/$(POSTGRES_DB) up

migrate-down:
	$(GOOSE_BINARY) postgres postgresql://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@$(POSTGRES_HOST):$(POSTGRES_PORT)/$(POSTGRES_DB) down