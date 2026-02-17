# LAB 5-6 : Infrastructure Collaborative (Student 7 & 9)

Projet collaboratif avec backend S3 séparé et déploiement en 2 phases.

## 👥 **Équipe**

- **Student X (7)** : Infrastructure Réseau → `network.tfstate`
- **Student Y (9)** : Auto Scaling Groups → `ec2.tfstate`

## 🏗️ **Architecture Complète**

```
┌─────────────────────────────────────────────────────────────────┐
│                        VPC "Lab5-6"                              │
│                                                                   │
│  ┌────────────────────────────────────────────────────────────┐ │
│  │  Public Subnets (Student X)                                │ │
│  │  ┌──────────────────┐    ┌──────────────────┐             │ │
│  │  │ Public A         │    │ Public B         │             │ │
│  │  │ 192.168.9.0/24   │    │ 192.168.109.0/24 │             │ │
│  │  │ AZ-0             │    │ AZ-1             │             │ │
│  │  └────────┬─────────┘    └────────┬─────────┘             │ │
│  │           │                       │                        │ │
│  │           └───────┬───────────────┘                        │ │
│  │                   │                                        │ │
│  │           ┌───────▼───────┐                                │ │
│  │           │  ALB (80)     │ ← SG Public                    │ │
│  │           │ student-7-9   │                                │ │
│  │           └───────┬───────┘                                │ │
│  └───────────────────┼────────────────────────────────────────┘ │
│                      │                                          │
│        /nginx ───────┼──────▶ nginx-tg (80)                    │
│        /tomcat ──────┼──────▶ tomcat-tg (8080)                 │
│                      │                                          │
│  ┌───────────────────┼────────────────────────────────────────┐ │
│  │  Private Subnet (Student X)                                │ │
│  │           ┌──────▼───────┐                                 │ │
│  │           │ 192.168.7.0  │                                 │ │
│  │           │     /24      │ ← SG Internal                   │ │
│  │           └──────┬───────┘                                 │ │
│  │                  │                                          │ │
│  │     ┌────────────┴──────────────┐                          │ │
│  │     │                           │                          │ │
│  │  ┌──▼────┐  ┌─────┐      ┌─────▼┐  ┌─────┐               │ │
│  │  │Nginx 1│  │Ngin2│      │Tomc1│  │Tomc2│  (Student Y)   │ │
│  │  │t3.mic │  │x    │      │at   │  │     │               │ │
│  │  └───────┘  └─────┘      └─────┘  └─────┘               │ │
│  │                                                            │ │
│  └────────────────────────────────────────────────────────────┘ │
└───────────────────────────────────────────────────────────────────┘
```

## 📦 **Backend S3 Structure**

```
s3://terraform-state-agvq0/global/s3/student_7_9/
├── network.tfstate    (Student X - Réseau)
└── ec2.tfstate        (Student Y - Instances)
```

## 📁 **Structure du Projet**

```
LAB5-6/
├── README.md                    # Ce fichier
│
├── network/                     # Student X (7)
│   ├── backend.tf              # Backend: network.tfstate
│   ├── provider.tf
│   ├── datasources.tf          # VPC Lab5-6
│   ├── subnets.tf              # 3 subnets (1 privé, 2 publics)
│   ├── security_groups.tf      # 2 SG (public, internal)
│   ├── target_groups.tf        # 2 TG (nginx, tomcat)
│   ├── alb.tf                  # ALB + Listener + Rules
│   ├── outputs.tf              # IDs pour Student Y
│   └── README.md
│
└── ec2/                        # Student Y (9)
    ├── backend.tf              # Backend: ec2.tfstate
    ├── provider.tf
    ├── datasources.tf          # Récupère ressources X + AMI
    ├── main.tf                 # 2 instances du module ASG
    ├── outputs.tf
    ├── modules/
    │   └── asg/                # Module ASG réutilisable
    │       ├── main.tf
    │       ├── variables.tf
    │       └── outputs.tf
    └── README.md
```

## 🚀 **Ordre de Déploiement**

### **Phase 1 : Student X (7) - Réseau**

```bash
cd /Users/kenan/Documents/IMT/IaC/LAB5-6/network

terraform init
terraform plan
terraform apply

# Noter les outputs pour Student Y
terraform output
```

**Crée :**
- 3 Subnets
- 2 Security Groups
- 2 Target Groups (vides)
- 1 Application Load Balancer

### **Phase 2 : Student Y (9) - EC2**

