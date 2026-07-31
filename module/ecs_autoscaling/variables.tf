variable "app_name" {
  description = "The name of the application"
  type        = string
}

variable "env" {
  description = "The environment (e.g., dev, staging, prod)"
  type        = string
}

variable "min_capacity" {
  description = "The minimum number of ECS tasks"
  type        = number
}

variable "max_capacity" {
  description = "The maximum number of ECS tasks"
  type        = number
}

# 本番環境などではfalseにする想定
variable "enable_night_weekend_shutdown" {
  description = "Whether to enable night and weekend shutdown"
  type        = bool
  default     = false
}
