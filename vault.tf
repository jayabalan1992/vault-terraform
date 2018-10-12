##################################################################################
# VARIABLES
##################################################################################

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "private_key_path" {}

##################################################################################
# PROVIDERS
##################################################################################

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "us-east-1"
}

##################################################################################
# RESOURCES
##################################################################################

data "aws_caller_identity" "current" { }

resource "aws_instance" "example" {
  ami           = "${var.ami}"
  instance_type = "t2.micro"
   provisioner "file" {
    source      = "vault.sh"
    destination = "/tmp/vault.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/vault.sh",
      "/tmp/vault.sh",
    ]
  }
}

module "consul" {
  source  = "hashicorp/consul/aws"
  num_servers = 3
}
