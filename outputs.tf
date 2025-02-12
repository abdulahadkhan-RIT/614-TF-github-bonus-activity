output "wordpress_url" {
  value = "http://${module.ec2.public_ip}"
  description = "The public URL of the WordPress site"
}

output "database_endpoint" {
  value = module.rds.endpoint
  description = "The endpoint of the RDS database"
}
