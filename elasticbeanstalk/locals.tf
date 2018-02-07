locals {
  workspaces = {
    default = {
      environment_name = "staging"
      create_application = true
    }
    prod = {
      environment_name = "prod"
      create_application = false
    }
  }
  workspace  = "${local.workspaces[terraform.workspace]}"
}
