help: ## List all Makefile targets
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

.PHONY: help php build

php: ## Run php
	docker-compose run --rm php bash

vendor: composer.json composer.lock ## Install vendor
	docker run -ti --rm --volume ${COMPOSER_HOME:-$HOME/.composer}:/tmp/composer --volume ${PWD}:/app --workdir /app --env COMPOSER_HOME=/tmp/composer -u $(shell id -u):$(shell id -g) composer sh -c "composer install"

build: ## Build docker image
	docker-compose build

phpunit: vendor ## Run PHPUnit
	docker-compose run --rm php vendor/bin/phpunit tests
