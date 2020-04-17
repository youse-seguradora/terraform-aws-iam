package test

import (
	"sort"
	"testing"
	"time"

	"github.com/goombaio/namegenerator"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestIAMGroupWithPolicies(t *testing.T) {
	t.Parallel()

	// Expected value

	seed := time.Now().UTC().UnixNano()
	nameGenerator := namegenerator.NewNameGenerator(seed)
	expectedIAMName1 := nameGenerator.Generate()
	expectedIAMName2 := nameGenerator.Generate()
	expectedIAMGroupName1 := nameGenerator.Generate()
	expectedIAMGroupName2 := nameGenerator.Generate()

	terraformOptions := &terraform.Options{
		TerraformDir: "../examples/iam-group-with-policies",
		Upgrade:      true,

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"iam_user_1_name":  expectedIAMName1,
			"iam_user_2_name":  expectedIAMName2,
			"iam_group_name_1": expectedIAMGroupName1,
			"iam_group_name_2": expectedIAMGroupName2,
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	thisIAMGroupName1 := terraform.Output(t, terraformOptions, "this_group_1_name")
	assert.Equal(t, expectedIAMGroupName1, thisIAMGroupName1)

	thisIAMGroupName2 := terraform.Output(t, terraformOptions, "this_group_2_name")
	assert.Equal(t, expectedIAMGroupName2, thisIAMGroupName2)

	GroupUsersNames := []string([]string{expectedIAMName1, expectedIAMName2})
	sort.Strings(GroupUsersNames)

	thisIAMGroupUsersNames1 := terraform.OutputList(t, terraformOptions, "this_group_1_users_names")
	sort.Strings(thisIAMGroupUsersNames1)
	assert.EqualValues(t, GroupUsersNames, thisIAMGroupUsersNames1)

	thisIAMGroupUsersNames2 := terraform.OutputList(t, terraformOptions, "this_group_2_users_names")
	sort.Strings(thisIAMGroupUsersNames2)
	assert.EqualValues(t, GroupUsersNames, thisIAMGroupUsersNames2)
}
