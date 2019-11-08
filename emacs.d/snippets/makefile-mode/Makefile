# -*- mode: snippet -*-
# name: Makefile
# key: Makefile
# expand-env: ((yas-indent-line 'fixed))
# --
.DEFAULT_GOAL := help
.PHONY: help

COMMAND_LIST := $\{MAKEFILE_LIST\}

# if .env file exists, including secret infomations
ifneq ("$(wildcard .env)","")
include .env
endif

help:
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $\{COMMAND_LIST\} | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $\$1, $\$2}'

get_git_tag:
	$(eval git_ver = $(shell git describe --tags --dirty --abbrev=0))
	$(eval git_ver_verbose = $(shell git describe --tags --dirty))

$1: ## comment
	@false
