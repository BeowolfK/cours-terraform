# EXEMPLE D'UTILISATION DU MODULE EC2
# Ce fichier montre comment utiliser le module depuis un autre répertoire

# =====================================
# EXEMPLE 1 : Configuration par défaut
# =====================================

# module "ec2_default" {
#   source = "./TP4"
# }

# output "default_public_ip" {
#   value = module.ec2_default.instance_public_ip
# }

# output "default_public_dns" {
#   value = module.ec2_default.instance_public_dns
# }


# =====================================
# EXEMPLE 2 : Configuration personnalisée
# =====================================

# module "ec2_custom" {
#   source = "./TP4"
#
#   instance_name        = "web-server-kenan"
#   instance_type        = "t3.small"
#   subnet_id            = "subnet-0d2b7f8e860ab5e38"
#   volume_size          = 20
#   security_group_name  = "kenan-sg-ssh"
#   ssh_key_name         = "kenan-ec2-key"
# }

# output "custom_info" {
#   value = {
#     public_ip  = module.ec2_custom.instance_public_ip
#     public_dns = module.ec2_custom.instance_public_dns
#     ami_used   = module.ec2_custom.ami_name
#     ssh_cmd    = module.ec2_custom.ssh_connection_command
#   }
# }


# =====================================
# EXEMPLE 3 : Multiple instances
# =====================================

# module "ec2_web" {
#   source = "./TP4"
#
#   instance_name = "web-server"
#   instance_type = "t3.small"
# }

# module "ec2_db" {
#   source = "./TP4"
#
#   instance_name       = "database-server"
#   instance_type       = "t3.medium"
#   security_group_name = "db-security-group"
#   ssh_key_name        = "db-key"
# }

# output "web_server" {
#   value = {
#     ip  = module.ec2_web.instance_public_ip
#     dns = module.ec2_web.instance_public_dns
#   }
# }

# output "db_server" {
#   value = {
#     ip  = module.ec2_db.instance_public_ip
#     dns = module.ec2_db.instance_public_dns
#   }
# }


# =====================================
# EXEMPLE 4 : Afficher toutes les infos
# =====================================

# module "ec2_full" {
#   source = "./TP4"
#
#   instance_name = "full-example"
# }

# output "complete_info" {
#   value = {
#     instance_id   = module.ec2_full.instance_id
#     public_ip     = module.ec2_full.instance_public_ip
#     public_dns    = module.ec2_full.instance_public_dns
#     private_ip    = module.ec2_full.instance_private_ip
#     ami_id        = module.ec2_full.ami_id
#     ami_name      = module.ec2_full.ami_name
#     subnet_id     = module.ec2_full.subnet_id
#     vpc_id        = module.ec2_full.vpc_id
#     sg_id         = module.ec2_full.security_group_id
#     ssh_command   = module.ec2_full.ssh_connection_command
#   }
# }
