variable "ghe_token" {
  type        = string
  description = "Personal token to admin Github"
  sensitive = true
}

variable "tfe_hostname" {
  type        = string
  default     = "app.terraform.io"
  description = "Terraform Enterpise Host Name default value app.terraform.io (terraform cloud)"
}

variable "tfe_token" {
  type        = string
  description = "Terraform enterprise admin token"
  sensitive = true
}

variable "org_name" {
  type        = string
  description = "Terraform enterprise organization name"
}

variable "tfe_org_email" {
  type        = string
  description = "Terraform enterprise admin email address"

  validation {
    condition     = can(regex("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", var.tfe_org_email))
    error_message = "The tfe_org_email value must be a valid email address."
  }
}

variable "ghe_api_url" {
  type        = string
  description = "github API URL for vcs connection to tfe org"

  validation {
    condition     = can(regex("^(http|https)://", var.ghe_api_url))
    error_message = "The ghe_api_url value must be a valid URL."
  }
}

variable "ghe_http_url" {
  type        = string
  description = "github http url for vcs connection to tfe org"

  validation {
    condition     = can(regex("^(http|https)://", var.ghe_http_url))
    error_message = "The ghe_http_url value must be a valid URL."
  }
}
