# devopsb-giropops-terraform
Módulo terraform

# Para utilizar
## 1. Crie as pasta `terraform` e `scripts` no seu repositório.

Em scripts adicione o script para inicialização do servidor.

Na pasta terraform crie os arquivos `main.tf` e `provider.tf`

```bash
mkdir terraform scripts
```

```bash
vi scripts/user_data.sh
```

## 2. Configure os arquivos terraform. 

```bash
vi terraform/main.tf
```
```bash
module "infra" {
  source = "git::https://github.com/jhhenriquee/devopsb-giropops-terraform.git?ref=v1.0.0"

  project_name           = "giropops"
  aws_region             = "us-east-1"
  instance_type          = "t2.micro"
  user_data_file         = "${path.module}/../scripts/user_data.sh"
  ubuntu_ami_name_filter = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
  allowed_cidrs          = ["189.6.211.137/32"]
  public_key             = ""
}

output "instance_public_ip" {
  value = module.infra.instance_ip
}
```
```bash
vi terraform/provider.tf
```
```bash
terraform {
  backend "s3" {
    bucket = "descomplicando-terraform-devopze2025"
    key    = "statefiles/devopsb-project/terraform.tfstate"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.84.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
```

## 3. Crie a infra

```bash
cd terraform
```

```bash
terraform init
```

```bash
terraform plan -out 1.plan
```

```bash
terraform apply "1.plan"
```

```bash
terraform destroy
```