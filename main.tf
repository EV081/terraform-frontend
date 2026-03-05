terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# AWS Amplify App
resource "aws_amplify_app" "frontend" {
  name         = var.app_name
  repository   = var.github_repo
  access_token = var.github_token

  # IAM service role
  iam_service_role_arn = var.lab_role_arn

  # Build specification for a Vite/React project (requires Node 20+ for Vite 7)
  build_spec = <<-EOT
    version: 1
    frontend:
      phases:
        preBuild:
          commands:
            - nvm install 20
            - nvm use 20
            - node --version
            - npm ci
        build:
          commands:
            - npm run build
      artifacts:
        baseDirectory: dist
        files:
          - '**/*'
      cache:
        paths:
          - node_modules/**/*
  EOT

  # Environment variables
  environment_variables = {
    NODE_VERSION          = "20"
    VITE_API_USER_URL     = var.api_user_url
    VITE_API_PRODUCTO_URL = var.api_producto_url
    VITE_API_ORDER_URL    = var.api_order_url
    VITE_API_COCINA_URL   = var.api_cocina_url
    VITE_API_DELIVERY_URL = var.api_delivery_url
    VITE_API_WORK_URL     = var.api_work_url
  }

  # Disable basic auth (public app)
  enable_basic_auth = false

  # Auto branch creation is disabled
  enable_branch_auto_build    = true
  enable_branch_auto_deletion = true
}

# Amplify Branch
resource "aws_amplify_branch" "main" {
  app_id      = aws_amplify_app.frontend.id
  branch_name = "main"

  # Stage tells Amplify this is a production branch
  stage = "PRODUCTION"

  enable_auto_build = true
}

# ---------------------------------------------------------------------------
# Dispara el primer build automáticamente al hacer terraform apply
# ---------------------------------------------------------------------------
resource "null_resource" "trigger_build" {
  # Se vuelve a ejecutar si cambia el app_id o la rama
  triggers = {
    app_id      = aws_amplify_app.frontend.id
    branch_name = aws_amplify_branch.main.branch_name
  }

  depends_on = [aws_amplify_branch.main]

  provisioner "local-exec" {
    command = "aws amplify start-job --app-id ${aws_amplify_app.frontend.id} --branch-name main --job-type RELEASE --region us-east-1"
  }
}
