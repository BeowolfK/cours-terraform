# Module Terraform EC2 avec Datasources

Ce module Terraform déploie une instance EC2 sur AWS en utilisant des datasources pour récupérer dynamiquement l'AMI et le subnet.

## 🎯 **Fonctionnalités**

- ✅ **AMI dynamique** : Récupère automatiquement la dernière AMI Amazon Linux 2023
- ✅ **Subnet via datasource** : Pas besoin de hardcoder le subnet ID
- ✅ **Configuration flexible** : Nom et type d'instance configurables
- ✅ **Outputs complets** : Public DNS, Public IP, AMI info, etc.
- ✅ **Sécurité SSH** : Security group configurable

## 📋 **Variables du module**

| Variable | Description | Type | Défaut | Obligatoire |
|----------|-------------|------|--------|-------------|
| `instance_name` | Nom de l'instance EC2 | string | `terraform-ec2-instance` | Non |
| `instance_type` | Type d'instance (t3.micro, t3.small, etc.) | string | `t3.micro` | Non |
| `subnet_id` | ID du subnet où déployer | string | `subnet-0d2b7f8e860ab5e38` | Non |
| `ssh_key_name` | Nom de la clé SSH dans AWS | string | `terraform-ec2-key` | Non |
| `ssh_public_key_path` | Chemin vers la clé publique SSH | string | `aws-ec2-key.pub` | Non |
| `volume_size` | Taille du disque en GB | number | `8` | Non |
| `security_group_name` | Nom du security group | string | `terraform-allow-ssh` | Non |
| `allow_ssh_from_cidr` | CIDR autorisé pour SSH | list(string) | `["0.0.0.0/0"]` | Non |

## 📤 **Outputs**

| Output | Description |
|--------|-------------|
| `instance_public_ip` | Adresse IP publique de l'instance |
| `instance_public_dns` | DNS public de l'instance |
| `instance_private_ip` | Adresse IP privée |
| `ami_id` | ID de l'AMI utilisée |
| `ami_name` | Nom de l'AMI utilisée |
| `subnet_id` | ID du subnet |
| `vpc_id` | ID du VPC |
| `ssh_connection_command` | Commande SSH pour se connecter |

## 🚀 **Utilisation**

### **Exemple 1 : Utilisation avec valeurs par défaut**

```hcl
module "ec2" {
  source = "./TP4"
}

output "public_ip" {
  value = module.ec2.instance_public_ip
}

output "public_dns" {
  value = module.ec2.instance_public_dns
}
```

### **Exemple 2 : Configuration personnalisée**

```hcl
module "ec2" {
  source = "./TP4"

  instance_name  = "my-web-server"
  instance_type  = "t3.small"
  subnet_id      = "subnet-0d2b7f8e860ab5e38"
  volume_size    = 20
}

output "connection_info" {
  value = {
    public_ip  = module.ec2.instance_public_ip
    public_dns = module.ec2.instance_public_dns
    ssh_cmd    = module.ec2.ssh_connection_command
  }
}
```

### **Exemple 3 : Utilisation comme module depuis GitHub**

```hcl
module "ec2" {
  source = "github.com/your-username/terraform-aws-ec2"

  instance_name = "production-server"
  instance_type = "t3.medium"
}
```

## 📦 **Déploiement**

### **1. Initialiser Terraform**

```bash
cd /Users/kenan/Documents/IMT/IaC/TP4
terraform init
```

### **2. Planifier les changements**

```bash
terraform plan
```

### **3. Appliquer la configuration**

```bash
terraform apply
```

### **4. Se connecter à l'instance**

```bash
# La commande SSH est affichée dans les outputs
terraform output ssh_connection_command

# Ou directement :
ssh -i aws-ec2-key ec2-user@$(terraform output -raw instance_public_ip)
```

## 🔍 **Datasources utilisées**

### **AMI Datasource**

```hcl
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}
```

Récupère automatiquement la **dernière version** d'Amazon Linux 2023.

### **Subnet Datasource**

```hcl
data "aws_subnet" "selected" {
  id = var.subnet_id
}
```

Récupère les informations du subnet (y compris le VPC ID).

### **VPC Datasource**

```hcl
data "aws_vpc" "selected" {
  id = data.aws_subnet.selected.vpc_id
}
```

Récupère le VPC depuis le subnet pour le security group.

## 🧪 **Tests**

```bash
# Afficher tous les outputs
terraform output

# Afficher uniquement l'IP publique
terraform output instance_public_ip

# Afficher le DNS public
terraform output instance_public_dns

# Afficher l'AMI utilisée
terraform output ami_name
```

## 🧹 **Nettoyage**

```bash
terraform destroy
```

## 📝 **Structure du module**

```
TP4/
├── provider.tf       # Configuration AWS
├── datasources.tf    # Datasources pour AMI et subnet
├── variables.tf      # Variables configurables
├── ec2.tf           # Ressources EC2 (instance, SG, key pair)
├── outputs.tf       # Outputs du module
└── README.md        # Documentation
```

## ⚠️ **Notes de sécurité**

- Par défaut, SSH est ouvert à `0.0.0.0/0` (toutes les IPs)
- En production, restreindre `allow_ssh_from_cidr` à votre IP uniquement
- Ne jamais commiter les clés SSH privées dans Git
- Ne jamais commiter le fichier `provider.tf` avec les credentials

## 🎓 **Avantages des datasources**

1. **Flexibilité** : Plus besoin de hardcoder les AMI IDs
2. **Maintenance** : Toujours la dernière version de l'AMI
3. **Réutilisabilité** : Le module fonctionne dans toutes les régions
4. **Découverte** : Récupère automatiquement les infos du VPC depuis le subnet

---

Créé pour IMT IaC - TP4
