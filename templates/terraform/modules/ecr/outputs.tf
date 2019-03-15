output "ecr_repository_name" {
  value = "${aws_ecr_repository.app.name}"
}

output "ecr_repository_arn" {
  value = "${aws_ecr_repository.app.arn}"
}
