# Terraform Commands

## Show Your Terraform Version

**terraform version** — Show the current version of your Terraform and notifies you if there is a newer version available for download.

## Format Your Terraform Code

**terraform fmt** — Format your Terraform configuration files using the HCL language standard.

**terraform fmt --recursive** — Also format files in subdirectories

**terraform fmt --diff** — Display differences between original configuration files and formatting changes.

**terraform fmt --check** — Useful in automation CI/CD pipelines, the check flag can be used to ensure the configuration files are formatted correctly, if not the exit status will be non-zero. If files are formatted correctly, the exit status will be zero
