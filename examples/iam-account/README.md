# IAM account example

Configuration in this directory sets [AWS account alias](https://docs.aws.amazon.com/IAM/latest/UserGuide/console_account-alias.html) (also known as Console Account alias) and configures password policy.

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

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| iam\_account\_alias | n/a | `any` | n/a | yes |
| iam\_max\_password\_age | n/a | `any` | n/a | yes |
| iam\_minimum\_password\_length | n/a | `any` | n/a | yes |
| iam\_password\_reuse\_prevention | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| this\_account\_alias | n/a |
| this\_iam\_allow\_users\_to\_change\_password | n/a |
| this\_iam\_max\_password\_age | n/a |
| this\_iam\_minimum\_password\_length | n/a |
| this\_iam\_password\_reuse\_prevention | n/a |
| this\_iam\_require\_lowercase\_characters | n/a |
| this\_iam\_require\_numbers | n/a |
| this\_iam\_require\_symbols | n/a |
| this\_iam\_require\_uppercase\_characters | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
