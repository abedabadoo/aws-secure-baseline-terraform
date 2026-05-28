# AWS Secure Baseline - developer Makefile
# Terraform commands run against environments/dev.

ENV_DIR := environments/dev

.PHONY: init fmt validate plan apply destroy security help

help:
	@echo "Targets:"
	@echo "  init      - terraform init in $(ENV_DIR)"
	@echo "  fmt       - terraform fmt -recursive at repo root"
	@echo "  validate  - terraform validate in $(ENV_DIR)"
	@echo "  plan      - terraform plan in $(ENV_DIR)"
	@echo "  apply     - terraform apply in $(ENV_DIR)"
	@echo "  destroy   - terraform destroy in $(ENV_DIR)"
	@echo "  security  - run local IaC scanners (tfsec)"

init:
	cd $(ENV_DIR) && terraform init

fmt:
	terraform fmt -recursive

validate:
	cd $(ENV_DIR) && terraform validate

plan:
	cd $(ENV_DIR) && terraform plan

apply:
	cd $(ENV_DIR) && terraform apply

destroy:
	cd $(ENV_DIR) && terraform destroy

security:
	@if command -v tfsec >/dev/null 2>&1; then \
		echo "Running tfsec..."; \
		tfsec . ; \
	else \
		echo "tfsec not installed. Install with: brew install tfsec"; \
	fi
