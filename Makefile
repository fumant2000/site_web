.DEFAULT_GOAL := help

.PHONY: start start.daemon stop restart update check csfix help upgrade entity migration migrate db.restart db.drop db.create
# --------------------------------#
# Makefile for the "make" command
# --------------------------------#


# ----- Colors -----
GREEN = $(echo -e "\033[0;32m")
RED = $(echo -e "\033[0;31m")

# ----- Programs -----
COMPOSER = composer
PHP = php
SYMFONY = symfony
SYMFONY_CONSOLE = $(PHP) bin/console
PHP_UNIT = $(PHP) bin/phpunit
NPM = npm

## ----- Project -----
init: ## Initialize the project
	$(MAKE) composer-install
	$(MAKE) npm-install
	$(MAKE) database-init
	@$(call GREEN, "Project initialized!")
	$(MAKE) start

## ----- Composer -----
composer-install: ## Install the dependencies
	@$(call GREEN, "Installing dependencies...")
	$(COMPOSER) install

composer-update: ## Update the dependencies
	@$(call GREEN, "Updating dependencies...")
	$(COMPOSER) update

## ----- NPM -----
npm-install: ## Install the dependencies
	@$(call GREEN, "Installing dependencies...")
	$(NPM) install
	$(MAKE) npm-build

npm-build: ## Build the assets
	@$(call GREEN, "Building assets...")
	$(NPM) run build

npm-watch: ## Exécute la commande npm run watch
	$(NPM) run watch

## ----- Symfony -----
start: ## Start the project
	@$(call GREEN, "Starting the project...")
	$(SYMFONY) server:start -d
	@$(call GREEN, "Project started! You can now access it at http://127.0.0.1:8000")

stop: ## Stop the project
	@$(call GREEN, "Stopping the project...")
	$(SYMFONY_CONSOLE) server:stop
	@$(call GREEN, "Project stopped!")

database-create: ## Create the database
	@$(call GREEN, "Creating database...")
	$(SYMFONY_CONSOLE) doctrine:database:create --if-not-exists

entity: ## Crée ou modifie une entité
	$(SYMFONY_CONSOLE) make:entity

migration: ## Génère une migration avec les changements des entités
	$(SYMFONY_CONSOLE) make:migration

migrate: ## Exécute les migrations
	$(SYMFONY_CONSOLE) doctrine:migrations:migrate -n


database-drop: ## Drop the database
	@$(call GREEN, "Dropping database...")
	$(SYMFONY_CONSOLE) doctrine:database:drop --force --if-exists

database-migrate: ## Migrate the database
	@$(call GREEN, "Migrating database...")
	$(SYMFONY_CONSOLE) doctrine:migrations:migrate --no-interaction

database-rollback: ## Rollback the database
	@$(call GREEN, "Rolling back database...")
	$(SYMFONY_CONSOLE) doctrine:migrations:migrate prev --no-interaction

database-fixtures: ## Load the fixtures
	@$(call GREEN, "Loading fixtures...")
	$(SYMFONY_CONSOLE) doctrine:fixtures:load -n

database-init: ## Initialize the database
	@$(call GREEN, "Initializing database...")
	$(MAKE) database-drop
	$(MAKE) database-create
	$(MAKE) database-migrate
	$(MAKE) database-fixtures

cache-clear: # Clear the cache
	@$(call GREEN, "Clearing cache...")
	$(SYMFONY_CONSOLE) cache:clear
## ----- Tests -----
tests: ## Run the tests
	@$(call GREEN, "Running tests...")
	$(MAKE) database-init-test
	$(PHP_UNIT) --testdox tests/Unit/
	$(PHP_UNIT) --testdox tests/Functional/

database-init-test: ## Init database for tests
	@$(call GREEN, "Creating the database for tests...")
	$(SYMFONY_CONSOLE) d:d:d --force --if-exists --env=test
	$(SYMFONY_CONSOLE) d:d:c --env=test --if-not-exists
	$(SYMFONY_CONSOLE) d:m:m --no-interaction --env=test
	$(SYMFONY_CONSOLE) d:f:l --no-interaction --env=test

## ----- Help ----- 
help: ## Display this help
	@$(call GREEN, "Available commands:")
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-9s\033[0m %s\n", $$1, $$2}'