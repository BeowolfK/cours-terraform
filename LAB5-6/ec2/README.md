# LAB 5-6 : Student Y (9) - Auto Scaling Groups

Configuration ASG pour Student Y (9) travaillant avec Student X (7).

## 📦 **Ressources Créées**

### **Module ASG Réutilisable**
Module configurable permettant de créer des ASG avec :
- AMI personnalisable
- Taille min/max configurable
- Subnets multiples
- Security groups
- Target groups

### **2 Auto Scaling Groups**

**Nginx ASG** (`student-7-9-nginx-asg`)
- AMI : Bitnami Nginx (récupérée dynamiquement)
- Instance type : t3.micro
- Min : 2, Max : 4, Desired : 2
- Subnet : Private (student_7_9_Private)
- Security Group : Internal (student_7_9_internal)
- Target Group : student-7-9-nginx-tg

**Tomcat ASG** (`student-7-9-tomcat-asg`)
- AMI : Bitnami Tomcat (récupérée dynamiquement)
- Instance type : t3.micro
- Min : 2, Max : 4, Desired : 2
- Subnet : Private (student_7_9_Private)
- Security Group : Internal (student_7_9_internal)
- Target Group : student-7-9-tomcat-tg

## 🔗 **Dépendances (Student X)**

Ce code **NÉCESSITE** que Student X ait déployé :
- ✅ Subnet privé (`student_7_9_Private`)
- ✅ Security Group internal (`student_7_9_internal`)
- ✅ Target Groups nginx et tomcat
- ✅ Application Load Balancer

## 🚀 **Déploiement**

### **Prérequis**
Student X doit avoir déployé son infrastructure réseau d'abord !

### **Commandes**

```bash
cd /Users/kenan/Documents/IMT/IaC/LAB5-6/ec2

# 1. Initialiser
terraform init

# 2. Vérifier le plan
terraform plan

# 3. Déployer les ASG
terraform apply
```

## 📊 **Outputs**

```
nginx_asg_name     = "student-7-9-nginx-asg"
nginx_asg_id       = "asg-xxxxx"
nginx_ami_name     = "bitnami-nginx-1.25.x..."

tomcat_asg_name    = "student-7-9-tomcat-asg"
tomcat_asg_id      = "asg-yyyyy"
tomcat_ami_name    = "bitnami-tomcat-10.x..."

private_subnet_id  = "subnet-xxxxx"
internal_sg_id     = "sg-xxxxx"
```

## 🧪 **Tests**

### **1. Vérifier que les ASG sont créés**

```bash
# Voir les outputs
terraform output

# Lister les instances nginx
aws autoscaling describe-auto-scaling-groups \
  --auto-scaling-group-names student-7-9-nginx-asg \
  --query 'AutoScalingGroups[*].Instances[*].[InstanceId,HealthStatus]' \
  --output table

# Lister les instances tomcat
aws autoscaling describe-auto-scaling-groups \
  --auto-scaling-group-names student-7-9-tomcat-asg \
  --query 'AutoScalingGroups[*].Instances[*].[InstanceId,HealthStatus]' \
  --output table
```

### **2. Tester l'ALB (créé par Student X)**

```bash
# Récupérer le DNS de l'ALB depuis Student X
cd ../network
ALB_DNS=$(terraform output -raw alb_dns_name)

# Tester nginx (devrait retourner la page Bitnami Nginx)
curl http://$ALB_DNS/nginx

# Tester tomcat (devrait retourner la page Bitnami Tomcat)
curl http://$ALB_DNS/tomcat

# Dans le navigateur
open "http://$ALB_DNS/nginx"
open "http://$ALB_DNS/tomcat"
```

### **3. Vérifier le health check**

```bash
# Voir l'état des target groups
aws elbv2 describe-target-health \
  --target-group-arn $(terraform output -raw nginx_tg_arn)

aws elbv2 describe-target-health \
  --target-group-arn $(terraform output -raw tomcat_tg_arn)
```

## 📝 **State S3**

- **Bucket** : `terraform-state-agvq0`
- **Key** : `global/s3/student_7_9/ec2.tfstate`
- **DynamoDB** : `terraform-up-and-running-locks`

## 🏗️ **Structure**

```
ec2/
├── backend.tf           # Backend S3 (ec2.tfstate)
├── provider.tf          # Provider AWS
├── datasources.tf       # Récupère ressources de Student X + AMI
├── main.tf             # Instances des modules (nginx + tomcat)
├── outputs.tf          # Outputs des ASG
├── modules/
│   └── asg/            # Module ASG réutilisable
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── README.md
```

## 🔄 **Workflow Complet (Student X + Y)**

1. **Student X déploie le réseau**
   ```bash
   cd LAB5-6/network
   terraform init
   terraform apply
   ```

2. **Student Y déploie les ASG**
   ```bash
   cd LAB5-6/ec2
   terraform init
   terraform apply
   ```

3. **Test final**
   ```bash
   curl http://<ALB_DNS>/nginx
   curl http://<ALB_DNS>/tomcat
   ```

## ✅ **Checklist**

- [ ] Infrastructure réseau de Student X déployée
- [ ] Datasources récupèrent correctement les ressources
- [ ] AMI Bitnami nginx et tomcat trouvées
- [ ] 2 ASG créés (nginx et tomcat)
- [ ] 4 instances EC2 lancées (2+2)
- [ ] Instances attachées aux target groups
- [ ] Health checks passent (healthy)
- [ ] ALB route correctement vers nginx et tomcat

---

**Student Y (9) - EC2 Infrastructure Ready! 🎉**
