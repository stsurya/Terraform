# Terraform Commands

## Show Your Terraform Version

**terraform version** — Show the current version of your Terraform and notifies you if there is a newer version available for download.

## Format Your Terraform Code

**terraform fmt** — Format your Terraform configuration files using the HCL language standard.

**terraform fmt --recursive** — Also format files in subdirectories

**terraform fmt --diff** — Display differences between original configuration files and formatting changes.

**terraform fmt --check** — Useful in automation CI/CD pipelines, the check flag can be used to ensure the configuration files are formatted correctly, if not the exit status will be non-zero. If files are formatted correctly, the exit status will be zero

## Initialize Your Directory

**terraform init** — In order to prepare the working directory for use with Terraform, the terraform init command performs Backend Initialization, Child Module Installation, and Plugin Installation.

**terraform init -get-plugins=false** — Initialize the working directory, do not download plugins.

**terraform init -lock=false** — Initialize the working directory, don’t hold a state lock during backend migration.

**terraform init -input=false** — Initialize the working directory, and disable interactive prompts.

**terraform init -migrate-state** — Reconfigure a backend, and attempt to migrate any existing state.

**terraform init -verify-plugins=false** — Initialize the working directory, do not verify plugins for Hashicorp signature
