##################################################################################
# VARIABLES
##################################################################################

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "private_key_path" {}
variable "ami" {}

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
  ami           = "${var.ami}"
  instance_type = "t2.micro"
  count = 2
  security_groups = ["sg-00ed19240b9be9ae1"]
  subnet_id = "subnet-0888efe3afbdac742"
  associate_public_ip_address = true
  
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

resource "aws_instance" "consul" {
  ami           = "${var.ami}"
  instance_type = "t2.micro"
  count = 2
  security_groups = ["sg-0bb9c611b1c118612"]
  subnet_id = "subnet-0888efe3afbdac742"
  associate_public_ip_address = true

  provisioner "file" {
    source      = "consul.sh"
    destination = "/tmp/consul.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/consul.sh",
      "/tmp/consul.sh",
    ]
  }
}


###########################################################################
#                                                                         #
#                                    Output                               #
###########################################################################
