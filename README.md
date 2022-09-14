## Create Parameters

In Parameter store, create a Parameter to store value for Github OAuth token against this `GITHUB_OAUTH_TOKEN` parameter.

## Bugs

There is a bug in the module used, first we need to push the changes with `codepipeline_github_oauth_token` containing actual github token, then if the Code Pipeline starts working, then we can change the value for this variable to use a Parameter from `Systems Manager > Paramater store`

## Example Buildspec

Here's an example `buildspec.yaml`. Stick this in the root of your project repository.

```yaml
version: 0.2
phases:
    pre_build:
        commands:
            - echo Logging in to Amazon ECR...
            - aws --version
            - eval $(aws ecr get-login --region $AWS_DEFAULT_REGION --no-include-email)
            - REPOSITORY_URI=$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$IMAGE_REPO_NAME
            - IMAGE_TAG=$(echo $CODEBUILD_RESOLVED_SOURCE_VERSION | cut -c 1-7)
    build:
        commands:
            - echo Build started on `date`
            - echo Building the Docker image...
            - REPO_URI=$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$IMAGE_REPO_NAME
            - docker pull $REPO_URI:latest || true
            - docker build --cache-from $REPO_URI:latest --tag $REPO_URI:latest --tag $REPO_URI:$IMAGE_TAG --build-arg NODE_ENV=$NODE_ENV --build-arg PORT=$PORT --build-arg COUNTRY=$COUNTRY .
    post_build:
        commands:
            - echo Build completed on `date`
            - echo Pushing the Docker images...
            - REPO_URI=$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$IMAGE_REPO_NAME
            - docker push $REPO_URI:latest
            - docker push $REPO_URI:$IMAGE_TAG
            - echo Writing image definitions file...
            - printf '[{"name":"%s","imageUri":"%s"}]' "$CONTAINER_NAME" "$REPO_URI:$IMAGE_TAG" | tee imagedefinitions.json
artifacts:
    files: imagedefinitions.json
```


## Example AppSpec

Here's an example `appspec.yaml`. Stick this in the root of your project repository.

```yaml
version: 0.0
Resources:
    - TargetService:
          Type: AWS::ECS::Service
          Properties:
              TaskDefinition: '$TASK_DEFINITION'
              LoadBalancerInfo:
                  ContainerName: '$CONTAINER_NAME'
                  ContainerPort: '80'
              PlatformVersion: 'LATEST'
              NetworkConfiguration:
                  AwsvpcConfiguration:
                      Subnets: ['$SUBNET_1', '$SUBNET_2', '$SUBNET_3']
                      SecurityGroups: ['$SECURITY_GROUP']
                      AssignPublicIp: 'ENABLED'

```