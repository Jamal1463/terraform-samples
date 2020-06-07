variable "AWS_ACCESS_KEY" {}

variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
  default = "ap-south-1"
}

variable "AMIS" {
  type = map(string)
  default = {
    ap-south-1 = "ami-052c08d70def0ac62"
  }
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "redmikey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "redmikey.pub"
}

