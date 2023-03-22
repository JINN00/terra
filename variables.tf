variable "vm-settings" {
	description = "Please Specify VM information to .tfvars"
	nullable = false
}

variable "dns-server" {
        type = string
	default = "168.126.63.1 8.8.8.8"
        description = "Please Input DNS Server IP for VM eg. 168.126.63.1"
}

variable "gateway0" {
        type = string
        description = "Please Input gateway IP for VM eg. 223.130.101.1"
}

variable "gateway1" {
        type = string
	default = null
        description = "Please Input gateway IP for VM eg. 10.0.0.1"
}

variable "storage" {
	type = string
	description = "Please Specify target storage name for Proxmox VE"
	nullable = false
}

variable "target-node" {
	type = string
	description = "Please Specify target node for Proxmox Cluster"
	nullable = false
}
