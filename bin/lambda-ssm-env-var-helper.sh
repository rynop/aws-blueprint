#!/usr/bin/env bash

# This script will help you setup cmds to run in order to setup your env vars in SSM

while [[ -z "$VARS" ]]; do
    read -p "Comma seperated env vars (MY_VAR1,MY_VAR2): " VARS
done
VARS="$(echo -e "${VARS}" | tr -d '[:space:]')"

while [[ -z "$stage" ]]; do
    read -p "Stage (Ex: test,staging, or prod): " stage
done

while [[ -z "$githubRepoName" ]]; do
    read -p "Github repo name (omit org): " githubRepoName
done

while [[ -z "$gitBranch" ]]; do
    read -p "Git branch (Ex: master): " gitBranch
done

while [[ -z "$lambdaName" ]]; do
    read -p "Lambda Name (LambdaName param to your CloudFormation, no -- in name): " lambdaName
done

echo "--Bash script start--"
echo "\
#!/usr/bin/env bash

#DO NOT CHECK IN MODIFICATIONS TO THIS FILE

#Generated from https://github.com/rynop/aws-blueprint/blob/master/bin/lambda-ssm-env-var-helper.sh

STAGE=${stage}
BRANCH=${gitBranch}
LAMBDA_NAME=${lambdaName}
"

IFS=',' read -ra ADDR <<< "$VARS"
for i in "${ADDR[@]}"; do
    echo "aws ssm put-parameter --name "/\$STAGE/${githubRepoName}/\$BRANCH/\$LAMBDA_NAME/lambdaEnvs/${i}" --type 'SecureString' --value '<YOUR VALUE HERE>'"
done
echo "--Bash script end--"

printf '\nRemember to also run:\n\n'
echo "aws ssm put-parameter --name '/${stage}/${githubRepoName}/${gitBranch}/${lambdaName}/lambdaEnvs/lambdaTimeout' --type 'String' --value '<YOUR VALUE HERE>'"
echo "aws ssm put-parameter --name '/${stage}/${githubRepoName}/${gitBranch}/${lambdaName}/lambdaEnvs/lambdaMemory' --type 'String' --value '<YOUR VALUE HERE>'"
