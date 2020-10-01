# IAM group with policies example

Configuration in this directory creates IAM group with users who has specified IAM policies.

# Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| iam\_group\_name\_1 | n/a | `any` | n/a | yes |
| iam\_group\_name\_2 | n/a | `any` | n/a | yes |
| iam\_user\_1\_name | n/a | `any` | n/a | yes |
| iam\_user\_2\_name | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| this\_group\_1\_name | IAM group name |
| this\_group\_1\_users\_names | List of IAM users in IAM group |
| this\_group\_2\_name | IAM group name |
| this\_group\_2\_users\_names | List of IAM users in IAM group |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
