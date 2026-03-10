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