resource "github_repository_file" "upload-tfe-project" {
  repository = "${var.tfe_org_name}-tfemanager"
  for_each   = fileset(path.module, "*.{tf,md}")
  file       = each.key
  content    = file(each.value)
  branch     = "main"
}
