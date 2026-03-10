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

  # Queue configuration
  create_queues = true
  queue_configs = {
    "my-queue" = {
      queue_name               = "my-application-queue"
      delay_seconds            = 0
      polling_wait_seconds     = 0
      message_retention_period = 345600
      maximum_message_size     = 65536
      visibility_timeout       = 30
      logging_enabled          = true
    }
  }

  # Topic configuration
  create_topics = true
  topic_configs = {
    "my-topic" = {
      topic_name       = "my-application-topic"
      max_message_size = 65536
      enable_logging   = true
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