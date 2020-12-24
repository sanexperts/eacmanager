terraform {
  required_providers {
    github = {
      source = "hashicorp/github"
      version = "3.0.0"
    }
    tfe = {
      source = "hashicorp/tfe"
      version = "0.16.2"
    }
  }
}

provider "tfe" {
  hostname = var.tfe_hostname
  token    = var.tfe_token
}

provider "github" {
  token        = var.ghe_token
  organization = var.tfe_org_name
}
