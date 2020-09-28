provider "tfe" {
  hostname = var.tfe_hostname
  token    = var.tfe_token
  version  = "~> 0.16.2"
}
