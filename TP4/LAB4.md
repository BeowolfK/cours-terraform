# LAB 4 : Remote State, Workspaces et Auto Scaling Group

## 📋 **Objectifs du LAB**

1. ✅ Configurer un backend S3 pour le state Terraform
2. ✅ Migrer le state local vers S3
3. ✅ Remplacer l'instance EC2 unique par un Auto Scaling Group
4. ✅ Créer et utiliser des workspaces Terraform
5. ✅ Déployer des infrastructures différentes par workspace

---

## 🏗️ **Architecture**

### **Ce qui a changé :**

| Avant (LAB 3) | Maintenant (LAB 4) |
|---------------|-------------------|
| 1 instance EC2 unique | Auto Scaling Group (1-3 instances) |
| State local (.tfstate) | State distant (S3 + DynamoDB) |
| Pas de workspaces | 2 workspaces (france, germany) |
| Taille fixe | Taille variable par workspace |

---

## 📦 **1. Migration vers Backend S3**

### **Étape 1.1 : Détruire l'ancien state (si existant)**

```bash
cd /Users/kenan/Documents/IMT/IaC/TP4

# Si vous avez déjà déployé l'infrastructure, détruisez-la
terraform destroy

# Supprimez l'ancien state local
rm -f terraform.tfstate terraform.tfstate.backup
rm -rf .terraform
```

### **Étape 1.2 : Initialiser avec le backend S3**

```bash
terraform init

# Terraform va vous demander de confirmer la migration
# Répondez "yes" si un state local existe
```

**Résultat attendu :**
```
Initializing the backend...
Successfully configured the backend "s3"!

Terraform has been successfully initialized!
```

### **Étape 1.3 : Vérifier le backend**

```bash
# Voir la configuration du backend
terraform state list
```

---

## 🌍 **2. Déploiement Workspace FRANCE**

### **Étape 2.1 : Créer le workspace "france"**

```bash
# Créer et basculer sur le workspace france
terraform workspace new france

# Vérifier le workspace actif
terraform workspace show
# Devrait afficher : france
```

### **Étape 2.2 : Déployer l'infrastructure France**

```bash
# Planifier avec les variables françaises
terraform plan -var-file="fr.tfvars"

# Déployer
terraform apply -var-file="fr.tfvars"
```

**Configuration France (fr.tfvars) :**
- Instance name : `ec2-france`
- ASG Min : **1**
- ASG Max : **2**

**Résultat attendu :**
```
Apply complete! Resources: X added, 0 changed, 0 destroyed.

Outputs:
asg_name = "ec2-france-asg"
asg_min_size = 1
asg_max_size = 2
workspace = "france"
```

### **Étape 2.3 : Vérifier les ressources**

```bash
# Lister les ressources du workspace france
terraform state list

# Voir les outputs
terraform output
```

---

## 🇩🇪 **3. Déploiement Workspace GERMANY**

### **Étape 3.1 : Créer le workspace "germany"**

```bash
# Créer et basculer sur le workspace germany
terraform workspace new germany

# Vérifier le workspace actif
terraform workspace show
# Devrait afficher : germany
```

### **Étape 3.2 : Déployer l'infrastructure Allemagne**

```bash
# Planifier avec les variables allemandes
terraform plan -var-file="de.tfvars"

# Déployer
terraform apply -var-file="de.tfvars"
```

**Configuration Allemagne (de.tfvars) :**
- Instance name : `ec2-germany`
- ASG Min : **2**
- ASG Max : **3**

**Résultat attendu :**
```
Apply complete! Resources: X added, 0 changed, 0 destroyed.

Outputs:
asg_name = "ec2-germany-asg"
asg_min_size = 2
asg_max_size = 3
workspace = "germany"
```

---

## 🔄 **4. Gestion des Workspaces**

### **Lister tous les workspaces**

```bash
terraform workspace list

# Résultat :
#   default
#   france
# * germany  (← asterisque = workspace actif)
```

### **Basculer entre workspaces**

```bash
# Retourner sur france
terraform workspace select france

# Voir les outputs de france
terraform output
```

### **Vérifier le state S3**

Chaque workspace a son propre state dans S3 :

