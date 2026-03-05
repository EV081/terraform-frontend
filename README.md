# terraform-frontend

Despliega [taller-serverless-frontend](https://github.com/EV081/taller-serverless-frontend) en **AWS Amplify** usando Terraform.

## Requisitos previos

| Requisito | Versión |
|---|---|
| Terraform | ≥ 1.3 |
| AWS CLI | configurado con credenciales de AWS Academy |
| Región | `us-east-1` |

## Inicio rápido

```bash
# 1. Inicializar (descarga el proveedor de AWS)
terraform init

# 2. Ver los cambios antes de aplicar
terraform plan

# 3. Desplegar
terraform apply
```

Cuando `apply` termine (~1-2 min para crear los recursos), Amplify clonará el repositorio y ejecutará la build automáticamente.  
La build tarda ~3-5 minutos. La URL final aparece en el output `amplify_default_domain`.

## Archivos

| Archivo | Propósito |
|---|---|
| `main.tf` | Recursos de la app y rama en Amplify |
| `variables.tf` | Definición de todas las variables de entrada |
| `terraform.tfvars` | Valores reales (URLs de APIs, ARN del LabRole) |
| `outputs.tf` | URL de la app y enlace a la consola |

## Actualizar las URLs de las APIs

Edita `terraform.tfvars` y cambia el valor de cualquier `api_*_url`, luego ejecuta:

```bash
terraform apply
```

Amplify reconstruirá el frontend automáticamente con las nuevas variables de entorno.

## Eliminar los recursos

```bash
terraform destroy
```