terraform {
  required_providers {
    github = {
      source = "hashicorp/github"
      version = "3.0.0"
    }
  }
}

provider "github" {
  token        = var.ghe_token
  organization = var.ghe_organization
}
