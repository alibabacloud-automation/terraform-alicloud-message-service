Alibaba Cloud Message Service Terraform Module

# terraform-alicloud-message-service

English | [简体中文](https://github.com/alibabacloud-automation/terraform-alicloud-message-service/blob/main/README-CN.md)

Terraform module which creates Message Service resources on Alibaba Cloud. This module provides a comprehensive solution for building reliable, scalable message queuing and pub/sub messaging systems. The [Alibaba Cloud Message Service](https://www.alibabacloud.com/product/message-service) enables asynchronous communication between distributed applications and services with high availability, durability, and security features.

## Usage

This module can be used to create a complete Message Service infrastructure including queues, topics, subscriptions, and event rules. You can configure the module to create only the resources you need by using the creation control variables.

```terraform
module "message_service" {
  source = "alibabacloud-automation/message-service/alicloud"

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
      queue_name               = "my-application-queue"
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
      topic_name       = "my-application-topic"
      max_message_size = 65536
      enable_logging   = true
    }
  }

  # Subscription configuration
  create_subscriptions = true
  subscription_configs = {
    "example_subscription" = {
      topic_name            = "my-application-topic"
      subscription_name     = "my-subscription"
      endpoint              = "acs:mns:cn-hangzhou:123456789:/queues/my-application-queue"
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
      rule_name   = "my-event-rule"
      event_types = ["ObjectCreated:PutObject"]
      endpoint = {
        endpoint_type  = "topic"
        endpoint_value = "my-application-topic"
      }
      match_rules = [
        [
          {
            name        = "my-application-topic"
            match_state = "true"
            prefix      = "logs/"
            suffix      = ".log"
          }
        ]
      ]
    }
  }

  # Common tags
  common_tags = {
    Environment = "production"
    Project     = "my-application"
  }
}
```

## Examples

* [Complete Example](https://github.com/alibabacloud-automation/terraform-alicloud-message-service/tree/main/examples/complete)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.188.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | >= 1.188.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_message_service_endpoint.endpoint](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/message_service_endpoint) | resource |
| [alicloud_message_service_endpoint_acl.endpoint_acl](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/message_service_endpoint_acl) | resource |
| [alicloud_message_service_event_rule.event_rules](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/message_service_event_rule) | resource |
| [alicloud_message_service_queue.queues](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/message_service_queue) | resource |
| [alicloud_message_service_service.service](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/message_service_service) | resource |
| [alicloud_message_service_subscription.subscriptions](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/message_service_subscription) | resource |
| [alicloud_message_service_topic.topics](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/message_service_topic) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | Common tags to be applied to all resources. | `map(string)` | n/a | yes |
| <a name="input_create_endpoint"></a> [create\_endpoint](#input\_create\_endpoint) | Whether to create Message Service endpoint. | `bool` | `true` | no |
| <a name="input_create_endpoint_acl"></a> [create\_endpoint\_acl](#input\_create\_endpoint\_acl) | Whether to create Message Service endpoint ACL rules. | `bool` | `false` | no |
| <a name="input_create_event_rules"></a> [create\_event\_rules](#input\_create\_event\_rules) | Whether to create Message Service event rules. | `bool` | `false` | no |
| <a name="input_create_queues"></a> [create\_queues](#input\_create\_queues) | Whether to create Message Service queues. | `bool` | `false` | no |
| <a name="input_create_service"></a> [create\_service](#input\_create\_service) | Whether to create Message Service activation. | `bool` | `true` | no |
| <a name="input_create_subscriptions"></a> [create\_subscriptions](#input\_create\_subscriptions) | Whether to create Message Service subscriptions. | `bool` | `false` | no |
| <a name="input_create_topics"></a> [create\_topics](#input\_create\_topics) | Whether to create Message Service topics. | `bool` | `false` | no |
| <a name="input_endpoint_acl_configs"></a> [endpoint\_acl\_configs](#input\_endpoint\_acl\_configs) | Map of endpoint ACL configurations. | <pre>map(object({<br/>    cidr          = string<br/>    endpoint_type = string<br/>    acl_strategy  = string<br/>  }))</pre> | `{}` | no |
| <a name="input_endpoint_config"></a> [endpoint\_config](#input\_endpoint\_config) | Configuration for Message Service endpoint. | <pre>object({<br/>    endpoint_enabled = bool<br/>    endpoint_type    = string<br/>  })</pre> | <pre>{<br/>  "endpoint_enabled": true,<br/>  "endpoint_type": "public"<br/>}</pre> | no |
| <a name="input_event_rule_configs"></a> [event\_rule\_configs](#input\_event\_rule\_configs) | Map of event rule configurations. | <pre>map(object({<br/>    rule_name     = string<br/>    event_types   = list(string)<br/>    delivery_mode = optional(string, null)<br/>    endpoint = optional(object({<br/>      endpoint_type  = string<br/>      endpoint_value = string<br/>    }), null)<br/>    match_rules = optional(list(list(object({<br/>      name        = string<br/>      match_state = string<br/>      prefix      = optional(string, null)<br/>      suffix      = optional(string, null)<br/>    }))), null)<br/>  }))</pre> | `{}` | no |
| <a name="input_queue_configs"></a> [queue\_configs](#input\_queue\_configs) | Map of queue configurations. | <pre>map(object({<br/>    queue_name               = string<br/>    delay_seconds            = optional(number, 0)<br/>    polling_wait_seconds     = optional(number, 0)<br/>    message_retention_period = optional(number, 345600)<br/>    maximum_message_size     = optional(number, 65536)<br/>    visibility_timeout       = optional(number, 30)<br/>    logging_enabled          = optional(bool, false)<br/>    dlq_policy = optional(object({<br/>      dead_letter_target_queue = string<br/>      enabled                  = bool<br/>      max_receive_count        = number<br/>    }), null)<br/>  }))</pre> | `{}` | no |
| <a name="input_subscription_configs"></a> [subscription\_configs](#input\_subscription\_configs) | Map of subscription configurations. | <pre>map(object({<br/>    topic_name            = string<br/>    subscription_name     = string<br/>    endpoint              = string<br/>    push_type             = string<br/>    filter_tag            = optional(string, null)<br/>    notify_content_format = optional(string, "XML")<br/>    notify_strategy       = optional(string, "BACKOFF_RETRY")<br/>    sts_role_arn          = optional(string, null)<br/>    dlq_policy = optional(object({<br/>      dead_letter_target_queue = string<br/>      enabled                  = bool<br/>    }), null)<br/>  }))</pre> | `{}` | no |
| <a name="input_topic_configs"></a> [topic\_configs](#input\_topic\_configs) | Map of topic configurations. | <pre>map(object({<br/>    topic_name       = string<br/>    max_message_size = optional(number, 65536)<br/>    enable_logging   = optional(bool, false)<br/>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_all_queue_info"></a> [all\_queue\_info](#output\_all\_queue\_info) | Combined information of all Message Service queues. |
| <a name="output_all_subscription_info"></a> [all\_subscription\_info](#output\_all\_subscription\_info) | Combined information of all Message Service subscriptions. |
| <a name="output_all_topic_info"></a> [all\_topic\_info](#output\_all\_topic\_info) | Combined information of all Message Service topics. |
| <a name="output_endpoint_acl_ids"></a> [endpoint\_acl\_ids](#output\_endpoint\_acl\_ids) | The IDs of the Message Service endpoint ACL rules. |
| <a name="output_endpoint_id"></a> [endpoint\_id](#output\_endpoint\_id) | The ID of the Message Service endpoint. |
| <a name="output_event_rule_ids"></a> [event\_rule\_ids](#output\_event\_rule\_ids) | The IDs of the Message Service event rules. |
| <a name="output_event_rule_names"></a> [event\_rule\_names](#output\_event\_rule\_names) | The names of the Message Service event rules. |
| <a name="output_queue_create_times"></a> [queue\_create\_times](#output\_queue\_create\_times) | The creation times of the Message Service queues. |
| <a name="output_queue_ids"></a> [queue\_ids](#output\_queue\_ids) | The IDs of the Message Service queues. |
| <a name="output_queue_names"></a> [queue\_names](#output\_queue\_names) | The names of the Message Service queues. |
| <a name="output_service_id"></a> [service\_id](#output\_service\_id) | The ID of the Message Service. |
| <a name="output_service_status"></a> [service\_status](#output\_service\_status) | The status of the Message Service. |
| <a name="output_subscription_create_times"></a> [subscription\_create\_times](#output\_subscription\_create\_times) | The creation times of the Message Service subscriptions. |
| <a name="output_subscription_ids"></a> [subscription\_ids](#output\_subscription\_ids) | The IDs of the Message Service subscriptions. |
| <a name="output_subscription_names"></a> [subscription\_names](#output\_subscription\_names) | The names of the Message Service subscriptions. |
| <a name="output_topic_create_times"></a> [topic\_create\_times](#output\_topic\_create\_times) | The creation times of the Message Service topics. |
| <a name="output_topic_ids"></a> [topic\_ids](#output\_topic\_ids) | The IDs of the Message Service topics. |
| <a name="output_topic_names"></a> [topic\_names](#output\_topic\_names) | The names of the Message Service topics. |
<!-- END_TF_DOCS -->

## Submit Issues

If you have any problems when using this module, please opening
a [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) and let us know.

**Note:** There does not recommend opening an issue on this repo.

## Authors

Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com).

## License

MIT Licensed. See LICENSE for full details.

## Reference

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)