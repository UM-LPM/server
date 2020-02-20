module "images" {
  source = "../modules/images"

  machines_path = "../../machines"
  pool_path = "/var/lib/pools/images"
}

resource "libvirt_volume" "bastion_image" {
  name = "bastion_image"
  pool = module.images.image_pool_name
  base_volume_id = module.images.bastion_image_id
  base_volume_pool = module.images.image_pool_name
  format = "qcow2"
}

resource "libvirt_volume" "gateway_image" {
  name = "gateway_image"
  pool = module.images.image_pool_name
  base_volume_id = module.images.gateway_image_id
  base_volume_pool = module.images.image_pool_name
  format = "qcow2"
}

resource "libvirt_volume" "test_image" {
  name = "test_image"
  pool = module.images.image_pool_name
  base_volume_id = module.images.minimal_image_id
  base_volume_pool = module.images.image_pool_name
  format = "qcow2"
}
