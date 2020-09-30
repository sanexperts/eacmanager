resource "tfe_workspace" "ghemanager" {
  name         = "${var.tfe_org_name}-ghemanager"
  organization = var.tfe_org_name
  vcs_repo {
    identifier         = "babufrik-org/babufrik-org-ghemanager"
    branch             = "master"
    ingress_submodules = "true"
    oauth_token_id     = tfe_oauth_client.github.oauth_token_id
  }
  depends_on = [
    tfe_oauth_client.github
  ]
}

resource "local_file" "backend" {
  content  = templatefile("../tmpl/backend.tmpl", { tfe_hostname = var.tfe_hostname, tfe_organization = var.tfe_org_name, tfe_token = var.tfe_token, tfe_workspace = tfe_workspace.ghemanager.name })
  filename = "../ghe/backend.tf"
}

# resource "null_resource" "pushghestate" {
#   provisioner "local-exec" {
#     command     = "terraform state push"
#     working_dir = "../ghe"
#   }
# }

resource "tfe_variable" "ghe_token" {
  key          = "ghe_token"
  value        = var.ghe_token
  category     = "terraform"
  workspace_id = tfe_workspace.ghemanager.id
  description  = "Personal token to admin Github"
}

resource "tfe_variable" "ghe_organization" {
  key          = "ghe_organization"
  value        = var.tfe_org_name
  category     = "terraform"
  workspace_id = tfe_workspace.ghemanager.id
  description  = "Name of the github organization to be created"
}
