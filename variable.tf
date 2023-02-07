variable "subnet_cidr" {
    default = ["10.10.0.0/26","10.10.0.64/26","10.10.0.128/26"]
}

variable "tag" {
  default = ["jumphost","web","db"]
}