## Terraform Variables

- Terraform variables provides a way to store the values and can be used throughout your terraform configuration.

Variables are defined in the variables block in your Terraform configuration file, where you can give a name and a default value. Please refer to the following snippet exaplaining how variables are defined inside terraform-

```
variable "<variable_name>" {
    type = string
    description = "some desc"
    default = "<default value>"
}
```

- Terraform variables can have various type such as string, number, boolean, list, map etc.
- Variables can be set in the command line when running Terraform commands using the `-var flag`.
- Variables can also be set using a separate file, called a variable file, using the `-var-file flag`.
- Variables can be accessed in Terraform configuration files using the var function, for example ` var.example_variable`.
- Variables are useful for storing values that may change between environments, for example, different values for test and production environments.

### Defining a list variable

```
variable "storage_account_name" {
  type    = list(string)
  default = ["sauk02", "sauk03", "sauk04"]
}

resource "azurerm_storage_account" "example" {
  name                     = var.storage_account_name[count.index]
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  count                    = length(var.storage_account_name)
}
```

### Output variables

Output variables allow you to easily extract information about the resources that were created by Terraform. They allow you to easily reference the values of resources after Terraform has finished running.

Output variables are defined in the outputs block in the Terraform configuration file. Here's an example

```
output "example" {
  value = azurerm_storage_account.example[2].id
}
```

you use `terraform output`command to see Id for the above example.

## What is a Map in terraform ?

Map is a data structure used to represent a collection of key-value pairs. It's is similar to objects in other programming languages. you can define map as below

```
variable "<variable_name>" {
  type = map(string)
  default = {
    luke  = "jedi"
    yoda  = "jedi"
    darth = "sith"
  }
}
```

The following types can be used to define your map:

- map(string): The values in the map are of type “string.”
- map(number): The values in the map are of type “number” (integer or floating-point).
- map(bool): The values in the map are of type “bool” (true or false).
- map(list): The values in the map are lists (arrays) containing elements of the same type.
- map(set): The values in the map are sets containing unique elements of the same type.
- map(object({ ... })): The values in the map are objects (complex data structures) that must conform to a specific structure defined by the object’s attributes.

## What is a Object in terraform ?

An object is complex data structure that contains multiple attributes with specific types defined for each attribute. example is below:

```
variable "example_object" {
  type = object({
    attribute1 = string
    attribute2 = number
    attribute3 = bool
  })
  default = {
    attribute1 = "value1"
    attribute2 = 2
    attribute3 = true
  }
}
```

## What is the difference between Map and Object in terraform ?

- An object is a map without a defined type.
- For example you can have a map(string) that only accepts string values and an object that is the same but can contain different types in addition to strings.

## Terraform variable loading preference - How do terraform loads variables?

Terraform loads variables in the following order:

- Environment variables (TF*VAR* prefix).
- Command-line flags (-var and -var-file).
- terraform.tfvars and terraform.tfvars.json.
- Any .auto.tfvars or .auto.tfvars.json files.
- Variable definitions in the configuration.
- Prompting the user for input if the variable is not set.
