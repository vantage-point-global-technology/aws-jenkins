output "public_dns" {
  value = aws_eip.jenkins_eip[0].public_dns
  depends_on = [
    aws_eip.jenkins_eip
  ]
}