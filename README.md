# Marco Home Task Documentation

# Application Details

* The application is an API written in `ruby`
* The aplication runs in port 8000 by default
* The application must be accesible publicly in the AWS cloud
* The application has 2 endpoints `cidr-to-mask?value=XXX` and `mask-to-cidr?value=XXX`
* Both endpoints are fully functional

# Resources Created
### Cloud Formation
arn:aws:cloudformation:us-east-1:097268227507:stack/marco-home-task/ae323030-4719-11e9-8d3a-0aa1af63e98c

### AWS ECR Image Uri
097268227507.dkr.ecr.us-east-1.amazonaws.com/marco-task:v1

# Testing
### Test the application locally

```bash
$ curl localhost:8000/cidr-to-mask?value=24
{
  "function": "cidrToMask",
  "input": "24",
  "output": "255.255.255.0"
}
```

```bash
$ curl localhost:8000/mask-to-cidr?value=255.255.0.0
{
  "function": "maskToCidr",
  "input": "255.255.0.0",
  "output": "16"
}
```

### API Endpoint
```bash
$ curl http://ecs-services-1430616052.us-east-1.elb.amazonaws.com:8000/cidr-to-mask?value=24
{
  "function": "cidrToMask",
  "input": "24",
  "output": "255.255.255.0"
}
```
```bash
$ curl http://ecs-services-1430616052.us-east-1.elb.amazonaws.com:8000/mask-to-cidr?value=255.255.0.0
{
  "function": "maskToCidr",
  "input": "255.255.0.0",
  "output": "16"
}
```

# Cloud Infrastructure

![](WizelineDiagram.png "Architecture Diagram")

# Documentation

## Github Repository
### Clone Repo
```sh
git clone https://[username]:[token]@github.com/wizeline/wize-cloud-ops-marco-martinez.git
```

### Go to folder
```bash
cd wize-cloud-ops-marco-martinez
```
## Docker Container
### Generate Gemfile.lock (Lock Version Dependencies)
```bash
docker run --rm -v "$PWD"/src:/src -w /src ruby:2.5 bundle install
```
https://docs.docker.com/engine/reference/run/
--rm (Clean on exit)
-v, --volume=[host-src:]container-dest[:<options>]: Bind mount a volume.
-w="": Working directory inside the container

### Create Dockerfile
```sh
FROM ruby:2.5

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

LABEL author="Marco Martinez"
LABEL email="markwinap@gmail.com"
LABEL version="1.0"
LABEL description="Home Task"

# Set working directory and copy files from local path to container file system path
WORKDIR src/
COPY src/ /src
# Install Ruby ependencies by installing all the required gems
RUN bundle install
# Listens to TCP port 8000
EXPOSE 8000
# Container execution command and running port
CMD ruby api.rb -p 8000
```
### docker-compose.yml File
https://docs.docker.com/compose/rails/

### Build container
```bash
sudo docker build -t marco-task .
```
### Run container locally
```bash
sudo docker run -p 8000:8000 marco-task
```

# Other usefull commands

### List Running Docker Containers
```bash
docker container ls
```
### Kill Docker Container
```bash
docker kill CONTAINER [CONTAINER ID]
```

## AWS CLI
### Install AWS CLI
```bash
sudo apt  install awscli
```

### Configure AWS CLI credentials in a new profile
```bash
aws configure --profile wizeline
```

### Create AWS ECR Repository
```bash
aws ecr create-repository --repository-name marco-task --profile wizeline
```

### Get AWS ECR login token
```sh
aws ecr get-login --profile wizeline --no-include-email | sh
```
### Create AWS ECS Service Link Role
```bash
aws iam create-service-linked-role --aws-service-name ecs.amazonaws.com --profile wizeline
```
### Get AWS ECR Repository Uri 
```bash
aws ecr describe-repositories --repository-name marco-task --profile wizeline
```

### Tag Local Docker image with AWS ECR repository Uri + image version
```bash
sudo docker tag marco-task:latest [ECR Repo Uri + :v1]
```

### Push Docker Image To AWS ECR
```bash
sudo docker push [ECR Repo Uri + :v1]
```
