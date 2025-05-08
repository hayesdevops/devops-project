package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestAWSNetworking(t *testing.T) {
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../",
		Vars: map[string]interface{}{
			"environment": "test",
			"cost_center": "test-infrastructure",
			"owner":       "platform-team",
		},
		NoColor: true,
	})

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	vpcID := terraform.Output(t, terraformOptions, "vpc_id")
	assert.NotEmpty(t, vpcID, "VPC ID should not be empty")
}
