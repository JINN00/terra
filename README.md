Proxmox VE Terraform

This is Terraform example that create multiple vm for Proxmox VE<br>
It needs template for the copy

<pre>
terraform plan --var-file=vm.tfvars
terraform apply --var-file=vm.tfvars
terraform destroy --var-file=vm.tfvars
</pre>
