# Message Service outputs
output "service_id" {
  description = "The ID of the Message Service."
  value       = var.create_service ? concat(alicloud_message_service_service.service[*].id, [""])[0] : null
}

output "service_status" {
  description = "The status of the Message Service."
  value       = var.create_service ? concat(alicloud_message_service_service.service[*].status, [""])[0] : null
}

# Endpoint outputs
output "endpoint_id" {
  description = "The ID of the Message Service endpoint."
  value       = var.create_endpoint ? concat(alicloud_message_service_endpoint.endpoint[*].id, [""])[0] : null
}

# Endpoint ACL outputs
output "endpoint_acl_ids" {
  description = "The IDs of the Message Service endpoint ACL rules."
  value       = var.create_endpoint_acl ? values(alicloud_message_service_endpoint_acl.endpoint_acl)[*].id : []
}

# Queue outputs
output "queue_ids" {
  description = "The IDs of the Message Service queues."
  value       = var.create_queues ? values(alicloud_message_service_queue.queues)[*].id : []
}

output "queue_names" {
  description = "The names of the Message Service queues."
  value       = var.create_queues ? values(alicloud_message_service_queue.queues)[*].queue_name : []
}

output "queue_create_times" {
  description = "The creation times of the Message Service queues."
  value       = var.create_queues ? values(alicloud_message_service_queue.queues)[*].create_time : []
}

# Topic outputs
output "topic_ids" {
  description = "The IDs of the Message Service topics."
  value       = var.create_topics ? values(alicloud_message_service_topic.topics)[*].id : []
}

output "topic_names" {
  description = "The names of the Message Service topics."
  value       = var.create_topics ? values(alicloud_message_service_topic.topics)[*].topic_name : []
}

output "topic_create_times" {
  description = "The creation times of the Message Service topics."
  value       = var.create_topics ? values(alicloud_message_service_topic.topics)[*].create_time : []
}

# Subscription outputs
output "subscription_ids" {
  description = "The IDs of the Message Service subscriptions."
  value       = var.create_subscriptions ? values(alicloud_message_service_subscription.subscriptions)[*].id : []
}

output "subscription_names" {
  description = "The names of the Message Service subscriptions."
  value       = var.create_subscriptions ? [for sub in values(alicloud_message_service_subscription.subscriptions) : sub.subscription_name] : []
}

output "subscription_create_times" {
  description = "The creation times of the Message Service subscriptions."
  value       = var.create_subscriptions ? values(alicloud_message_service_subscription.subscriptions)[*].create_time : []
}

# Event rule outputs
output "event_rule_ids" {
  description = "The IDs of the Message Service event rules."
  value       = var.create_event_rules ? values(alicloud_message_service_event_rule.event_rules)[*].id : []
}

output "event_rule_names" {
  description = "The names of the Message Service event rules."
  value       = var.create_event_rules ? [for rule in values(alicloud_message_service_event_rule.event_rules) : rule.rule_name] : []
}

# Combined outputs for convenience
output "all_queue_info" {
  description = "Combined information of all Message Service queues."
  value = var.create_queues ? {
    for k, v in alicloud_message_service_queue.queues : k => {
      id          = v.id
      name        = v.queue_name
      create_time = v.create_time
    }
  } : {}
}

output "all_topic_info" {
  description = "Combined information of all Message Service topics."
  value = var.create_topics ? {
    for k, v in alicloud_message_service_topic.topics : k => {
      id          = v.id
      name        = v.topic_name
      create_time = v.create_time
    }
  } : {}
}

output "all_subscription_info" {
  description = "Combined information of all Message Service subscriptions."
  value = var.create_subscriptions ? {
    for k, v in alicloud_message_service_subscription.subscriptions : k => {
      id          = v.id
      name        = v.subscription_name
      create_time = v.create_time
    }
  } : {}
}