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
