package test

import (
	"testing"
	"time"

	"github.com/goombaio/namegenerator"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestIAMAssumableRole(t *testing.T) {
	t.Parallel()

	// Expected value
	seed := time.Now().UTC().UnixNano()
	nameGenerator := namegenerator.NewNameGenerator(seed)
	expectedIAMRoleName := nameGenerator.Generate()

	terraformOptions := &terraform.Options{
		TerraformDir: "../examples/iam-assumable-role",
		Upgrade:      true,

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"iam_role_name": expectedIAMRoleName,
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

	thisIAMRoleName := terraform.Output(t, terraformOptions, "this_iam_role_name")
	assert.Equal(t, expectedIAMRoleName, thisIAMRoleName)
}
