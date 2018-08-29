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

while [[ -z "$appName" ]]; do
    read -p "App Name (part before / in ECS image repo): " appName
done

echo ""
echo "--Bash script start--"
echo "\
#!/usr/bin/env bash

#DO NOT CHECK IN MODIFICATIONS TO THIS FILE

#Generated from https://github.com/rynop/aws-blueprint/blob/master/bin/fargate-ssm-env-var-helper.sh

STAGE=${stage}
BRANCH=${gitBranch}
APP_NAME=${appName}
"

IFS=',' read -ra ADDR <<< "$VARS"
for i in "${ADDR[@]}"; do
    echo "aws ssm put-parameter --name \"/\$STAGE/${githubRepoName}/\$BRANCH/\$APP_NAME/ecsEnvs/${i}\" --type 'SecureString' --value '<YOUR VALUE HERE>'"
done

echo "--Bash script end--"

echo ""
echo "Make sure aws/cloudformation/parameters/${stage}--ecs-codepipeline-parameters.json has SsmEnvPrefix set to /${stage}/${githubRepoName}/${gitBranch}/${appName}/ecsEnvs/"