variable "hosts" {
  default = {
    "bastion" = "10.17.3.201"
    "gateway" = "10.17.3.202"

    "test" = "10.17.3.10"

    "spum_docker_registry" = "10.17.3.101"
    "spum_mqtt" = "10.17.3.102"
    "spum_platform" = "10.17.3.103"
    "martincrepinsek" = "10.17.3.104"
  }
}
