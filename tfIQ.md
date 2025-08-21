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