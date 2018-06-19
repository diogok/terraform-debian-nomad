
variable "managers" {
  description="List of managers/master/server IPs"
  default=[]
}

variable "workers" {
  description="List of workers/clients/agents IPs"
  default=[]
}

variable "connection" {
  description="Connection hashmap to merge when provisioning"
  default={}
}

variable "enc_key" {
  description="Encryption key for network overlay, consul and nomad comms"
  default="MApUWiQ6dyPTtLoDSDQffA=="
}

variable "manager_count" {
  description="Number of managers"
  default=0
}

variable "worker_count" {
  description="Number of workers"
  default=0
}

variable "network_interface" {
  description="Network interface to bind consul to"
  default="enp0s2"
}

variable "changeme" {
  description="Change this var to force re-provisioning of resources"
  default=""
}
