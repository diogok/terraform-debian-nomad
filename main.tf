
locals {
  all = "${concat(var.managers,var.workers)}"
  total = "${var.manager_count + var.worker_count}"
}

resource "null_resource" "provision" {
  count = "${local.total}"

  triggers = {
    servers  = "${join(",",local.all)}"
    changeme = "${var.changeme}"
  }

  connection = { # passthru connection variables
    host = "${local.all[count.index]}"

    type = "${lookup(var.connection,"type","ssh")}"
    #agent = "${lookup(var.connection,"agent","false")}"

    port = "${lookup(var.connection,"port","22")}"
    user = "${lookup(var.connection,"user","root")}"
    password = "${lookup(var.connection,"password","")}"
    private_key = "${lookup(var.connection,"private_key","")}"

    bastion_port = "${lookup(var.connection,"bastion_port","22")}"
    bastion_user = "${lookup(var.connection,"bastion_user","")}"
    bastion_password = "${lookup(var.connection,"bastion_password","")}"
    bastion_private_key = "${lookup(var.connection,"bastion_private_key","")}"
  }

/*
  provisioner "remote-exec" {
    inline =[
        "sleep 10" # sometimes ready is not realy ready
       ,"mkdir -p /etc/ops" # store all config at /etc/ops
       ,"echo INDEX=${count.index} > /etc/ops/env"
       ,"echo SEED=${local.all[0]} >> /etc/ops/env"
       ,"echo ENCKEY=${var.enc_key} >> /etc/ops/env"
       ,"echo IFACE=${var.network_interface} >> /etc/ops/env"
       ,"echo SELF=${local.all[count.index]} >> /etc/ops/env"
       ,"echo ROLE=${count.index < var.manager_count?"manager":"worker"} >> /etc/ops/env"
    ]
  }

  provisioner "remote-exec" {
    script = "${path.module}/scripts/00-limits.sh"
  }

  provisioner "remote-exec" {
    script = "${path.module}/scripts/10-docker.sh"
  }

  provisioner "remote-exec" {
    script = "${path.module}/scripts/20-weave.sh"
  }
*/

  provisioner "file" {
    source="${path.module}/services/weave.service"
    destination="/etc/systemd/system/weave.service"
  }

  provisioner "remote-exec" {
    script = "${path.module}/scripts/21-weave-service.sh"
  }

/*

#  provisioner "remote-exec" {
#    script = "${path.module}/scripts/21-weave-setup.sh"
#  }

#  provisioner "remote-exec" {
#    script = "${path.module}/scripts/22-weave-launch.sh"
#  }

  provisioner "remote-exec" {
    script = "${path.module}/scripts/30-consul.sh"
  }

  provisioner "file" {
    source="${path.module}/services/consul.service"
    destination="/etc/systemd/system/consul.service"
  }

  provisioner "remote-exec" {
    script = "${path.module}/scripts/31-consul-service.sh"
  }

#  provisioner "remote-exec" {
#    script = "${path.module}/scripts/40-vault.sh"
#  }

  provisioner "remote-exec" {
    script = "${path.module}/scripts/50-nomad.sh"
  }

  provisioner "file" {
    source="${path.module}/services/nomad.service"
    destination="/etc/systemd/system/nomad.service"
  }

  provisioner "remote-exec" {
    script = "${path.module}/scripts/51-nomad-service.sh"
  }
*/

}

