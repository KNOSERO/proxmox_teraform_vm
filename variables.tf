variable "pm_api_url" {
  type    = string
  default = "https://192.168.0.2:8006/api2/json"
}

variable "pm_user" {
  type    = string
  default = "root@pam"
}

variable "pm_password" {
  type = string
}

variable "containers" {
  type = list(object({
    name        = string
    type        = string
    target_node = string
    vmid        = number
    cores       = number
    memory      = number
    balloon     = number
    ip_address  = string
    mac         = string
  }))
}

variable "ci_user" {
  type    = string
  default = "root"
}

variable "ci_password" {
  type = string
}

variable "ci_password_hashed" {
  type = string
}

variable "path_ssh_key" {
  type    = string
  default = "/root/.ssh/id_home_lab.pub"
}