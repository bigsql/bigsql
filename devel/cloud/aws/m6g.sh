ami_ubu16=ami-0c37ee902a7924ed2
ami_amzn2=ami-002cc39e7bf021a77

aws ec2 run-instances --instance-type m6g.8xlarge --image-id $ami_amzn2 \
  --key-name luss-iam-east1 --region us-east-1 --security-group-id sg-0d579e42db5870417 \
  --block-device-mappings 'DeviceName=/dev/sda1,Ebs={VolumeSize=2000}' \
  --ebs-optimized
