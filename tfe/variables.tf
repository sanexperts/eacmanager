variable "tfe_hostname" {
  type        = string
  default     = "app.terraform.io"
  description = "Terraform Enterpise Host Name default value app.terraform.io (terraform cloud)"
}

variable "tfe_token" {
  type        = string
  description = "Terraform enterprise admin token"
}

variable "tfe_org_name" {
  type        = string
  description = "Terraform enterprise organization name"
}

variable "tfe_org_email" {
  type        = string
  description = "Terraform enterprise admin email address"
}

variable "ghe_token" {
  type        = string
  description = "Terraform enterprise admin email address"
}

variable "ghe_api_url" {
  type        = string
  description = "github API URL or vcs connection to tfe org"
}

variable "ghe_http_url" {
  type        = string
  description = "github http url for vcs connection to tfe org"
}
