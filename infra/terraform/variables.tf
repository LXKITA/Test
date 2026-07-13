variable "cloud_id" {
  description = "Yandex Cloud identifier"
  type        = string
}

variable "folder_id" {
  description = "Yandex Cloud folder identifier"
  type        = string
}

variable "zone" {
  description = "Availability zone"
  type        = string
  default     = "ru-central1-a"
}

variable "project_name" {
  description = "Prefix for laboratory resources"
  type        = string
  default     = "devops-course"
}

variable "subnet_cidr" {
  description = "Laboratory subnet"
  type        = string
  default     = "10.20.0.0/24"
}

variable "admin_cidr" {
  description = "Learner public address in CIDR notation; never use 0.0.0.0/0"
  type        = string

  validation {
    condition     = var.admin_cidr != "0.0.0.0/0" && can(cidrnetmask(var.admin_cidr))
    error_message = "admin_cidr must be a valid restricted CIDR."
  }
}

variable "web_cidrs" {
  description = "Networks allowed to reach the demo HTTP endpoint"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "ssh_public_key" {
  description = "Public SSH key for the ubuntu user"
  type        = string
  sensitive   = true

  validation {
    condition     = can(regex("^ssh-(ed25519|rsa) ", var.ssh_public_key))
    error_message = "Use an OpenSSH ed25519 or RSA public key."
  }
}
