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

