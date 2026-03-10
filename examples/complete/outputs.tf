# Message Service outputs
output "service_id" {
  description = "The ID of the Message Service."
  value       = module.message_service.service_id
}

output "service_status" {
  description = "The status of the Message Service."
  value       = module.message_service.service_status
}

# Endpoint outputs
output "endpoint_id" {
  description = "The ID of the Message Service endpoint."
  value       = module.message_service.endpoint_id
}

# Queue outputs
output "queue_ids" {
  description = "The IDs of the Message Service queues."
  value       = module.message_service.queue_ids
}

output "queue_names" {
  description = "The names of the Message Service queues."
  value       = module.message_service.queue_names
}

# Topic outputs
output "topic_ids" {
  description = "The IDs of the Message Service topics."
  value       = module.message_service.topic_ids
}

output "topic_names" {
  description = "The names of the Message Service topics."
  value       = module.message_service.topic_names
}

# Subscription outputs
output "subscription_ids" {
  description = "The IDs of the Message Service subscriptions."
  value       = module.message_service.subscription_ids
}

output "subscription_names" {
  description = "The names of the Message Service subscriptions."
  value       = module.message_service.subscription_names
}

# Event rule outputs
output "event_rule_ids" {
  description = "The IDs of the Message Service event rules."
  value       = module.message_service.event_rule_ids
}

output "event_rule_names" {
  description = "The names of the Message Service event rules."
  value       = module.message_service.event_rule_names
}

# Combined outputs
output "all_queue_info" {
  description = "Combined information of all Message Service queues."
  value       = module.message_service.all_queue_info
}

output "all_topic_info" {
  description = "Combined information of all Message Service topics."
  value       = module.message_service.all_topic_info
}

output "all_subscription_info" {
  description = "Combined information of all Message Service subscriptions."
  value       = module.message_service.all_subscription_info
}