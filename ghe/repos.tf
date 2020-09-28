resource "github_repository" "ghemanager_repo" {
  name             = "${var.ghe_organization}-ghemanager"
  visibility       = "private"
  license_template = "mit"
  auto_init        = "true"
}

resource "github_repository_file" "upload-this-project" {
  repository = github_repository.ghemanager_repo.name
  for_each   = fileset(path.module, "*.tf")
  file       = each.key
  content    = file(each.value)
}
