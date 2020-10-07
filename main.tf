#Create tfvars from bootstrap tfvars file
resource "local_file" "ghetfvars" {
  content  = templatefile("tmpl/ghetfvars.tmpl", { ghe_token = var.ghe_token, ghe_organization = var.org_name })
  filename = "ghe/terraform.tfvars"
}

resource "local_file" "tfetfvars" {
  content  = templatefile("tmpl/tfetfvars.tmpl", { tfe_hostname = var.tfe_hostname, tfe_token = var.tfe_token, tfe_org_name = var.org_name, tfe_org_email = var.tfe_org_email, ghe_token = var.ghe_token, ghe_api_url = var.ghe_api_url, ghe_http_url = var.ghe_http_url })
  filename = "tfe/terraform.tfvars"
}

#Create ghe repos for ghe manager & tfe Manager

resource "null_resource" "createrepos" {
  provisioner "local-exec" {
    when        = create
    command     = "terraform init &&  terraform apply -auto-approve "
    working_dir = "ghe/"
  }
  provisioner "local-exec" {
    when        = destroy
    command     = "rm -rf .terraform && rm -f terraform.tfstate && cp terraform.tfstate.backup terraform.tfstate && terraform init & terraform destroy -auto-approve "
    working_dir = "ghe/"
  }
  depends_on = [
    local_file.ghetfvars
  ]
}

#Create tfe Org, ghe & tfe workspaces

resource "null_resource" "createworkspaces" {
  provisioner "local-exec" {
    when        = create
    command     = "terraform init &&  terraform apply -auto-approve "
    working_dir = "tfe/"
  }
  provisioner "local-exec" {
    when        = destroy
    command     = "rm -rf .terraform && rm -f terraform.tfstate && cp terraform.tfstate.backup terraform.tfstate && terraform init && terraform destroy -auto-approve "
    working_dir = "tfe/"
  }
  depends_on = [
    null_resource.createrepos, local_file.tfetfvars
  ]
}

#create backend configs and push the states

resource "local_file" "ghebackend" {
  content  = templatefile("tmpl/backend.tmpl", { tfe_hostname = var.tfe_hostname, tfe_organization = var.org_name, tfe_token = var.tfe_token, tfe_workspace = "${var.org_name}-ghemanager" })
  filename = "ghe/backend.tf"
  depends_on = [
    null_resource.createworkspaces
  ]
}


resource "null_resource" "pushghestate" {
  provisioner "local-exec" {
    when        = create
    command     = "terraform init && terraform state push terraform.tfstate.backup"
    working_dir = "ghe"
  }
  depends_on = [
    local_file.ghebackend
  ]
}


resource "local_file" "tfebackend" {
  content  = templatefile("tmpl/backend.tmpl", { tfe_hostname = var.tfe_hostname, tfe_organization = var.org_name, tfe_token = var.tfe_token, tfe_workspace = "${var.org_name}-tfemanager" })
  filename = "tfe/backend.tf"
  depends_on = [
    null_resource.createworkspaces
  ]
}


resource "null_resource" "pushtfestate" {
  provisioner "local-exec" {
    when        = create
    command     = "terraform init && terraform state push terraform.tfstate.backup"
    working_dir = "tfe"
  }
  depends_on = [
    local_file.tfebackend
  ]
}

#Config oauth apps and link them to the proper workspaces.

#enjoy coding



# resource "local_file" "ghebackend" {
