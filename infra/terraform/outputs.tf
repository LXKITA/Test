output "instance_name" {
  value = yandex_compute_instance.lab.name
}

output "public_ip" {
  value = yandex_compute_instance.lab.network_interface[0].nat_ip_address
}

output "cleanup_command" {
  value = "terraform destroy"
}
