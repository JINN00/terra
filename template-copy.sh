qm create 1000 --memory 4096 --core 2 --name centos7-template --net0 virtio,bridge=vmbr0 --ide0 local:cloudinit --agent enabled=1 --onboot 1 
qm disk import 1000 centos7-template.qcow2 local
qm set 1000 --scsi0 local:1000/vm-1000-disk-0.raw