```bash
cd /Users/kenan/Documents/IMT/IaC/LAB5-6/ec2

terraform init
terraform plan
terraform apply

# Vérifier les ASG
terraform output
```

**Crée :**
- 2 Auto Scaling Groups (nginx + tomcat)
- 4 Instances EC2 (2+2)
- Attachement aux Target Groups

## 🧪 **Tests End-to-End**

### **1. Récupérer l'URL de l'ALB**

```bash
cd LAB5-6/network
ALB_DNS=$(terraform output -raw alb_dns_name)
echo "ALB URL: http://$ALB_DNS"
```

### **2. Tester Nginx**

```bash
# Devrait retourner la page Bitnami Nginx
curl http://$ALB_DNS/nginx

# Dans le navigateur
open "http://$ALB_DNS/nginx"
```

### **3. Tester Tomcat**

```bash
# Devrait retourner la page Bitnami Tomcat
curl http://$ALB_DNS/tomcat

# Dans le navigateur
open "http://$ALB_DNS/tomcat"
```

### **4. Tester 404 (default)**

```bash
# Devrait retourner "404: Not Found"
curl http://$ALB_DNS/
curl http://$ALB_DNS/random
```

## 📊 **Vérifications**

### **Réseau (Student X)**

```bash
cd LAB5-6/network

# Vérifier les subnets
aws ec2 describe-subnets \
  --filters "Name=tag:Name,Values=student_7_9_*" \
  --query 'Subnets[*].[SubnetId,CidrBlock,Tags[?Key==`Name`].Value|[0]]' \
  --output table

# Vérifier l'ALB
aws elbv2 describe-load-balancers \
  --names student-7-9-alb \
  --query 'LoadBalancers[*].[LoadBalancerName,DNSName,State.Code]' \
  --output table
```

### **EC2 (Student Y)**

```bash
cd LAB5-6/ec2

# Vérifier les ASG
aws autoscaling describe-auto-scaling-groups \
  --auto-scaling-group-names student-7-9-nginx-asg student-7-9-tomcat-asg \
  --query 'AutoScalingGroups[*].[AutoScalingGroupName,DesiredCapacity,MinSize,MaxSize]' \
  --output table

# Vérifier les instances
aws ec2 describe-instances \
  --filters "Name=tag:Name,Values=student-7-9-*" \
  --query 'Reservations[*].Instances[*].[InstanceId,State.Name,PrivateIpAddress,Tags[?Key==`Name`].Value|[0]]' \
  --output table
```

## 🧹 **Nettoyage**

**Ordre inverse du déploiement !**

```bash
# 1. Détruire les ASG (Student Y)
cd LAB5-6/ec2
terraform destroy

# 2. Détruire le réseau (Student X)
cd ../network
terraform destroy
```

## ✅ **Checklist Complète**

### **Student X**
- [ ] Backend S3 network.tfstate configuré
- [ ] 3 Subnets créés (CIDRs corrects)
- [ ] 2 Security Groups créés
- [ ] 2 Target Groups créés
- [ ] ALB créé avec listener et rules
- [ ] Outputs affichés et partagés

### **Student Y**
- [ ] Backend S3 ec2.tfstate configuré
- [ ] Module ASG créé et testé
- [ ] Datasources récupèrent ressources X
- [ ] AMI Bitnami nginx trouvée
- [ ] AMI Bitnami tomcat trouvée
- [ ] 2 ASG créés (nginx + tomcat)
- [ ] 4 instances lancées et healthy

### **Tests**
- [ ] `curl http://<ALB>/nginx` fonctionne
- [ ] `curl http://<ALB>/tomcat` fonctionne
- [ ] `curl http://<ALB>/` retourne 404
- [ ] Health checks passent
- [ ] Instances dans target groups

---

## 💡 **Points Clés**

### **Séparation des States**
- ✅ Réseau et EC2 indépendants
- ✅ Pas de conflit lors des modifications
- ✅ Workflow collaboratif possible

### **Datasources**
- ✅ Student Y récupère dynamiquement les ressources de X
- ✅ Pas de hardcoding d'IDs
- ✅ Flexibilité et réutilisabilité

### **Module ASG**
- ✅ Réutilisable pour nginx ET tomcat
- ✅ Configurable (AMI, taille, subnets, SG, TG)
- ✅ Best practice Terraform

---

**LAB 5-6 Complete Infrastructure! 🎉**

**Student X (7)** : Network ✅
**Student Y (9)** : EC2 ✅
