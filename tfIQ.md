## 1. What is the use of .terraform.lock.hcl ??

The `.terraform.lock.hcl` file is used to record the exact versions of the provider plugins that Terraform uses for a project. Its main purpose is to ensure consistent and reproducible runs of Terraform across different machines and team members.

## 2. What would you do if a Terraform state file becomes corrupted or accidentally deleted?

Thanks for the clarification! Here's a solid **interview answer** to:

---

### ❓ **What would you do if a Terraform state file becomes corrupted or accidentally deleted?**

---

### ✅ **Answer:**

If the Terraform state file gets corrupted or accidentally deleted, my response depends on whether we’re using a **local backend** or a **remote backend** like Azure Storage.

---

### 🔹 **For Remote Backend (like Azure Storage – which I mostly use):**

1. **Check for backups**:

   - Azure Storage keeps **versioning** or **soft delete** enabled for blobs.
   - I’d go to the storage account and **recover the previous state file version** using the Azure Portal, CLI, or PowerShell.

2. **Restore the blob**:

   - Using the portal or `az storage blob restore` command, I can restore the last known good version of `terraform.tfstate`.

3. **Validate**:

   - Once restored, I’d run `terraform plan` to ensure the current infrastructure matches the restored state and no drift has occurred.

---

### 🔹 **If no backup is available or recovery is not possible:**

1. I would try to **recreate the state using `terraform import`**.

   - For each resource, I’d run:

     ```
     terraform import <resource_type.name> <resource_id>
     ```

   - This recreates the state from the actual infrastructure without changing it.

2. After importing, I’d run `terraform plan` to verify all resources are tracked properly again.

---

### 🔐 **Preventive Measures I Follow**:

- Always enable **blob versioning** or **state locking with remote backends**.
- Ensure **state file encryption** and **access controls** are applied.
- Take **manual state snapshots before critical deployments**.

---

## Explain Terraform’s declarative model.

Terraform uses a declarative model where I just define the desired end state of infrastructure in .tf files, like ‘I need an Azure App Service with autoscaling enabled and a SQL Database.’ Terraform then compares that with the current state, creates an execution plan, and makes only the necessary changes. This ensures idempotency, drift detection, and consistent provisioning without me writing step-by-step instructions.

## What do we mean by immutability in Terraform? Why is it preferred over mutability in infrastructure changes?

In Terraform, immutability means that when infrastructure changes are required, Terraform often replaces the resource instead of modifying it in-place. This is preferred because it ensures consistency, eliminates configuration drift, and makes deployments more predictable. Immutable changes are safer, easier to roll back, and align well with modern DevOps practices like blue-green deployments. In contrast, mutable infrastructure can lead to hidden issues and harder-to-trace drift

## How does Terraform handle dependency management between resources? Can you override the implicit dependency graph?

Terraform builds an implicit dependency graph by analyzing references between resources. For example, if an EC2 instance uses a subnet’s ID, Terraform automatically ensures the subnet is created first. Independent resources are created in parallel. If I need to enforce ordering where no direct reference exists, I can override this using the depends_on argument. However, I use it sparingly to avoid unnecessary complexity and reduced parallelism.

## What are providers and provisioners? Why is relying heavily on provisioners generally discouraged?

Providers in Terraform are plugins that allow it to interact with different platforms like AWS, Azure, or Kubernetes. Provisioners, on the other hand, are used to run scripts or commands on a resource after it’s created or destroyed. While provisioners can be useful for small bootstrapping tasks, relying heavily on them is discouraged because they break Terraform’s declarative model, introduce non-idempotent behavior, and make infrastructure harder to maintain. The best practice is to use provisioners sparingly and rely on tools like Ansible or cloud-init for configuration management.

## What is the Terraform state file used for, and why is it critical?

The Terraform state file is a critical component because it maps the resources defined in code to the actual resources in the cloud. It allows Terraform to know what it manages, detect drift, and plan changes accurately. Without state, Terraform would have to recreate or reimport resources every time. That’s why teams typically store it in a secure remote backend with state locking and encryption, making it both collaborative and safe.

## How do you handle a corrupted or accidentally deleted state file?

If a state file is corrupted or accidentally deleted, my first step is to check if we’re using a remote backend like S3 or Azure Blob with versioning enabled and restore a previous version. If no backup exists, I would manually rebuild the state using terraform import to map each real resource back into Terraform’s management. Running terraform apply without a valid state is dangerous because Terraform might attempt to recreate everything, so restoring or reconstructing state is critical.

## Suppose your team uses remote backend with state locking enabled, but a colleague force-terminates a terraform apply. What issues can arise and how do you fix them?

When using a remote backend with state locking, if a colleague force-terminates an apply, Terraform may leave the state locked. This blocks further operations and could leave resources half-created. The fix is to use terraform force-unlock <LOCK_ID> to release the stale lock, then run terraform plan to check for drift. If resources were created but not recorded in state, I’d use terraform import to reconcile them. This ensures state and infrastructure are back in sync.

