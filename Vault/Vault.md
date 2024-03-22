## What is Hashicorp Vault ?

HashiCorp Vault is an identity-based secrets and encryption management system. A secret is anything that you want to tightly control access to, such as API encryption keys, passwords, and certificates. Vault provides encryption services that are gated by authentication and authorization methods. Using Vault’s UI, CLI, or HTTP API, access to secrets and other sensitive data can be securely stored and managed, tightly controlled (restricted), and auditable.

## What is a secrets engine?

Secrets engines are Vault components which store, generate or encrypt secrets.Some secrets engines like the key/value secrets engine simply store and read data. Other secrets engines connect to other services and generate dynamic credentials on demand.

![alt text](https://developer.hashicorp.com/_next/image?url=https%3A%2F%2Fcontent.hashicorp.com%2Fapi%2Fassets%3Fproduct%3Dtutorials%26version%3Dmain%26asset%3Dpublic%252Fimg%252Fvault%252Fvault-triangle.png%26width%3D1641%26height%3D973&w=3840&q=75)

### Creating a secret engine:

`vault secrets enable -path=first-ssh ssh`

## Authentication

To enable the AppRole authentication method in Vault, you need to use the Vault CLI or the Vault HTTP API.

Run the following command to enable the AppRole authentication method:
`vault auth enable approle`

## Policies

Policies in Vault control what a user can access

<code> vault policy write terraform - <<EOF
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

qd
