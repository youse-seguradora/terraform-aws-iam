package test

import (
	"testing"
	"time"

	"github.com/goombaio/namegenerator"
	"github.com/gruntwork-io/terratest/modules/ssh"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestIAMUser(t *testing.T) {
	t.Parallel()

	// Expected value

	seed := time.Now().UTC().UnixNano()
	nameGenerator := namegenerator.NewNameGenerator(seed)
	expectedName1 := nameGenerator.Generate()
	expectedIAMUser1SSHKey := ssh.GenerateRSAKeyPair(t, 256)
	expectedName2 := nameGenerator.Generate()
	expectedName3 := nameGenerator.Generate()

	terraformOptions := &terraform.Options{
		TerraformDir: "../examples/iam-user",
		Upgrade:      true,

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"iam_user_1_name":           expectedName1,
			"iam_user_1_ssh_public_key": expectedIAMUser1SSHKey.PublicKey,
			"iam_user_2_name":           expectedName2,
			"iam_user_3_name":           expectedName3,
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	thisIAMUserName1 := terraform.Output(t, terraformOptions, "this_iam_user_name1")
	assert.Equal(t, expectedName1, thisIAMUserName1)

	thisIAMUserName2 := terraform.Output(t, terraformOptions, "this_iam_user_name2")
	assert.Equal(t, expectedName2, thisIAMUserName2)

	thisIAMUserName3 := terraform.Output(t, terraformOptions, "this_iam_user_name3")
	assert.Equal(t, expectedName3, thisIAMUserName3)

}
