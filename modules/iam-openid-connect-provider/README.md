# iam-openid-connect-provider

Creates IAM OpenDd Connect Provider.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.23 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| url | The URL of the identity provider. Corresponds to the iss claim | `string` | `""` | yes |
| client_id_list | A list of client IDs | `""` | `""` | yes |
| thumbprint_list | A list of server certificate thumbprints for the OpenID Connect (OIDC) identity provider's server certificate(s) | `""` | `""` | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn | The ARN assigned by AWS to this policy |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
