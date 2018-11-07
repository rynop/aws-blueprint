#!/usr/bin/env bash

# This script will help you setup cmds to run in order to setup your env vars in SSM

while [[ -z "$VARS" ]]; do
    read -p "Comma seperated env vars (MY_VAR1,MY_VAR2): " VARS
done
VARS="$(echo -e "${VARS}" | tr -d '[:space:]')"

while [[ -z "$stage" ]]; do
    read -p "Stage (Ex: test,staging, or prod): " stage
done

read -p "aws cli profile [default]: " awsCliProfile
awsCliProfile=${awsCliProfile:-default}

repoPath=$(basename `git rev-parse --show-toplevel 2>/dev/null` 2>/dev/null)
while [[ -z "$githubRepoName" ]]; do
    read -p "Github repo name (omit org) [${repoPath}]: " githubRepoName
    githubRepoName=${githubRepoName:-$repoPath}
done

read -p "Git branch [master]: " gitBranch
gitBranch=${gitBranch:-master}

echo ""
echo "--Bash script start--"
echo "\
#!/usr/bin/env bash

#DO NOT CHECK IN this file with values defined. Imagine if you accidentally overwrote prod vaules with test ones..

#Generated from https://github.com/rynop/aws-blueprint/blob/master/bin/fargate-ssm-env-var-helper.sh

STAGE=${stage}
BRANCH=${gitBranch}
AWS_CLI_PROFILE=${awsCliProfile}
"

IFS=',' read -ra ADDR <<< "$VARS"
for i in "${ADDR[@]}"; do
    echo "aws ssm put-parameter --profile ${AWS_CLI_PROFILE} --name \"/\$STAGE/${githubRepoName}/\$BRANCH/ecsEnvs/${i}\" --type 'SecureString' --value '<YOUR VALUE HERE>'"
done

echo "--Bash script end--"

echo ""
echo "Make sure aws/cloudformation/parameters/${stage}--ecs-codepipeline-parameters.json has SsmEnvPrefix set to /${stage}/${githubRepoName}/${gitBranch}/ecsEnvs/"
