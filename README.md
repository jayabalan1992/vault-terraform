# AWS EC2 with Vault installation

This terraform script will spin up instances in EC2 with Hashicorp Vault installed in them.
Also it will create 3 consul servers, 2 vault servers with Consul installed in them and 1 haproxy Load Balancer.

Scripts for Vault and Consul installation are saved and run inside the new instances created on AWS. 

