terraform {
  required_version = ">= 1.5.0"
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

resource "yandex_vpc_network" "lab" {
  name = "${var.project_name}-network"
}

resource "yandex_vpc_subnet" "lab" {
  name           = "${var.project_name}-subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.lab.id
  v4_cidr_blocks = [var.subnet_cidr]
}

resource "yandex_vpc_security_group" "lab" {
  name       = "${var.project_name}-sg"
  network_id = yandex_vpc_network.lab.id

  ingress {
    protocol       = "TCP"
    description    = "SSH only from the learner address"
    port           = 22
    v4_cidr_blocks = [var.admin_cidr]
  }

  ingress {
    protocol       = "TCP"
    description    = "Course web application"
    port           = 80
    v4_cidr_blocks = var.web_cidrs
  }

  egress {
    protocol       = "ANY"
    description    = "Package installation and external APIs"
    from_port      = 0
    to_port        = 65535
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_iam_service_account" "vm" {
  name        = "${var.project_name}-vm"
  description = "Service account without folder roles for the course VM"
}

data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2404-lts-oslogin"
}

resource "yandex_compute_instance" "lab" {
  name        = "${var.project_name}-vm"
  platform_id = "standard-v3"
  zone        = var.zone

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = 15
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.lab.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.lab.id]
  }

  service_account_id = yandex_iam_service_account.vm.id

  metadata = {
    user-data = templatefile("${path.module}/cloud-init.yaml.tftpl", {
      ssh_public_key = var.ssh_public_key
    })
    serial-port-enable = 0
  }

  scheduling_policy {
    preemptible = true
  }
}
