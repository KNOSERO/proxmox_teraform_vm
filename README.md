# Proxmox Terraform VM
Reusable Terraform configuration for creating VMs in Proxmox

## Env
You create a file named `env.tfvars`

```dotenv
pm_password        = "<<PROXMOX PASSWORD>>"
ci_password        = "<<PASSWORD VM>>"
ci_password_hashed = "<<PASSWORD VM HASHED>>"
```

## Config
You create a file named `variables.tfvars`

```hcl
containers = [
  {
    name         = "<<NAME CONTAINER>>"
    target_node  = "<<NAME NODE>>"
    vmid         = 201
    cores        = 2
    memory       = 4096
    balloon      = 2048
    ip_address   = "192.168.0.3/24"
    mac          = "<<ADRES MAC>>"
  },
  {
    name         = "<<NAME CONTAINER>>"
    target_node  = "<<NAME NODE>>"
    vmid         = 202
    cores        = 2
    memory       = 4096
    balloon      = 2048
    ip_address   = "192.168.0.4/24"
    mac          = "<<ADRES MAC>>"
  }
]
```

-----

You should also override the root user with reduced privileges in the target application