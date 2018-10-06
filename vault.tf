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

resource "aws_instance" "vault" {
  ami           = "ami-06b5810be11add0e2"
  instance_type = "t2.micro"

  connection {
    user        = "ec2-user"
#    private_key = "${file(var.private_key_path)}"
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.vault.public_ip} > ip_address.txt"
  }

}
