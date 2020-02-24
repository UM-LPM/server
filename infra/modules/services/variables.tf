variable "base_image_id" {
  type = map(string)
}

variable "hosts" {
  type = map(string)
}

variable "private_network_id" {
  type = string
}

variable "public_network_interface" {
  type = string
}
