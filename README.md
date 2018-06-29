# Terraform Debian Nomad

This module provision a nomad cluster on any debian stretch intallation.

Includes:

- docker
- weave
- consul
- nomad

To do:

- Vault

This module is just a provisioner.

## Dependencies

Minimal versions:

- Terraform 0.11.7

## Usage

Example usage of the module.

```
module "provision-nomad" {
  source="github.com/diogok/terraform-debian-nomad" 

  managers=[]
  workers=[]

  manager_count="3"
  worker_count="5"

  network_interface="enp0s2"
  #network_interface="eth0"

  datacenter="us-1"
  weave=true
}
```

## License

MIT

