阿里云消息服务 Terraform 模块

# terraform-alicloud-message-service

[English](https://github.com/alibabacloud-automation/terraform-alicloud-message-service/blob/main/README.md) | 简体中文

在阿里云上创建消息服务资源的 Terraform 模块。该模块为构建可靠、可扩展的消息队列和发布/订阅消息系统提供了全面的解决方案。[阿里云消息服务](https://www.alibabacloud.com/product/message-service)支持分布式应用程序和服务之间的异步通信，具有高可用性、持久性和安全性特性。

## 使用方法

该模块可用于创建完整的消息服务基础设施，包括队列、主题、订阅和事件规则。您可以通过使用创建控制变量来配置模块，仅创建您需要的资源。

```terraform
module "message_service" {
  source = "alibabacloud-automation/message-service/alicloud"

  # 服务激活
  create_service = true

  # 端点配置
  create_endpoint = true
  endpoint_config = {
    endpoint_enabled = true
    endpoint_type    = "public"
  }

  # 队列配置
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

  # 主题配置
  create_topics = true
  topic_configs = {
    "my-topic" = {
      topic_name       = "my-application-topic"
      max_message_size = 65536
      enable_logging   = true
    }
  }

  # 通用标签
  common_tags = {
    Environment = "production"
    Project     = "my-application"
  }
}
```

## 示例

* [完整示例](https://github.com/alibabacloud-automation/terraform-alicloud-message-service/tree/main/examples/complete)

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->

## 提交问题

如果您在使用此模块时遇到任何问题，请提交一个 [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) 并告知我们。

**注意：** 不建议在此仓库中提交问题。

## 作者

由阿里云 Terraform 团队创建和维护(terraform@alibabacloud.com)。

## 许可证

MIT 许可。有关完整详细信息，请参阅 LICENSE。

## 参考

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)