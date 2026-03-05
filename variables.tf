# ---------------------------------------------------------------------------
# General
# ---------------------------------------------------------------------------
variable "app_name" {
  description = "Name of the Amplify application"
  type        = string
  default     = "taller-serverless-frontend"
}

variable "github_repo" {
  description = "HTTPS URL of the GitHub repository to connect to Amplify"
  type        = string
  default     = "https://github.com/EV081/taller-serverless-frontend"
}

variable "lab_role_arn" {
  description = "ARN of the pre-existing LabRole IAM role (AWS Academy)"
  type        = string
}

# ---------------------------------------------------------------------------
# API Gateway URLs (VITE_ environment variables)
# ---------------------------------------------------------------------------
variable "api_user_url" {
  description = "Base URL for the Users API"
  type        = string
}

variable "api_producto_url" {
  description = "Base URL for the Products API"
  type        = string
}

variable "api_order_url" {
  description = "Base URL for the Orders API"
  type        = string
}

variable "api_cocina_url" {
  description = "Base URL for the Kitchen API"
  type        = string
}

variable "api_delivery_url" {
  description = "Base URL for the Delivery API"
  type        = string
}

variable "api_work_url" {
  description = "Base URL for the Work API"
  type        = string
}
