# AWS Cloudformation Demo

I typically manage complex build with Terraform, not
Cloudformation. However one down-side to Terraform is
applying a standard set of changes across many AWS
accounts in a way that scales.

A solution to this is using Cloudformation Stack Sets.

You can define a Cfn stack, and then describe which
accounts to apply it to.

In this way, you can apply IaC to many accounts without
needing something cumbersome like a TF provider per account.

You can even get clever and use an OU-data-provider to
determine the list of accounts to apply to.

This repo is *not* doing that. It is instead converting a
hypothetical "IAM Account Baseline" role from TF to Cfn.

This role is suitable for:

* Provisioning EKS
* Configuring IRSA and IRSA-linked pod-roles
* Provisioning related resources
* Creating IAM-policies for access to these resources

However the deployment role only granted limitted IAM
access through the use of a permissions-boundary.

NOTE - this is for illustrative purposes only, I haven't
actually tested this role.

# Deploying

Create a file named `vars.tfvars`:

```tf
aws_account_id = "<your AWS account id>"
aws_profile = "<aws config profile for auth>"
```

Then execute:

```
terraform init
terraform apply --var-file vars.tfvars
```

To cleanup:

```
terraform destroy --var-file vas.tfvars
```