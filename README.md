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


- source: informe a url com a versão do módulo que deseja usar.
- user_data_file: informe o caminho para o user_data.sh. Geralmente  ../scripts/user_data.sh.
- aws_region: região aws onde será levantada a infra.
- instance_type: tipo de instancia necessária para a aplicação.
- ubuntu_ami_name_filter: informe qual SO deseja usar, o módulo usará o mais recente das amis da canonical.
- public_key: chave pública ssh para acessar o ec2. Não informar caso não deseja acessar o ec2 por ssh. (caso queira acessar lembre-se de liberar a 22 em extra_in_allowports e informe seu ip publico em allowed_cidrs)
- allow_ingress: informe lista de quais portas serão liberadas para um determinado ip. A forma de declarção está exemplificada abaixo.
O output informará o ip público após finalização do apply. O default libera tudo pra 80 e 443.

```bash
vi terraform/main.tf
```

Acredito que deixando tudo como está já funcionaria, altere apenas a public_key e informe seu ip publico em cidr_block.

```bash
module "infra" {
  source = "git::https://github.com/jhhenriquee/devopsb-giropops-terraform.git?ref=v2.0.0"

  project_name           = "giropops"
  aws_region             = "us-east-1"
  instance_type          = "t2.micro"
  user_data_file         = "${path.module}/../scripts/user_data.sh"
  ubuntu_ami_name_filter = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
  public_key             = "ssh-rsa ..."

  allow_ingress = {
    http = {
      port       = 80
      cidr_block = "0.0.0.0/0"
    },
    https = {
      port       = 443
      cidr_block = "0.0.0.0/0"
    },
    flask = {
      port       = 5000
      cidr_block = "0.0.0.0/32"
    },
    ssh = {
      port       = 22
      cidr_block = "0.0.0.0/32"
    }
  }
 }

output "instance_public_ip" {
  value = module.infra.instance_ip
}
```

```bash
vi terraform/provider.tf
```
Acredito que deixando tudo como está já funcionaria, informe apenas o seu bucket onde deseja salvar o state.
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

É necessário ter terraform instalado e as credenciais da aws configuradas.

Para configurar credenciais através de variáveis:

BASH:
- export AWS_SECRET_ACCESS_KEY=""
- export AWS_ACCESS_KEY_ID=""

POWERSHELL:
- $env:AWS_ACCESS_KEY_ID=""
- $env:AWS_SECRET_ACCESS_KEY=""

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