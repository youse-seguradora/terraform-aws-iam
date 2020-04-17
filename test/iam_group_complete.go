package test

import (
	"sort"
	"testing"
	"time"

	"github.com/goombaio/namegenerator"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestIAMGroupComplete(t *testing.T) {
	t.Parallel()

	// Expected value
	seed := time.Now().UTC().UnixNano()
	nameGenerator := namegenerator.NewNameGenerator(seed)
	expectedIAMName1 := nameGenerator.Generate()
	expectedIAMName2 := nameGenerator.Generate()
	expectedIAMGroupName := nameGenerator.Generate()

	terraformOptions := &terraform.Options{
		TerraformDir: "../examples/iam-group-complete",
		Upgrade:      true,

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"iam_user_1_name": expectedIAMName1,
			"iam_user_2_name": expectedIAMName2,
			"iam_group_name":  expectedIAMGroupName,
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	thisIAMGroupName := terraform.Output(t, terraformOptions, "this_group_name")
	assert.Equal(t, expectedIAMGroupName, thisIAMGroupName)

	GroupUsersNames := []string([]string{expectedIAMName1, expectedIAMName2})
	sort.Strings(GroupUsersNames)

	thisIAMGroupUsersNames := terraform.OutputList(t, terraformOptions, "this_group_users")
	sort.Strings(thisIAMGroupUsersNames)
	assert.EqualValues(t, GroupUsersNames, thisIAMGroupUsersNames)
}
