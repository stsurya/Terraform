terraform-infra/
│── modules/                          # Reusable modules
│   ├── function_app/                  # Module for Function Apps
│   ├── vm_windows/                    # Module for Windows VMs
│   ├── vm_linux/                      # Module for Linux VMs
│   ├── eventgrid/                     # Module for Event Grids
│   ├── eventhub_namespace/            # Module for Event Hub Namespaces
│   ├── storage_account/               # Module for Storage Accounts
│   └── virtual_network/               # Module for VNets
│
│── envs/                              # Environment-specific configs
│   ├── dev/
│   │   ├── main.tf                    # Calls modules for dev
│   │   ├── variables.tf               # Input variables
│   │   ├── terraform.tfvars           # Dev-specific values
│   │   └── outputs.tf
│   │
│   ├── qa/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── terraform.tfvars           # QA-specific values
│   │   └── outputs.tf
│   │
│   ├── stage/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── terraform.tfvars           # Stage-specific values
│   │   └── outputs.tf
│   │
│   └── prod/
│       ├── main.tf
│       ├── variables.tf
│       ├── terraform.tfvars           # Prod-specific values
│       └── outputs.tf
│
│── global/                            # Global/shared config
│   ├── provider.tf                    # Azure provider setup
│   ├── backend.tf                     # Remote state (e.g., Azure Storage)
│   └── variables.tf                   # Global variables
│
└── README.md
