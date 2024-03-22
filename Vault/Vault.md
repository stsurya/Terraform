## What is Hashicorp Vault ?

HashiCorp Vault is an identity-based secrets and encryption management system. A secret is anything that you want to tightly control access to, such as API encryption keys, passwords, and certificates. Vault provides encryption services that are gated by authentication and authorization methods. Using Vault’s UI, CLI, or HTTP API, access to secrets and other sensitive data can be securely stored and managed, tightly controlled (restricted), and auditable.

## What is a secrets engine?

Secrets engines are Vault components which store, generate or encrypt secrets.Some secrets engines like the key/value secrets engine simply store and read data. Other secrets engines connect to other services and generate dynamic credentials on demand.

![alt text](https://developer.hashicorp.com/_next/image?url=https%3A%2F%2Fcontent.hashicorp.com%2Fapi%2Fassets%3Fproduct%3Dtutorials%26version%3Dmain%26asset%3Dpublic%252Fimg%252Fvault%252Fvault-triangle.png%26width%3D1641%26height%3D973&w=3840&q=75)

### Creating a secret engine:

```
vault secrets enable -path=first-ssh ssh

```

## Authentication

To enable the AppRole authentication method in Vault, you need to use the Vault CLI or the Vault HTTP API.

Run the following command to enable the AppRole authentication method:

```
vault auth enable approle

```

## Policies

Policies in Vault control what a user can access

```
vault policy write terraform - <<EOF
path "\*" {
capabilities = ["list", "read"]
}
path "secrets/data/\*" {
capabilities = ["create", "read", "update", "delete", "list"]
}
path "kv/data/\*" {
capabilities = ["create", "read", "update", "delete", "list"]
}
path "secret/data/\*" {
capabilities = ["create", "read", "update", "delete", "list"]
}
path "auth/token/create" {
capabilities = ["create", "read", "update", "list"]
}
EOF
```

Now you'll need to create an AppRole with appropriate policies and configure its authentication settings. Here are the steps to create an AppRole:

### a. Create the AppRole:

```
vault write auth/approle/role/terraform \
    secret_id_ttl=10m \
    token_num_uses=10 \
    token_ttl=20m \
    token_max_ttl=30m \
    secret_id_num_uses=40 \
    token_policies=terraform
```

### Generate Role ID and Secret ID:

After creating the AppRole, you need to generate a Role ID and Secret ID pair. The Role ID is a static identifier, while the Secret ID is a dynamic credential.

### a. Generate Role ID:

You can retrieve the Role ID using the Vault CLI:

```
vault read auth/approle/role/my-approle/role-id
```

Save the Role ID for use in your Terraform configuration.

### b. Generate Secret ID:

To generate a Secret ID, you can use the following command:

```
vault write -f auth/approle/role/my-approle/secret-id
```

This command generates a Secret ID and provides it in the response. Save the Secret ID securely, as it will be used for Terraform authentication.
