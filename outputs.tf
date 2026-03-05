output "amplify_app_id" {
  description = "The unique ID of the Amplify application"
  value       = aws_amplify_app.frontend.id
}

output "amplify_default_domain" {
  description = "Default Amplify domain for the main branch"
  value       = "https://main.${aws_amplify_app.frontend.default_domain}"
}

output "amplify_console_url" {
  description = "Direct link to the app in the AWS Amplify console"
  value       = "https://us-east-1.console.aws.amazon.com/amplify/home#/${aws_amplify_app.frontend.id}"
}
