#Starts deployment to Amazon Servers based on environment variables
#Captures deployment_id to check deploy progess
resp=$(aws opsworks create-deployment --stack-id $stack_id --app-id $app_id --instance-ids $instance_id --command "{\"Name\":\"deploy\",\"Args\":{\"migrate\":[\"$migrate_bool\"]}}")
deploy_id=$(echo $resp | jsawk 'return this.DeploymentId')

#Loops until the deploy fails or succeeds
#Exit status will be 0 if deploy succeeds, otherwise 1
while true
  do
  resp=$(aws opsworks --region "us-east-1" describe-deployments --deployment-ids $deploy_id)
  status=$(echo $resp | jsawk "return this.Deployments['0'].Status")
  if [ "$status" = "successful" ]
    then
    exit 0
  fi
  if [ "$status" = "failed" ]
    then
    exit 1
  fi
  sleep 30s
done
