aws iam create-role --role-name lambda-execution-role --assume-role-policy-document file://trust_policy.json

aws iam attach-role-policy --role-name lambda-execution-role --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole

zip function_code.zip index.js

aws lambda create-function --function-name print-envs \
--zip-file fileb://function_code.zip --handler index.handler --runtime nodejs12.x \
--role arn:aws:iam::953029374461:role/lambda-execution-role

aws lambda invoke --function-name print-envs out --log-type Tail \
--query 'LogResult' --output text | base64 -D
