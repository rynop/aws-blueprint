# aws-blueprint

Easy to use CI/CD driven, convention based application harness that facilitates production grade, multi-stage approval based deployments. Each developer on your team can easly create production replica toplogies from a git feature branch.

Architected to work with a low cost (but scaleable) APIGateway+Lambda OR a high transaction ECS Fargate environment. Includes an upgrade path from the APIG+Lambda to Fargate if/when the workload outgrows Lambda.

## Prerequisites

There are a handful of necessary steps prior to running any of the Blueprints below. These steps only need to be done once.

1.  [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
1.  Create a [personal github access token](https://github.com/settings/tokens). This token will be used by the CI/CD to pull code.  If you work in a team, it is recommended to create a seperate github user account for this.
1.  Create a **versioned** S3 bucket to store CloudFormation nested stack templates. See [nested-stacks](./nested-stacks) for instructions.
1.  If you are running MacOS, install GNU tools ([below](https://github.com/rynop/aws-blueprint#gnu-tools-for-macos))

## Terminology

The Stage/Stages term referred to thoughout the Blueprints are: `test`,`staging`,`prod`. All CI/CD enviornments created by Blueprint will give you these 3 stages by default.

## Blueprints

View the setup instructions in the `README.md` of the blueprint you wish to use.

- [abp-sam-twirp](https://github.com/rynop/abp-sam-twirp): CloudFront -> API Gateway -> Lambda running [Twirp](https://github.com/twitchtv/twirp) (RPC, protobuf&JSON) using [Serverless Application Module (SAM)]. Complete with local API Gateway, Lambda and DyanmoDB simulation.
- [abp-sam-nestjs](https://github.com/rynop/abp-sam-nestjs): API Gateway -> Lambda running [NestJS](https://nestjs.com/) using  [Serverless Application Module (SAM)](https://github.com/awslabs/serverless-application-model). Complete with local API Gateway, Lambda and DyanmoDB simulation.
- [abp-single-lambda-api](https://github.com/rynop/abp-single-lambda-api): API backed by a single Lambda
- [abp-singlle-lambda-no-web-api](https://github.com/rynop/abp-single-lambda-api#lambda-with-no-web-api): Single Lambda with no web API (ex: invoked by SNS).
- [abp-fargate](https://github.com/rynop/abp-fargate): Fargate based app (with or without ELB)
- [abp-angular](https://github.com/rynop/abp-angular): Running Angular web apps on AWS

## GNU tools for MacOS

Not required, but recomended. Some blueprints have a quickstart script, that will require GNU versions if running MacOS.

```
brew install wget
brew install coreutils
brew install gnu-sed

#add the following to your PATH

#### fish example (~/.config/fish/config.fish):
set -x GNU_BIN_PATH /usr/local/opt/coreutils/libexec/gnubin
set -x GNU_SED_PATH /usr/local/opt/gnu-sed/libexec/gnubin
set -x PATH $GNU_BIN_PATH $GNU_SED_PATH $PATH

#### Bash example (~/.bash_profile)
GNU_BIN_PATH=/usr/local/opt/coreutils/libexec/gnubin
GNU_SED_PATH=/usr/local/opt/gnu-sed/libexec/gnubin
export PATH="$GNU_BIN_PATH:$GNU_SED_PATH:$PATH"
```

## Tips

- [HOWTO](https://rynop.com/2019/05/09/howto-mobile-development-against-a-localhost-https-api/) develop against a localhost HTTPS API.
