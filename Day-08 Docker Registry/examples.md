# Docker Registry - Real World Examples 🛠️

## Example 1: Full Workflow - Local Build → Docker Hub

```bash
# Step 1: Build
docker build -t watsonx-demo:v1 .

# Step 2: Tag for Docker Hub
docker tag watsonx-demo:v1 nagesh/watsonx-demo:v1

# Step 3: Login
docker login

# Step 4: Push
docker push nagesh/watsonx-demo:v1

# Step 5: Verify - pull from another machine
docker pull nagesh/watsonx-demo:v1
```

## Example 2: Full Workflow - Local Build → AWS ECR → EKS Deployment

```bash
# Step 1: Set variables
ACCOUNT_ID=123456789012
REGION=ap-south-1
REPO=watsonx-app

# Step 2: Create ECR repo (one-time)
aws ecr create-repository --repository-name $REPO --region $REGION

# Step 3: Authenticate
aws ecr get-login-password --region $REGION | \
docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com

# Step 4: Build + Tag
docker build -t $REPO:v1 .
docker tag $REPO:v1 $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$REPO:v1

# Step 5: Push
docker push $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$REPO:v1

# Step 6: Update Kubernetes deployment
kubectl set image deployment/watsonx-app \
  watsonx-app=$ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$REPO:v1 \
  -n watsonx
```

## Example 3: CI/CD Pipeline Snippet (GitHub Actions → ECR)

```yaml
name: Build and Push to ECR

on:
  push:
    branches: [main]

jobs:
  build-push:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: ap-south-1

      - name: Login to ECR
        id: ecr-login
        uses: aws-actions/amazon-ecr-login@v2

      - name: Build, tag, push
        env:
          REGISTRY: ${{ steps.ecr-login.outputs.registry }}
          REPO: watsonx-app
          IMAGE_TAG: ${{ github.sha }}
        run: |
          docker build -t $REGISTRY/$REPO:$IMAGE_TAG .
          docker push $REGISTRY/$REPO:$IMAGE_TAG
```

## Example 4: Real Incident - ImagePullBackOff on EKS (Watsonx)

**Scenario**: Deployment rollout got stuck, pods were in `ImagePullBackOff` state.

```bash
kubectl describe pod watsonx-app-7d9f8b-xk2p9 -n watsonx
```

**Output error**:
```
Failed to pull image "xxx.dkr.ecr.ap-south-1.amazonaws.com/watsonx-app:v23":
manifest for watsonx-app:v23 not found
```

**Root cause**: A tag mismatch in the CI pipeline - the build stage tagged it `v23`, but a typo in the actual push step pushed it as `v2.3`.

**Fix**:
```bash
# Verify correct tags available
aws ecr describe-images --repository-name watsonx-app --region ap-south-1 \
  --query 'imageDetails[*].imageTags'

# Correct the deployment manifest tag
kubectl set image deployment/watsonx-app \
  watsonx-app=xxx.dkr.ecr.ap-south-1.amazonaws.com/watsonx-app:v2.3 -n watsonx
```

**Lesson learned**: The CI pipeline should generate the semantic version from a single source of truth (e.g., git commit SHA or automated version bump), instead of manual typing.

## Example 5: Mirroring Docker Hub Image to ECR (Rate Limit Avoidance)

```bash
# Pull from Docker Hub
docker pull nginx:1.25

# Tag for ECR
docker tag nginx:1.25 $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/dockerhub-mirror/nginx:1.25

# Push to internal ECR mirror
docker push $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/dockerhub-mirror/nginx:1.25
```

Now EKS deployments can pull from `dockerhub-mirror/nginx:1.25` - avoiding Docker Hub's rate limit entirely.

---
⬅️ [commands.md](./commands.md) | ➡️ [interview-questions.md](./interview-questions.md)
