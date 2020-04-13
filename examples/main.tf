module "digital_ocean_web" {
  source = "../"

  do_token = "some_do_token"
  name = "some_name"
  startup_script = templatefile("${path.module}/startup.sh", local.script_variables)
}

locals {
  script_variables = {
    first_variable = "first_variable"
  }
}