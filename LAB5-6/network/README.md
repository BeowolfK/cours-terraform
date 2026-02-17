# LAB 5-6 : Student X (7) - Infrastructure Réseau

Configuration réseau pour Student X (7) travaillant avec Student Y (9).

## 📦 **Ressources Créées**

### **Subnets (3)**
- **Private** : `192.168.7.0/24` → `student_7_9_Private`
- **Public A** : `192.168.9.0/24` → `student_7_9_Public_a` (AZ 0)
- **Public B** : `192.168.109.0/24` → `student_7_9_Public_b` (AZ 1)

### **Security Groups (2)**
- **student_7_9_public** : HTTP/HTTPS depuis Internet
- **student_7_9_internal** : HTTP/HTTPS/8080 depuis SG public uniquement

### **Target Groups (2)**
- **student-7-9-nginx-tg** : Port 80, Health check "/"
- **student-7-9-tomcat-tg** : Port 8080, Health check "/"

### **Application Load Balancer**
- **Nom** : `student-7-9-alb`
- **Subnets** : Public A + Public B
- **Security Group** : Public SG
- **Listener** : Port 80
  - Default : 404 Fixed Response
  - Rule 1 : `/nginx*` → nginx target group
  - Rule 2 : `/tomcat*` → tomcat target group

## 🚀 **Déploiement**

```bash
cd /Users/kenan/Documents/IMT/IaC/LAB5-6/network

# Initialiser
terraform init

# Planifier
terraform plan

# Déployer
terraform apply
```

## 📊 **Outputs**

Après le déploiement, vous obtiendrez :

```
private_subnet_id    = subnet-xxxxx
public_subnet_a_id   = subnet-yyyyy
public_subnet_b_id   = subnet-zzzzz
public_sg_id         = sg-aaaaaa
internal_sg_id       = sg-bbbbbb
nginx_tg_arn         = arn:aws:...nginx-tg
tomcat_tg_arn        = arn:aws:...tomcat-tg
alb_dns_name         = student-7-9-alb-xxxxx.eu-west-3.elb.amazonaws.com
```

## 🔗 **Pour Student Y (9)**

Student Y utilisera vos outputs pour créer les ASG :
- **Private Subnet ID** : Pour déployer les instances
- **Internal SG ID** : Pour sécuriser les instances
- **Target Group ARNs** : Pour attacher les ASG

## 🧪 **Test de l'ALB**

Une fois les ASG de Student Y déployés :

```bash
# Récupérer le DNS de l'ALB
ALB_DNS=$(terraform output -raw alb_dns_name)

# Tester nginx
curl http://$ALB_DNS/nginx

# Tester tomcat
curl http://$ALB_DNS/tomcat

# Tester 404 (default)
curl http://$ALB_DNS/
```

## 📝 **State S3**

- **Bucket** : `terraform-state-agvq0`
- **Key** : `global/s3/student_7_9/network.tfstate`
- **DynamoDB** : `terraform-up-and-running-locks`

## ✅ **Checklist**

- [ ] VPC "Lab5-6" existe et est accessible
- [ ] 3 subnets créés avec bons CIDRs
- [ ] 2 security groups créés
- [ ] 2 target groups créés (vides au début)
- [ ] ALB créé avec listener et rules
- [ ] Outputs affichent toutes les infos
- [ ] State sauvegardé dans S3

---

**Student X (7) - Network Infrastructure Ready! 🎉**