## What risks are there in using force-unlock, and how do you mitigate them?

The main risk of using terraform force-unlock is that it can lead to state corruption if another apply is still running, or it may leave Terraform unaware of resources that were created before the interrupted apply. To mitigate this, I first confirm no one else is running Terraform, then force-unlock, and immediately run a terraform plan to check for inconsistencies. If drift exists, I use terraform import or refresh to reconcile state. Storing state in a versioned backend also gives a safety net in case the state becomes corrupted.

## How do you perform a state migration from local to remote backend ?
To migrate state from local to Azure, I first create an Azure storage account and container. Then, I update the backend block in Terraform to point to Azure Blob Storage. Finally, I run `terraform init -migrate-state`, which uploads the existing local state to the remote backend. From then on, the state is stored in Azure for collaboration and locking. I also recommend enabling blob versioning for recovery.

## What will happen If I don't use -migrate-state flag while migrating state file ?

If I don’t use -migrate-state when switching to a remote backend, Terraform won’t copy the existing local state to Azure. The remote backend will start with an empty state, which makes Terraform think no resources exist. This can lead to resource duplication, drift, or require a full manual import of every resource. That’s why using -migrate-state is the safe and recommended way.

## Explain how to recover if someone already forgot -migrate-state and accidentally initialized remote state as empty?

If I accidentally initialized a remote backend without -migrate-state, Terraform would think the state is empty and try to recreate resources. To recover, I’d stop any apply, then upload my local terraform.tfstate file into the remote backend manually or restore from a backup if available. If both are lost, I’d use terraform import to rebuild state from existing infrastructure. This way, Terraform regains awareness of resources without re-creating them.”

## In what situations would you use terraform state rm or terraform import?

terraform state rm is used to remove a resource from Terraform’s state file without destroying it in real infrastructure — usually when you no longer want Terraform to manage it or when refactoring modules. terraform import is the opposite: it lets you bring existing infrastructure under Terraform management by mapping it into state. I use state rm to stop tracking a resource, and import to start tracking an existing one.

## How would you design a Terraform module for a reusable VPC that can be consumed across multiple projects?

I would design the VPC module to be fully reusable, environment-agnostic, and region-agnostic, so it can serve multiple projects consistently.

Structure: I keep the module self-contained with main.tf, variables.tf, outputs.tf, and a README. The module only defines how to build the VPC and subnets, but never hardcodes environment or region details.

Inputs: I expose variables like cidr_block, public_subnets, private_subnets, project, env, and tags. This lets each project pass in its own CIDRs, regions, and naming details.

Implementation: Inside the module, I use for_each to create subnets across AZs, and I apply a consistent naming convention like <project>-<env>-subnet-<az>.

Outputs: I output useful identifiers such as vpc_id, public_subnet_ids, and private_subnet_ids, so other modules like EKS, RDS, or application gateways can consume them without duplicating logic.

Reusability: Different projects or environments simply call the module with different tfvars (for example, dev, qa, prod) instead of duplicating code.

Best practices: I keep state isolated per environment and per project, add feature flags (like enable_nat or enable_flow_logs), and enforce common tagging for governance.

This way, I end up with one VPC module that multiple teams can use, while maintaining consistency, isolation, and scalability.

## What’s your approach for handling module versioning in a product-based company with many teams depending on shared modules?

In a product-based company where many teams consume shared Terraform modules, I treat modules like versioned software packages.

* **Versioning Strategy:** I follow **semantic versioning** (`MAJOR.MINOR.PATCH`).

  * **PATCH** → bug fixes, safe to upgrade.
  * **MINOR** → backward-compatible enhancements.
  * **MAJOR** → breaking changes.
* **Publishing:** Modules are stored in a central Git repo or a private Terraform registry. Each release is tagged so teams can pin exact versions instead of tracking `main`.
* **Consumption:** Teams always consume modules with an explicit version constraint, e.g.:

  ```
  source  = "git::ssh://git@company.com/terraform-modules/vpc.git?ref=v1.2.0"
  ```

  This ensures they only upgrade when they’re ready.
* **Change Management:** For breaking changes, I publish a migration guide or provide feature flags so adoption can be gradual.
* **Testing:** We maintain a CI pipeline that runs validation tests on every module change to prevent regressions before tagging a release.

This way, shared modules are reliable, upgrades are controlled, and multiple teams can move at their own pace without stepping on each other.

## How do you detect if someone made manual changes in the cloud console (infrastructure drift)?

I detect drift by running terraform plan — it compares the state file with actual cloud resources and highlights manual changes. In practice, I automate this with a CI/CD pipeline that runs plan in check-only mode on a schedule, and I also rely on cloud compliance tools like AWS Config or Azure Policy for real-time alerts. Finally, we restrict console access so Terraform is the single source of truth.