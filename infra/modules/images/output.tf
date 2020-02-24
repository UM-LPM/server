output "base_image_id" {
  value = {for k, v in libvirt_volume.base_image : k => v.id}
}
