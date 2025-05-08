variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "prod"  # or "shared" for shared services
}

variable "vpc_id" {
  description = "VPC ID where the container service will run"
  type        = string
  default     = "default"  # Replace with your actual VPC ID
}

variable "desired_count" {
  description = "Number of instances of the task to run"
  type        = number
  default     = 1
}

variable "service_launch_type" {
  description = "Launch type for the ECS service (FARGATE or EC2)"
  type        = string
  default     = "FARGATE"
}

variable "subnet_ids" {
  description = "List of subnet IDs for the ECS service"
  type        = list(string)
}

variable "assign_public_ip" {
  description = "Assign public IP to the task"
  type        = bool
  default     = false
}

variable "container_image" {
  description = "Container image to deploy"
  type        = string
  default     = "carrumhealth/helloworld:stable"
}

variable "container_definitions" {
  description = "List of container definitions for the ECS task"
  type = list(object({
    name           = string
    image          = string
    cpu           = number
    memory        = number
    essential     = bool
    portMappings  = list(object({
      containerPort = number
      hostPort     = number
    }))
  }))
  default = [{
    name           = "app"
    image          = "carrumhealth/helloworld:stable"
    cpu            = 10
    memory         = 512
    essential      = true
    portMappings   = [{
      containerPort = 80
      hostPort      = 80
    }]
  }]
}

variable "network_mode" {
  description = "Network mode for ECS tasks. Valid values: awsvpc, bridge, host, none"
  type        = string
  default     = "awsvpc"
}

variable "launch_type" {
  description = "Launch type for ECS tasks. Valid values: FARGATE, EC2"
  type        = list(string)
  default     = ["FARGATE"]
}

variable "task_cpu" {
  description = "CPU units for the ECS task (256 = .25 vCPU)"
  type        = string
  default     = "256"
}

variable "task_memory" {
  description = "Memory for the ECS task (in MiB)"
  type        = string
  default     = "512"
}

variable "cost_center" {
  type        = string
  description = "Cost center for billing purposes"
}

variable "owner" {
  type        = string
  description = "Team/Individual responsible for the resource"
}

