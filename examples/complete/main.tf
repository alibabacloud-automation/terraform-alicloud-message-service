provider "alicloud" {
  region = var.region
}

# Get current account information
data "alicloud_account" "current" {}

# Module usage example
module "message_service" {
  source = "../../"

  # Service activation
  create_service = true

  # Endpoint configuration
  create_endpoint = true
  endpoint_config = {
    endpoint_enabled = true
    endpoint_type    = "public"
  }

  # Endpoint ACL configuration
  create_endpoint_acl = true
  endpoint_acl_configs = {
    "allow_all" = {
      cidr          = "0.0.0.0/0"
      endpoint_type = "public"
      acl_strategy  = "allow"
    }
  }

  # Queue configuration
  create_queues = true
  queue_configs = {
    "example_queue" = {
      queue_name               = var.queue_name
      delay_seconds            = 2
      polling_wait_seconds     = 2
      message_retention_period = 345600
      maximum_message_size     = 65536
      visibility_timeout       = 30
      logging_enabled          = true
    }
  }

  # Topic configuration
  create_topics = true
  topic_configs = {
    "example_topic" = {
      topic_name       = var.topic_name
      max_message_size = 65536
      enable_logging   = true
    }
  }

  # Subscription configuration
  create_subscriptions = true
  subscription_configs = {
    "example_subscription" = {
      topic_name            = var.topic_name
      subscription_name     = var.subscription_name
      endpoint              = format("acs:mns:%s:%s:/queues/%s", var.region, data.alicloud_account.current.id, var.queue_name)
      push_type             = "queue"
      filter_tag            = "important"
      notify_content_format = "SIMPLIFIED"
      notify_strategy       = "BACKOFF_RETRY"
    }
  }

  # Event rule configuration
  create_event_rules = true
  event_rule_configs = {
    "example_event_rule" = {
      rule_name   = var.event_rule_name
      event_types = ["ObjectCreated:PutObject"]
      endpoint = {
        endpoint_type  = "topic"
        endpoint_value = var.topic_name
      }
      match_rules = [
        [
          {
            name        = var.topic_name
            match_state = "true"
            prefix      = "logs/"
            suffix      = ".log"
          }
        ]
      ]
    }
  }

  # Common tags
  common_tags = var.common_tags
}