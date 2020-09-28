resource "tfe_organization" "tfeadmin_org" {
  name  = var.tfe_org_name
  email = var.tfe_org_email
}

resource "tfe_oauth_client" "github" {
  organization     = var.tfe_org_name
  api_url          = var.ghe_api_url
  http_url         = var.ghe_http_url
  oauth_token      = var.ghe_token
  service_provider = "github"
  depends_on = [
    tfe_organization.tfeadmin_org
  ]
}
