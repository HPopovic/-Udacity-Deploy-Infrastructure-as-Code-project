# CD12352 - Infrastructure as Code Project Solution
# Heidi Popovic

## Create the S3 bucket
First, create the S3 bucket stack: use the run.sh script with "deploy", e.g.:

./run.sh deploy us-east-1 bucket-stack bucket.yml bucket-parameters.json

## Upload files to S3 bucket
To upload a file to the S3 bucket, use the bucket.sh script with "upload", e.g.:

./bucket.sh upload project2-infra-as-code index.html

Note: the project name must match the project name in the udagram-parameters.json file

## Spin up instructions
To spin up the network and application resources, use the run.sh script with "deploy". First spin up the network resources using network.yml and its parameters file, e.g.:

./run.sh deploy us-east-1 project-network-stack network.yml network-parameters.json

Once the network stack is running, create the application stack, e.g.:

./run.sh deploy us-east-1 project-server-stack udagram.yml udagram-parameters.json

## To preview changes without deploying
To preview changes in a changeset without deploying, use the run.sh script with "preview", e.g.:
./run.sh preview us-east-1 project-network-stack network.yml network-parameters.json


## Tear down instructions
First, empty the bucket using the bucket.sh script with "empty", e.g.:
./bucket.sh empty project2-infra-as-code

Use the run.sh script with "delete" to tear down the resource stacks, e.g.:

./run.sh delete us-east-1 project-server-stack

./run.sh delete us-east-1 project-network-stack

./run.sh delete us-east-1 bucket-stack

## Bastion Host
To use the bastion host:
1. Create a key pair
aws ec2 create-key-pair --key-name "{BastionKeyPair}" --query 'KeyMaterial' --output text > "{BastionKeyPair}.pem"
chmod 400 {BastionKeyPair}.pem
2. Add this key name to the udagram-parameters.json file, and re-deploy udagram stack.
3. Add key PEM file using ssh-add in the terminal, i.e.:
ssh-add ./{BastionKeyPair}.pem
4. SSH into bastion using its public IP [find in "Outputs" of server stack], i.e.:
ssh -A -i .{BastionKeyPair}.pem ubuntu@{ip-address}
5. SSH into server using its private IP - can choose any in the same Availability Zone, i.e.:
ssh ubuntu@{ip-address}

Note: By default, Bastion host is accessible to the public. A user's IP can be specified in udagram-parameters.json

## Other considerations
Load Balancer URL: 
Infrastructure Diagram: Project_Infra_Diagram.drawio.png
Screenshot evidence of Bastion use: Bastion_SSH.png
Screenshot evidence of Udagram page, using LoadBalancerURL from the udagram server stack "Outputs": LB_It_Works.png