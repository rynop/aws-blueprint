# aws-blueprint

Easy to use CI/CD driven, convention based application harness that facilitates production grade, multi-stage approval based deployments. Each developer on your team can easly create production replica toplogies from a git feature branch.

Architected to work with a low cost (but scaleable) APIGateway+Lambda OR a high transaction ECS Fargate environment. Includes an upgrade path from the APIG+Lambda to Fargate if/when the workload outgrows Lambda.

## Setup

The Stage/Stages term refrenced throught this repo is `test`,`staging`,`prod`. All the CI/CD pipelines create these 3 stages.

1.  Create a Github user (acct will just be used to read repos for CI/CD), give it read auth to your github repo. Create a personal access token for this user at https://github.com/settings/tokens. This token will be used by the CI/CD to pull code.
1.  Create a **versioned** s3 bucket to store CloudFormation nested stack templates. See [nested-stacks](./nested-stacks) for instructions.
1.  Optional: if you are running MacOS, install GNU tools (below) to use the quick setup scripts in the example projects.
1.  Recommended: Setup a trusted, [https certificate for local development](https://rynop.com/2018/11/12/setup-secure-https-certificate-for-local-angular-development-on-macos-mojave/).
1.  Pick from the [examples](https://github.com/rynop/aws-blueprint#examples) below, and view the setup instructions in the `README.md`. It will walk you through creating your "resources" CloudFormation stack (API Gateway, s3 buckets, dynamo tables etc), as well as how to create your CI/CD CloudFormation Stack.

## Examples

- [abp-single-lambda-api](https://github.com/rynop/abp-single-lambda-api): API backed by a single Lambda
- [abp-singlle-lambda-no-web-api](https://github.com/rynop/abp-single-lambda-api#lambda-with-no-web-api): Single Lambda with no web API (ex: invoked by SNS).
- [abp-fargate](https://github.com/rynop/abp-fargate): Fargate based app (with or without ELB)
- [abp-angular](https://github.com/rynop/abp-angular): Running Angular web apps on AWS

## GNU tools

```
brew install coreutils
brew install gnu-sed --with-default-names

#add to your path: fish example (~/.config/fish/config.fish)
set -x GNU_BIN_PATH /usr/local/opt/coreutils/libexec/gnubin
set -x GNU_SED_PATH /usr/local/Cellar/gnu-sed/4.5/bin

set -x PATH $GOPATH $PIP_BIN_PATH $GNU_BIN_PATH $GNU_SED_PATH $PATH
```
