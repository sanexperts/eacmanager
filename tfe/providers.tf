provider "tfe" {
  hostname = var.tfe_hostname
  token    = var.tfe_token
  version  = "0.16.2"
}

provider "github" {
  token        = var.ghe_token
  organization = var.tfe_org_name
  version      = "3.0.0"
}
