variable "prefix" {
  type        = string
  description = "string used to prefix resource names and identify the project a resource belongs to"
}
variable "environments" {
  type        = list(string)
  description = "A list of possible environments"
}

variable "output_dir" {
  type        = string
  description = "The directory to place the output files (backend.tf, environment.auto.tfvars, & env_vars.tf.json)"
}

variable "environment_configs_dir" {
  type        = string
  description = "The directory where ENV-environment.yaml files are stored"
  default     = "."
}

variable "variables" {
  type        = map(string)
  description = "A map of variable names and types (string formatted)"
  default     = {}
}

variable "approved_arns" {
  type = list(string)
}

variable "ENV" {
  type        = string
  description = "Environment name to setup backend for, typically set using TF_VAR_ENV"
  validation {
    condition     = contains(var.environments, var.ENV)
    error_message = "Please make sure ENV is one of the approved values: [\n${join(",\n", [for v in var.environments : "    ${v}"])}\n]"
  }
}

variable "force_destroy" {
  type    = bool
  default = false
}

variable "enable_dynamodb" {
  type    = bool
  default = true
}

output "role_arn" {
  value = local.role_arn
}

output "bucket" {
  value = local.bucket_name
}


