variable "aws_region" {
  default = "ap-northease-1"
}

provider "aws" {
  region = var.aws_region
}