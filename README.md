Add credentials to setupEnvironment.sh first and run
`source setupEnvironment.sh`

Create ssh key first
`ssh-keygen -t rsa -b 4096 -C "your_email@example.com"`

print public key
`cat ~/.ssh/id_rsa.pub`

copy this content into the sshkey.tf file into the public_key variable

Setup terraform to load pluings

`terraform init`

Plan terraform run
`terraform plan`

Run terraform
`terraform apply`

Destroy all
`terraform destroy`
