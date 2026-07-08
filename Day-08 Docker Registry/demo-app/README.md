# Demo App - Build, Tag, Push Practice

A simple static nginx page to practice Docker Registry concepts hands-on.

## Step 1: Build

```bash
cd demo-app
docker build -t registry-demo:v1 .
```

## Step 2: Run Locally (Verify)

```bash
docker run -d -p 8080:80 registry-demo:v1
# Open http://localhost:8080
```

## Step 3a: Push to Docker Hub

```bash
docker tag registry-demo:v1 <your-dockerhub-username>/registry-demo:v1
docker login
docker push <your-dockerhub-username>/registry-demo:v1
```

## Step 3b: Push to AWS ECR

```bash
ACCOUNT_ID=<your-account-id>
REGION=ap-south-1

aws ecr create-repository --repository-name registry-demo --region $REGION

aws ecr get-login-password --region $REGION | \
docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com

docker tag registry-demo:v1 $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/registry-demo:v1
docker push $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/registry-demo:v1
```

## Step 4: Pull and Verify (from anywhere)

```bash
docker pull <your-dockerhub-username>/registry-demo:v1
# or
docker pull $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/registry-demo:v1
```

Congrats - you've now practiced the full registry workflow! 🎉
