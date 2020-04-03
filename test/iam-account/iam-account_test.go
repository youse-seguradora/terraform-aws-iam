package test

import (
	"fmt"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestIAMAccount(t *testing.T) {
	t.Parallel()

	// Expected value
	const chars = "abcdefghijklmnopqrstuvwxyz"
	expectedName := fmt.Sprintf("terratest-aws-example-%s", strings.ToLower(random.UniqueId()))
	expectedIAMMaxPasswordAge := random.RandomInt([]int{10, 128})
	expectedIAMMinimumPasswordLength := random.RandomInt([]int{10, 128})
	expectedIAMPasswordReusePrevention := random.RandomInt([]int{10, 50})
	awsRegion := aws.GetRandomStableRegion(t, nil, nil)

	terraformOptions := &terraform.Options{
		TerraformDir: "../../examples/iam-account",
		Upgrade:      true,

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"iam_account_alias":             expectedName,
			"iam_minimum_password_length":   expectedIAMMinimumPasswordLength,
			"iam_password_reuse_prevention": expectedIAMPasswordReusePrevention,
			"iam_max_password_age":          expectedIAMMaxPasswordAge,
		},

		// Environment variables to set when running Terraform
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": awsRegion,
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

}
