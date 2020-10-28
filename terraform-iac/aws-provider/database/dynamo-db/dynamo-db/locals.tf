locals {
  default_tags = {
    type           = "map"
    application_id = "${var.application_id}"
    environment    = "${var.environment}"
    created_by     = "${var.created_by}"
  }

}
