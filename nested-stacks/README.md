Any time these files are changed, they should be synced to `s3://<your cloudformation bucket>/nested-stacks` versioned S3 bucket.

1.  Clone this repo
1.  From the `nested-stacks` dir run: `aws s3 sync . s3://us-east-1--aws-blueprint.yourdomain.com/nested-stacks`

### Note

BEFORE running sync below make sure your CloudFormation `yaml` validates.  Ex: `aws cloudformation validate-template --template-body file://apig/single-lambda-proxy-with-CORS.yaml`.  If it passes the validator, but you get strange errors running CloudFormation, create the nested stack yaml directly in the cloudformation console. It gives better errors.
