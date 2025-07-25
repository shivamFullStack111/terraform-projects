module "my-module" {
  source = "./module"
  vpc_cidr = "10.0.0.0/16"
  vpc_name =  "upload-ec2-instance"
  private_subnet_cidr =  "10.0.0.0/24"
  public_subnet_cidr =  "10.0.1.0/24"
}