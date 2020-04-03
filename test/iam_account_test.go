package test

import (
	"fmt"
	"strconv"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestIAMAccount(t *testing.T) {
	t.Parallel()

	// Expected value
	expectedName := fmt.Sprintf("terratest-aws-example-%s", strings.ToLower(random.UniqueId()))
	expectedIAMMaxPasswordAge := random.RandomInt([]int{10, 128})
	expectedIAMMinimumPasswordLength := random.RandomInt([]int{10, 128})
	expectedIAMPasswordReusePrevention := random.RandomInt([]int{10, 50})
	awsRegion := aws.GetRandomStableRegion(t, nil, nil)

	terraformOptions := &terraform.Options{
		TerraformDir: "../examples/iam-account",
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

	this_iam_max_password_age := terraform.Output(t, terraformOptions, "this_iam_max_password_age")
	assert.Equal(t, strconv.Itoa(expectedIAMMaxPasswordAge), this_iam_max_password_age)

	this_iam_minimum_password_length := terraform.Output(t, terraformOptions, "this_iam_minimum_password_length")
	assert.Equal(t, strconv.Itoa(expectedIAMMinimumPasswordLength), this_iam_minimum_password_length)

	this_iam_password_reuse_prevention := terraform.Output(t, terraformOptions, "this_iam_password_reuse_prevention")
	assert.Equal(t, strconv.Itoa(expectedIAMPasswordReusePrevention), this_iam_password_reuse_prevention)

	this_iam_allow_users_to_change_password := terraform.Output(t, terraformOptions, "this_iam_allow_users_to_change_password")
	assert.Equal(t, "true", this_iam_allow_users_to_change_password)

	this_iam_require_lowercase_characters := terraform.Output(t, terraformOptions, "this_iam_require_lowercase_characters")
	assert.Equal(t, "true", this_iam_require_lowercase_characters)

	this_iam_require_uppercase_characters := terraform.Output(t, terraformOptions, "this_iam_require_uppercase_characters")
	assert.Equal(t, "true", this_iam_require_uppercase_characters)

	this_iam_require_numbers := terraform.Output(t, terraformOptions, "this_iam_require_numbers")
	assert.Equal(t, "true", this_iam_require_numbers)

	this_iam_require_symbols := terraform.Output(t, terraformOptions, "this_iam_require_symbols")
	assert.Equal(t, "true", this_iam_require_symbols)

	this_account_alias := terraform.Output(t, terraformOptions, "this_account_alias")
	assert.Equal(t, expectedName, this_account_alias)

}
