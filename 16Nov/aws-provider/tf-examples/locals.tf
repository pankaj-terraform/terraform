locals {
  default_tags = {
    application_id   = var.application_id
    environment      = var.environment
    created_by       = var.created_by
    stack_name       = var.stack_name
    termination_date = var.termination_date
    date_class       = var.date_class
  }
}
