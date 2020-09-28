resource "github_team" "admin_team" {
  name        = "admin-${var.ghe_organization}"
  description = "Admin team for ${var.ghe_organization}"
  privacy     = "closed"
}

resource "github_team_repository" "some_team_repo" {
  team_id    = github_team.admin_team.id
  repository = github_repository.ghemanager_repo.name
  permission = "admin"
}
