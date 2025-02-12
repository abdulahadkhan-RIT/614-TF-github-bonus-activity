variable "subnet_ids" {
  type = list(string)
}
variable "security_group_id" {}
variable "instance_class" {
  default = "db.t3.micro"
}
variable "db_name" {
  default = "wordpressdb"
}
variable "username" {}
variable "password" {}
