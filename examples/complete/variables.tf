variable "region" {
  description = "The Alibaba Cloud region to deploy resources in."
  type        = string
  default     = "cn-hangzhou"
}

variable "queue_name" {
  description = "The name of the Message Service queue."
  type        = string
  default     = "example-queue"
}

variable "topic_name" {
  description = "The name of the Message Service topic."
  type        = string
  default     = "example-topic"
}

variable "subscription_name" {
  description = "The name of the Message Service subscription."
  type        = string
  default     = "example-subscription"
}

variable "event_rule_name" {
  description = "The name of the Message Service event rule."
  type        = string
  default     = "example-event-rule"
}

variable "common_tags" {
  description = "Common tags to be applied to all resources."
  type        = map(string)
  default = {
    Environment = "example"
    Project     = "message-service-demo"
  }
}