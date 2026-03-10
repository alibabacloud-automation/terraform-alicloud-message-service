variable "create_service" {
  description = "Whether to create Message Service activation."
  type        = bool
  default     = true
}

variable "create_endpoint" {
  description = "Whether to create Message Service endpoint."
  type        = bool
  default     = true
}

variable "endpoint_config" {
  description = "Configuration for Message Service endpoint."
  type = object({
    endpoint_enabled = bool
    endpoint_type    = string
  })
  default = {
    endpoint_enabled = true
    endpoint_type    = "public"
  }
}

variable "create_endpoint_acl" {
  description = "Whether to create Message Service endpoint ACL rules."
  type        = bool
  default     = false
}

variable "endpoint_acl_configs" {
  description = "Map of endpoint ACL configurations."
  type = map(object({
    cidr          = string
    endpoint_type = string
    acl_strategy  = string
  }))
  default = {}
}

variable "create_queues" {
  description = "Whether to create Message Service queues."
  type        = bool
  default     = false
}

variable "queue_configs" {
  description = "Map of queue configurations."
  type = map(object({
    queue_name               = string
    delay_seconds            = optional(number, 0)
    polling_wait_seconds     = optional(number, 0)
    message_retention_period = optional(number, 345600)
    maximum_message_size     = optional(number, 65536)
    visibility_timeout       = optional(number, 30)
    logging_enabled          = optional(bool, false)
    dlq_policy = optional(object({
      dead_letter_target_queue = string
      enabled                  = bool
      max_receive_count        = number
    }), null)
  }))
  default = {}
}

variable "create_topics" {
  description = "Whether to create Message Service topics."
  type        = bool
  default     = false
}

variable "topic_configs" {
  description = "Map of topic configurations."
  type = map(object({
    topic_name       = string
    max_message_size = optional(number, 65536)
    enable_logging   = optional(bool, false)
  }))
  default = {}
}

variable "create_subscriptions" {
  description = "Whether to create Message Service subscriptions."
  type        = bool
  default     = false
}

variable "subscription_configs" {
  description = "Map of subscription configurations."
  type = map(object({
    topic_name            = string
    subscription_name     = string
    endpoint              = string
    push_type             = string
    filter_tag            = optional(string, null)
    notify_content_format = optional(string, "XML")
    notify_strategy       = optional(string, "BACKOFF_RETRY")
    sts_role_arn          = optional(string, null)
    dlq_policy = optional(object({
      dead_letter_target_queue = string
      enabled                  = bool
    }), null)
  }))
  default = {}
}

variable "create_event_rules" {
  description = "Whether to create Message Service event rules."
  type        = bool
  default     = false
}

variable "event_rule_configs" {
  description = "Map of event rule configurations."
  type = map(object({
    rule_name     = string
    event_types   = list(string)
    delivery_mode = optional(string, null)
    endpoint = optional(object({
      endpoint_type  = string
      endpoint_value = string
    }), null)
    match_rules = optional(list(list(object({
      name        = string
      match_state = string
      prefix      = optional(string, null)
      suffix      = optional(string, null)
    }))), null)
  }))
  default = {}
}

variable "common_tags" {
  description = "Common tags to be applied to all resources."
  type        = map(string)
}