```
s3://terraform-state-agvq0/
└── global/s3/student_kenan/
    ├── env:/france/terraform.tfstate
    ├── env:/germany/terraform.tfstate
    └── terraform.tfstate (default workspace)
```

---

## 🧪 **5. Tests et Vérification**

### **Test 1 : Vérifier les ASG dans AWS**

```bash
# Workspace france
terraform workspace select france
terraform output asg_name

# Workspace germany
terraform workspace select germany
terraform output asg_name
```

### **Test 2 : Voir les instances en cours**

```bash
# Lister toutes les instances lancées par l'ASG
aws ec2 describe-instances \
  --filters "Name=tag:aws:autoscaling:groupName,Values=ec2-france-asg" \
  --query 'Reservations[*].Instances[*].[InstanceId,State.Name,PublicIpAddress]' \
  --output table
```

### **Test 3 : Vérifier le state S3**

```bash
# Lister les fichiers state dans S3
aws s3 ls s3://terraform-state-agvq0/global/s3/student_kenan/ --recursive
```

---

## 📊 **6. Structure des Fichiers**

```
TP4/
├── backend.tf        # ✅ Configuration backend S3
├── provider.tf       # ✅ Provider AWS
├── datasources.tf    # ✅ Datasources AMI, subnet, VPC
├── variables.tf      # ✅ Variables (avec asg_min_size, asg_max_size)
├── ec2.tf           # ✅ Key pair + Security Group (instance EC2 commentée)
├── asg.tf           # ✅ Launch Template + Auto Scaling Group
├── outputs.tf       # ✅ Outputs ASG
├── fr.tfvars        # ✅ Config France (min=1, max=2)
├── de.tfvars        # ✅ Config Allemagne (min=2, max=3)
└── LAB4.md          # 📖 Ce guide
```

---

## 🎯 **7. Résumé des Commandes**

### **Configuration initiale**

```bash
cd /Users/kenan/Documents/IMT/IaC/TP4
terraform init
```

### **Workspace France**

```bash
terraform workspace new france
terraform apply -var-file="fr.tfvars"
```

### **Workspace Germany**

```bash
terraform workspace new germany
terraform apply -var-file="de.tfvars"
```

### **Navigation entre workspaces**

```bash
terraform workspace list
terraform workspace select france
terraform workspace select germany
```

---

## 🧹 **8. Nettoyage**

Pour détruire les ressources de chaque workspace :

```bash
# Détruire France
terraform workspace select france
terraform destroy -var-file="fr.tfvars"

# Détruire Germany
terraform workspace select germany
terraform destroy -var-file="de.tfvars"

# Supprimer les workspaces
terraform workspace select default
terraform workspace delete france
terraform workspace delete germany
```

---

## 💡 **9. Points Clés à Retenir**

### **Backend S3**
- ✅ State centralisé et sécurisé
- ✅ DynamoDB pour le locking (évite les conflits)
- ✅ Cryptage activé (`encrypt = true`)

### **Workspaces**
- ✅ Isolation des environnements
- ✅ Même code, configurations différentes
- ✅ States séparés dans S3

### **Auto Scaling Group**
- ✅ Haute disponibilité automatique
- ✅ Scalabilité configurée par workspace
- ✅ Launch Template pour la configuration des instances

---

## ❓ **10. Troubleshooting**

### **Problème : "Backend initialization required"**

```bash
terraform init -reconfigure
```

### **Problème : "Workspace already exists"**

```bash
terraform workspace select france
```

### **Problème : "State locked"**

Attendez quelques minutes ou forcez le déverrouillage :

```bash
terraform force-unlock LOCK_ID
```

### **Problème : "Cannot destroy non-empty workspace"**

```bash
# D'abord détruire les ressources
terraform destroy -var-file="fr.tfvars"

# Puis supprimer le workspace
terraform workspace delete france
```

---

## ✅ **Checklist de Validation**

- [ ] Backend S3 configuré et initialisé
- [ ] State migré vers S3
- [ ] Workspace "france" créé
- [ ] ASG déployé en France (min=1, max=2)
- [ ] Workspace "germany" créé
- [ ] ASG déployé en Allemagne (min=2, max=3)
- [ ] Outputs affichent les bonnes valeurs
- [ ] Les 2 workspaces sont isolés

---

**Bravo ! Vous avez complété le LAB 4 ! 🎉**
