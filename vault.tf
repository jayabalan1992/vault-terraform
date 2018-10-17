##################################################################################
# VARIABLES
##################################################################################

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "private_key_path" {}
variable "ami" {}
variable "key_name" {}

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
resource "aws_instance" "haproxy" {
  ami           = "${var.ami}"
  instance_type = "t2.micro"
  count = 1
  security_groups = ["sg-00368e8b69a2d46eb"]
  subnet_id = "subnet-0888efe3afbdac742"
  associate_public_ip_address = true
  key_name        = "${var.key_name}"

  tags {
    Name = "haproxy${count.index}"
  }

  provisioner "file" {
     source = "haproxyconf.sh"
     destination = "/tmp/haproxyconf.sh"
     connection {
       user = "ec2-user"
       private_key = "${file("${var.private_key_path}\\new2018.pem")}"
     }

    }

#    provisioner "remote-exec" {
#        inline = [
#          "sleep 420",
#          "chmod +x /tmp/haproxyconf.sh",
#          "sudo /tmp/haproxyconf.sh"
#        ]
#    }
}


resource "aws_instance" "vault" {
  ami           = "${var.ami}"
  instance_type = "t2.micro"
  count = 2
  security_groups = ["sg-00ed19240b9be9ae1"]
  subnet_id = "subnet-0888efe3afbdac742"
  associate_public_ip_address = true
  key_name        = "${var.key_name}"

  tags {
    Name = "vault${count.index}"
  }  
  provisioner "file" {
    source      = "vault.sh"
    destination = "/tmp/vault.sh"
    connection {
      user = "ec2-user"
      private_key = "${file("${var.private_key_path}\\new2018.pem")}"
    }
  }
 
#  provisioner "remote-exec" {
#    inline = [
#      "chmod +x /tmp/vault.sh",
#      "sudo bash /tmp/vault.sh",
#    ]
#    connection {
#      user = "ec2-user"
#      private_key = "${file("${var.private_key_path}\\new2018.pem")}"
#    }
#  }
}

resource "aws_instance" "consul" {
  ami           = "${var.ami}"
  instance_type = "t2.micro"
  count = 3
  security_groups = ["sg-0bb9c611b1c118612"]
  subnet_id = "subnet-0888efe3afbdac742"
  associate_public_ip_address = true
  key_name        = "${var.key_name}"
  
  tags {
    Name = "consul${count.index}"
  }


  provisioner "file" {
    source      = "consul.sh"
    destination = "/tmp/consul.sh"
    connection {
      user        = "ec2-user"
      private_key = "${file("${var.private_key_path}\\new2018.pem")}"
      timeout = "2m"
    } 
}

#  provisioner "remote-exec" {
#    inline = [
#      "chmod +x /tmp/consul.sh",
#      "sudo bash /tmp/consul.sh",
#    ]
#    connection {
#      user        = "ec2-user"
#      private_key = "${file("${var.private_key_path}\\new2018.pem")}"
#      timeout = "2m"
#    }
#  }
}

###########################################################################
#                                                                         #
#                                    Output                               #
###########################################################################
