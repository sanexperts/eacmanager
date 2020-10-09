provider "github" {
  token        = var.ghe_token
  organization = var.ghe_organization
  version      = "3.0.0"
}
