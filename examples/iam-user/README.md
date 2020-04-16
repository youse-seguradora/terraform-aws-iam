# IAM user example

Configuration in this directory creates IAM user with a random password, a pair of IAM access/secret keys and uploads IAM SSH public key.
User password and secret key is encrypted using public key of keybase.io user named `test`.

# Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| aws\_region | ########### Variables ########### | `string` | `"us-east-1"` | no |
| iam\_user\_1\_name | n/a | `any` | n/a | yes |
| iam\_user\_1\_ssh\_public\_key | n/a | `any` | n/a | yes |
| iam\_user\_2\_name | n/a | `any` | n/a | yes |
| iam\_user\_3\_name | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| this\_iam\_user\_name1 | ####################### Getting Users Names ####################### |
| this\_iam\_user\_name2 | n/a |
| this\_iam\_user\_name3 | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
