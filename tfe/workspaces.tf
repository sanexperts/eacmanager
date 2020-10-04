resource "tfe_workspace" "ghemanager" {
  name           = "${var.tfe_org_name}-ghemanager"
  organization   = var.tfe_org_name
  queue_all_runs = false
  vcs_repo {
    identifier         = "${var.tfe_org_name}/${var.tfe_org_name}-ghemanager"
    branch             = "main"
    ingress_submodules = "true"
    oauth_token_id     = tfe_oauth_client.github.oauth_token_id
  }
  depends_on = [
    tfe_oauth_client.github
  ]
}

resource "tfe_variable" "ghe_token" {
  key          = "ghe_token"
  value        = var.ghe_token
  category     = "terraform"
  workspace_id = tfe_workspace.ghemanager.id
  description  = "Personal token to admin Github"
  depends_on = [
    tfe_workspace.ghemanager
  ]
}

resource "tfe_variable" "ghe_organization" {
  key          = "ghe_organization"
  value        = var.tfe_org_name
  category     = "terraform"
  workspace_id = tfe_workspace.ghemanager.id
  description  = "Name of the github organization to be created"
  depends_on = [
    tfe_workspace.ghemanager
  ]
}

resource "tfe_workspace" "tfemanager" {
  name           = "${var.tfe_org_name}-tfemanager"
  organization   = var.tfe_org_name
  queue_all_runs = false
  vcs_repo {
    identifier         = "${var.tfe_org_name}/${var.tfe_org_name}-tfemanager"
    branch             = "main"
    ingress_submodules = "true"
    oauth_token_id     = tfe_oauth_client.github.oauth_token_id
  }
  depends_on = [
    tfe_workspace.tfemanager
  ]
}

resource "tfe_variable" "tfe_hostname" {
  key          = "tfe_hostname"
  value        = var.tfe_hostname
  category     = "terraform"
  workspace_id = tfe_workspace.tfemanager.id
  description  = "Terraform Enterpise Host Name default value app.terraform.io (terraform cloud)"
  depends_on = [
    tfe_workspace.tfemanager
  ]
}

resource "tfe_variable" "tfe_token" {
  key          = "tfe_token"
  value        = var.tfe_token
  category     = "terraform"
  workspace_id = tfe_workspace.tfemanager.id
  description  = "Terraform enterprise admin token"
  depends_on = [
    tfe_workspace.tfemanager
  ]
}

resource "tfe_variable" "tfe_org_name" {
  key          = "tfe_org_name"
  value        = var.tfe_org_name
  category     = "terraform"
  workspace_id = tfe_workspace.tfemanager.id
  description  = "Terraform enterprise organization name"
  depends_on = [
    tfe_workspace.tfemanager
  ]
}

resource "tfe_variable" "tfe_org_email" {
  key          = "tfe_org_email"
  value        = var.tfe_org_email
  category     = "terraform"
  workspace_id = tfe_workspace.tfemanager.id
  description  = "Terraform enterprise admin email address"
  depends_on = [
    tfe_workspace.tfemanager
  ]
}

resource "tfe_variable" "ghe_token_tfe" {
  key          = "ghe_token"
  value        = var.ghe_token
  category     = "terraform"
  workspace_id = tfe_workspace.tfemanager.id
  description  = "Terraform enterprise admin email address"
  depends_on = [
    tfe_workspace.tfemanager
  ]
}

resource "tfe_variable" "ghe_api_url" {
  key          = "ghe_api_url"
  value        = var.ghe_api_url
  category     = "terraform"
  workspace_id = tfe_workspace.tfemanager.id
  description  = "github API URL or vcs connection to tfe org"
  depends_on = [
    tfe_workspace.tfemanager
  ]
}

resource "tfe_variable" "ghe_http_url" {
  key          = "ghe_http_url"
  value        = var.ghe_http_url
  category     = "terraform"
  workspace_id = tfe_workspace.tfemanager.id
  description  = "github http url for vcs connection to tfe org"
  depends_on = [
    tfe_workspace.tfemanager
  ]
}
