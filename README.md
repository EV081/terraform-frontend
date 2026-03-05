# terraform-frontend

Despliega [taller-serverless-frontend](https://github.com/EV081/taller-serverless-frontend) en **AWS Amplify** usando Terraform.

## Requisitos previos

| Requisito | Versión |
|---|---|
| Terraform | ≥ 1.3 |
| AWS CLI | configurado con credenciales de AWS Academy |
| Región | `us-east-1` |
| GitHub PAT | token con scope `repo` (ver sección más abajo) |

---

## GitHub Personal Access Token (PAT)

AWS Amplify necesita un token de GitHub para clonar el repositorio, **incluso si el repo es público**. Es una restricción de la API de AWS.

### Cómo crear tu token

**1.** Ve a [github.com/settings/tokens](https://github.com/settings/tokens)  
**2.** Haz clic en **Generate new token → Generate new token (classic)**  
**3.** Dale un nombre descriptivo, por ejemplo: `amplify-terraform`  
**4.** En **Expiration**, elige el tiempo que prefieras  
**5.** En **Select scopes**, marca únicamente **`repo`**  
**6.** Haz clic en **Generate token** y **copia el token** (solo se muestra una vez)

### Dónde pegarlo

Abre `terraform.tfvars` y reemplaza el valor de `github_token`:

```hcl
github_token = "ghp_tuTokenAqui"
```

---

## Configuración de variables

Antes de desplegar, copia el archivo de ejemplo y rellena los valores reales:

```bash
cp terraform.tfvars.example terraform.tfvars
```

Luego edita `terraform.tfvars` con tus datos:

| Variable | Descripción | Ejemplo |
|---|---|---|
| `app_name` | Nombre de la app en Amplify | `taller-serverless-frontend` |
| `github_repo` | URL HTTPS del repo de GitHub | `https://github.com/usuario/repo` |
| `github_token` | GitHub PAT con scope `repo` (ver sección anterior) | `ghp_xxxx...` |
| `api_user_url` | URL base de la API de Usuarios | `https://xxxx.execute-api.us-east-1.amazonaws.com/dev` |
| `api_producto_url` | URL base de la API de Productos | `https://xxxx.execute-api.us-east-1.amazonaws.com` |
| `api_order_url` | URL base de la API de Órdenes | `https://xxxx.execute-api.us-east-1.amazonaws.com/dev` |
| `api_cocina_url` | URL base de la API de Cocina | `https://xxxx.execute-api.us-east-1.amazonaws.com/dev` |
| `api_delivery_url` | URL base de la API de Delivery | `https://xxxx.execute-api.us-east-1.amazonaws.com/dev` |
| `api_work_url` | URL base de la API de Work | `https://xxxx.execute-api.us-east-1.amazonaws.com` |

> Las variables `VITE_API_*` se inyectan como variables de entorno en el build de Amplify, por lo que el frontend las lee en tiempo de compilación.

---



```bash
# 0. Instalar Terraform (si aún no lo tienes instalado)
sudo snap install terraform --classic

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