.DEFAULT_GOAL := help

init-local:
	bash bin/init-local.sh

test:
	docker-compose exec web python manage.py test

help:
	@echo "init-local			- Initializes local env, builds containers, Refreshes data"
	@echo "test					- Run tests"

.PHONY:
	init-local