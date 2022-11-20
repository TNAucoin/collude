.DEFAULT_GOAL := help

init-local:
	bash bin/init-local.sh

help:
	@echo "init-local			- Initializes local env, builds containers, Refreshes data"

.PHONY:
	init-local