# -*- mode: snippet -*-
# name: Makefile
# key: Makefile
# expand-env: ((yas-indent-line 'fixed))
# --
.PHONY: help
.DEFAULT_GOAL := help

help:
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $\{MAKEFILE_LIST\} | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $\$1, $\$2}'

debug_git_tag:
	$(eval ver = $(shell git describe --dirty --all | cut -d / -f 2))

release_git_tag:
	$(eval ver = $(shell git describe --dirty --tags))

$1: ## comment
	@false