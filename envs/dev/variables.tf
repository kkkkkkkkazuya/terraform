variable "name" {
  type = string
}

variable "region" {
  type = string
}

variable "vpc_cider" {
  type = string
}

variable "az_a" {
  type    = string
  default = "ap-northeast-1a"
}

variable "az_c" {
  type    = string
  default = "ap-northeast-1c"
}

variable "public_dev_cidr_block" {
  type = string
}

variable "dev_all_rt_cidr_block" {
  type = string
}

variable "aws_access_key" {}
variable "aws_secret_key" {}

