package test

import (
	"fmt"
	"math/rand"
	"strconv"
	"strings"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestIAMAccount(t *testing.T) {
	t.Parallel()

	rand.Seed(time.Now().UnixNano())

	// Expected value
	expectedName := fmt.Sprintf("terratest-aws-example-%s", strings.ToLower(random.UniqueId()))
	expectedIAMMaxPasswordAge := rand.Intn(100-10) + 10
	expectedIAMMinimumPasswordLength := rand.Intn(100-10) + 10
	expectedIAMPasswordReusePrevention := rand.Intn(15-5) + 5

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
			"AWS_DEFAULT_REGION": "us-east-1",
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	thiIAMMaxPasswordAge := terraform.Output(t, terraformOptions, "this_iam_max_password_age")
	assert.Equal(t, strconv.Itoa(expectedIAMMaxPasswordAge), thiIAMMaxPasswordAge)

	thiIAMMinimumPasswordLength := terraform.Output(t, terraformOptions, "this_iam_minimum_password_length")
	assert.Equal(t, strconv.Itoa(expectedIAMMinimumPasswordLength), thiIAMMinimumPasswordLength)

	thiIAMPasswordReusePrevention := terraform.Output(t, terraformOptions, "this_iam_password_reuse_prevention")
	assert.Equal(t, strconv.Itoa(expectedIAMPasswordReusePrevention), thiIAMPasswordReusePrevention)

	thiIAMAllowUsers2ChangePassword := terraform.Output(t, terraformOptions, "this_iam_allow_users_to_change_password")
	assert.Equal(t, "true", thiIAMAllowUsers2ChangePassword)

	thiIAMRequireLowercaseCharacters := terraform.Output(t, terraformOptions, "this_iam_require_lowercase_characters")
	assert.Equal(t, "true", thiIAMRequireLowercaseCharacters)

	thiIAMRequireUppercaseCharacters := terraform.Output(t, terraformOptions, "this_iam_require_uppercase_characters")
	assert.Equal(t, "true", thiIAMRequireUppercaseCharacters)

	thiIAMRequireNumbers := terraform.Output(t, terraformOptions, "this_iam_require_numbers")
	assert.Equal(t, "true", thiIAMRequireNumbers)

	thiIAMRequireSymbols := terraform.Output(t, terraformOptions, "this_iam_require_symbols")
	assert.Equal(t, "true", thiIAMRequireSymbols)

	ThisAccountAlias := terraform.Output(t, terraformOptions, "this_account_alias")
	assert.Equal(t, expectedName, ThisAccountAlias)

}
