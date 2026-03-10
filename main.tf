# Message Service activation
resource "alicloud_message_service_service" "service" {
  count = var.create_service ? 1 : 0
}

# Message Service endpoint
resource "alicloud_message_service_endpoint" "endpoint" {
  count = var.create_endpoint ? 1 : 0

  endpoint_enabled = var.endpoint_config.endpoint_enabled
  endpoint_type    = var.endpoint_config.endpoint_type

  depends_on = [alicloud_message_service_service.service]
}

# Message Service endpoint ACL rules
resource "alicloud_message_service_endpoint_acl" "endpoint_acl" {
  for_each = var.create_endpoint_acl ? var.endpoint_acl_configs : {}

  cidr          = each.value.cidr
  endpoint_type = each.value.endpoint_type
  acl_strategy  = each.value.acl_strategy

  depends_on = [alicloud_message_service_endpoint.endpoint]
}

# Message Service queues
resource "alicloud_message_service_queue" "queues" {
  for_each = var.create_queues ? var.queue_configs : {}

  queue_name               = each.value.queue_name
  delay_seconds            = each.value.delay_seconds
  polling_wait_seconds     = each.value.polling_wait_seconds
  message_retention_period = each.value.message_retention_period
  maximum_message_size     = each.value.maximum_message_size
  visibility_timeout       = each.value.visibility_timeout
  logging_enabled          = each.value.logging_enabled
  tags                     = var.common_tags

  dynamic "dlq_policy" {
    for_each = each.value.dlq_policy != null ? [each.value.dlq_policy] : []
    content {
      dead_letter_target_queue = dlq_policy.value.dead_letter_target_queue
      enabled                  = dlq_policy.value.enabled
      max_receive_count        = dlq_policy.value.max_receive_count
    }
  }

  depends_on = [alicloud_message_service_service.service]
}

# Message Service topics
resource "alicloud_message_service_topic" "topics" {
  for_each = var.create_topics ? var.topic_configs : {}

  topic_name       = each.value.topic_name
  max_message_size = each.value.max_message_size
  enable_logging   = each.value.enable_logging
  tags             = var.common_tags

  depends_on = [alicloud_message_service_service.service]
}

# Message Service subscriptions
resource "alicloud_message_service_subscription" "subscriptions" {
  for_each = var.create_subscriptions ? var.subscription_configs : {}

  topic_name            = each.value.topic_name
  subscription_name     = each.value.subscription_name
  endpoint              = each.value.endpoint
  push_type             = each.value.push_type
  filter_tag            = each.value.filter_tag
  notify_content_format = each.value.notify_content_format
  notify_strategy       = each.value.notify_strategy
  sts_role_arn          = each.value.sts_role_arn

  dynamic "dlq_policy" {
    for_each = each.value.dlq_policy != null ? [each.value.dlq_policy] : []
    content {
      dead_letter_target_queue = dlq_policy.value.dead_letter_target_queue
      enabled                  = dlq_policy.value.enabled
    }
  }

  depends_on = [
    alicloud_message_service_service.service,
    alicloud_message_service_topic.topics,
    alicloud_message_service_queue.queues
  ]
}

# Message Service event rules
resource "alicloud_message_service_event_rule" "event_rules" {
  for_each = var.create_event_rules ? var.event_rule_configs : {}

  rule_name     = each.value.rule_name
  event_types   = each.value.event_types
  delivery_mode = each.value.delivery_mode
  match_rules   = each.value.match_rules

  dynamic "endpoint" {
    for_each = each.value.endpoint != null ? [each.value.endpoint] : []
    content {
      endpoint_type  = endpoint.value.endpoint_type
      endpoint_value = endpoint.value.endpoint_value
    }
  }

  depends_on = [
    alicloud_message_service_service.service,
    alicloud_message_service_topic.topics
  ]
}