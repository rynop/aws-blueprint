# aws-blueprint

Easy to use CI/CD driven, convention based application harness that facilitates production grade, multi-stage approval based deployments.  Architected to work with a low cost (but scaleable) APIGateway+Lambda environment OR a high transaction ECS Fargate environment.  Includes an upgrade path from the APIG+Lambda to Fargate if/when the workload outgrows lambda.

## Setup

The Stage/Stages term refrenced throught this repo is `test`,`staging`,`prod`.  All the CI/CD pipelines create these 3 stages.

1.  Create a Github user (acct will just be used to read repos for CI/CD), give it read auth to your github repo.  Create a personal access token for this user at https://github.com/settings/tokens.  This token will be used by the CI/CD to pull code.
1.  Create a **versioned** s3 bucket to store CloudFormation nested stack templates.  See [nested-stacks](./nested-stacks) for instructions.
1.  Pick from the [examples](https://github.com/rynop/aws-blueprint#examples) below, and view the setup instructions in the `README.md`.  It will walk you through creating your "resources" CloudFormation stack (API Gateway, s3 buckets, dynamo tables etc), as well as how to create your CI/CD CloudFormation Stack.

## Examples

*  [abp-single-lambda-api](https://github.com/rynop/abp-single-lambda-api): API backed by a single Lambda
*  [abp-fargate](https://github.com/rynop/abp-fargate): Fargate based app (with or without ELB)

## TODO

*  single-lambda no APIG
