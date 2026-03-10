# Complete Example for Alibaba Cloud Message Service Module

This example demonstrates how to use the Alibaba Cloud Message Service Terraform module to create a complete messaging infrastructure.

## What This Example Creates

This example creates the following Message Service resources:

- **Message Service**: Activates the Message Service for your account
- **Endpoint**: Creates a public endpoint for accessing Message Service
- **Endpoint ACL**: Configures access control rules for the endpoint
- **Queue**: Creates a message queue with dead letter queue policy
- **Topic**: Creates a message topic with logging enabled
- **Subscription**: Creates a subscription to connect the topic to the queue
- **Event Rule**: Creates an event rule for object storage events

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_message_service"></a> [message\_service](#module\_message\_service) | ../../ | n/a |

## Resources

| Name | Type |
|------|------|
| [alicloud_account.current](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/account) | data source |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | Common tags to be applied to all resources. | `map(string)` | <pre>{<br>  "Environment": "example",<br>  "Project": "message-service-demo"<br>}</pre> | no |
| <a name="input_event_rule_name"></a> [event\_rule\_name](#input\_event\_rule\_name) | The name of the Message Service event rule. | `string` | `"example-event-rule"` | no |
| <a name="input_queue_name"></a> [queue\_name](#input\_queue\_name) | The name of the Message Service queue. | `string` | `"example-queue"` | no |
| <a name="input_region"></a> [region](#input\_region) | The Alibaba Cloud region to deploy resources in. | `string` | `"cn-hangzhou"` | no |
| <a name="input_subscription_name"></a> [subscription\_name](#input\_subscription\_name) | The name of the Message Service subscription. | `string` | `"example-subscription"` | no |
| <a name="input_topic_name"></a> [topic\_name](#input\_topic\_name) | The name of the Message Service topic. | `string` | `"example-topic"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_all_queue_info"></a> [all\_queue\_info](#output\_all\_queue\_info) | Combined information of all Message Service queues. |
| <a name="output_all_subscription_info"></a> [all\_subscription\_info](#output\_all\_subscription\_info) | Combined information of all Message Service subscriptions. |
| <a name="output_all_topic_info"></a> [all\_topic\_info](#output\_all\_topic\_info) | Combined information of all Message Service topics. |
| <a name="output_endpoint_id"></a> [endpoint\_id](#output\_endpoint\_id) | The ID of the Message Service endpoint. |
| <a name="output_event_rule_ids"></a> [event\_rule\_ids](#output\_event\_rule\_ids) | The IDs of the Message Service event rules. |
| <a name="output_event_rule_names"></a> [event\_rule\_names](#output\_event\_rule\_names) | The names of the Message Service event rules. |
| <a name="output_queue_ids"></a> [queue\_ids](#output\_queue\_ids) | The IDs of the Message Service queues. |
| <a name="output_queue_names"></a> [queue\_names](#output\_queue\_names) | The names of the Message Service queues. |
| <a name="output_service_id"></a> [service\_id](#output\_service\_id) | The ID of the Message Service. |
| <a name="output_service_status"></a> [service\_status](#output\_service\_status) | The status of the Message Service. |
| <a name="output_subscription_ids"></a> [subscription\_ids](#output\_subscription\_ids) | The IDs of the Message Service subscriptions. |
| <a name="output_subscription_names"></a> [subscription\_names](#output\_subscription\_names) | The names of the Message Service subscriptions. |
| <a name="output_topic_ids"></a> [topic\_ids](#output\_topic\_ids) | The IDs of the Message Service topics. |
| <a name="output_topic_names"></a> [topic\_names](#output\_topic\_names) | The names of the Message Service topics. |

## Architecture

This example creates a complete message processing pipeline:

1. **Message Service Activation**: Enables the service for your account
2. **Endpoint & ACL**: Creates a secure public endpoint with access control
3. **Queue**: Creates a message queue with dead letter queue support
4. **Topic**: Creates a topic for message publishing
5. **Subscription**: Connects the topic to the queue for message delivery
6. **Event Rule**: Automatically triggers messages based on OSS events

## Notes

- The subscription endpoint uses the queue format: `acs:mns:{region}:{account_id}:/queues/{queue_name}`
- Dead letter queue policy is configured for message retry handling
- Event rules are set up to capture OSS object creation events with specific prefix/suffix filters
- All resources are tagged for better resource management