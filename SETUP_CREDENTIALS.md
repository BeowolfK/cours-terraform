# Configuration des Credentials AWS

Les fichiers `backend.tf` et `provider.tf` contenant les credentials ne sont **pas versionnés** dans Git pour des raisons de sécurité.

## 🔧 Configuration Initiale

Pour chaque dossier de TP/LAB, vous devez créer vos propres fichiers de configuration:

### Méthode 1: Copier les templates (Recommandé)

```bash
# LAB5-6 Network
cd LAB5-6/network
cp backend.tf.template backend.tf
cp provider.tf.template provider.tf
# Éditer les fichiers et remplacer VOTRE_ACCESS_KEY et VOTRE_SECRET_KEY

# LAB5-6 EC2
cd ../ec2
cp backend.tf.template backend.tf
cp provider.tf.template provider.tf
# Éditer les fichiers

# TP4
cd ../../TP4
cp backend.tf.template backend.tf
cp provider.tf.template provider.tf
# Éditer les fichiers

# TP3 et TP3.5
cd ../TP3
cp ../TP4/provider.tf.template provider.tf
# Éditer le fichier

cd ../TP3.5
cp ../TP4/provider.tf.template provider.tf
# Éditer le fichier
```

### Méthode 2: Variables d'environnement (Alternative)

Au lieu de mettre les credentials dans les fichiers, vous pouvez utiliser des variables d'environnement:

```bash
export AWS_ACCESS_KEY_ID="VOTRE_ACCESS_KEY"
export AWS_SECRET_ACCESS_KEY="VOTRE_SECRET_KEY"
export AWS_DEFAULT_REGION="eu-west-3"
```

Puis dans vos fichiers `provider.tf` et `backend.tf`, **ne mettez PAS** les lignes `access_key` et `secret_key`.

## ⚠️ IMPORTANT

- **Ne JAMAIS committer** les fichiers `backend.tf` et `provider.tf` avec vos vrais credentials
- Ces fichiers sont dans le `.gitignore` pour vous protéger
- Utilisez les templates (`.template`) comme référence

## 🎯 Vérification

```bash
# Vérifier que backend.tf et provider.tf ne sont pas trackés
git status

# backend.tf et provider.tf ne doivent PAS apparaître dans la liste
# Ils doivent rester "Untracked" (gris)
```
