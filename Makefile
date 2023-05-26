.PHONY: help
help: ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Testing:

.PHONY: test
test: ## Run unit tests
	go test ./...

.PHONY: acc-test
acc-test: ## Run acceptance tests
	TF_ACC=1 go test ./...

##@ Install:

GOBIN := $(shell go env GOBIN)
ifeq ($(strip $(GOBIN)),)
    # If GOBIN is empty, set the variable VAR_NAME to a value
    GOBIN := $(shell go env GOPATH)/bin
endif

.PHONY: install
install: ## Install the provider to $GOENV/bin
	@echo Installing provider to $(GOBIN)…
	@go install .
