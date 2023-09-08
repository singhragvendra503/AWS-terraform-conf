variable "env" {
  type = string
  default = "staging"
}
variable "aws_region" {
  type = string
  default = "us-east-1"
}
variable "access_key" {
  type = string
}
variable "secret_key" {
  type = string
}
variable "git_username" {
  type = string
}
variable "git_repo" {
  type = string
}
variable "git_token" {
  type = string
}
variable "repo_branch" {
  type = string
  default = "main"
}
variable "solution_stack_name" {
  type = string
  default = "64bit Amazon Linux 2 v5.8.2 running Node.js 14"    
}
variable "application_tier" {
  type = string
  default = "WebServer"
}
variable "instance_type" {
  type = string
  default = "t2.micro"
}
variable "environment_type" {
  type = string
  default = "SingleInstance"    # Update with "LoadBalanced" if you want a load-balanced environment
}
variable "s3_bucket_name" {
  type = string
  default = "demmo503"
}