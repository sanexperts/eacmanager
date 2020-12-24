variable "ghe_token" {
  type        = string
  description = "Personal token to admin Github"
  sensitive = true
}

variable "ghe_organization" {
  type        = string
  description = "Name of the github organization to be created"
}
