# Docker Registry - Commands 🖥️

## 1. Docker Hub Commands

### Login
```bash
docker login
# Prompts for username/password or access token
docker login -u nagesh -p <access_token>
```

### Tag an Image
```bash
docker tag myapp:v1 nagesh/myapp:v1
# format: docker tag <local-image>:<tag> <dockerhub-username>/<repo>:<tag>
```

### Push
```bash
docker push nagesh/myapp:v1
```

### Pull
```bash
docker pull nagesh/myapp:v1
```

### Logout
```bash
docker logout
```

## 2. AWS ECR Commands (Watsonx/EKS Context)

### Authenticate to ECR
```bash
aws ecr get-login-password --region ap-south-1 | \
docker login --username AWS --password-stdin \
<account-id>.dkr.ecr.ap-south-1.amazonaws.com
```

### Create a Repository
```bash
aws ecr create-repository \
  --repository-name watsonx-app \
  --region ap-south-1 \
  --image-scanning-configuration scanOnPush=true
```

### Tag Image for ECR
```bash
docker tag watsonx-app:v1 \
<account-id>.dkr.ecr.ap-south-1.amazonaws.com/watsonx-app:v1
```

### Push to ECR
```bash
docker push <account-id>.dkr.ecr.ap-south-1.amazonaws.com/watsonx-app:v1
```

### Pull from ECR
```bash
docker pull <account-id>.dkr.ecr.ap-south-1.amazonaws.com/watsonx-app:v1
```

### List Images in Repo
```bash
aws ecr describe-images --repository-name watsonx-app --region ap-south-1
```

### List All Tags
```bash
aws ecr list-images --repository-name watsonx-app --region ap-south-1
```

### Delete an Image Tag
```bash
aws ecr batch-delete-image \
  --repository-name watsonx-app \
  --image-ids imageTag=v1
```

### Set Lifecycle Policy (auto-cleanup old images)
```bash
aws ecr put-lifecycle-policy \
  --repository-name watsonx-app \
  --lifecycle-policy-text file://lifecycle-policy.json
```

Example `lifecycle-policy.json`:
```json
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Expire images older than 30 days",
      "selection": {
        "tagStatus": "untagged",
        "countType": "sinceImagePushed",
        "countUnit": "days",
        "countNumber": 30
      },
      "action": { "type": "expire" }
    }
  ]
}
```

## 3. Generic/Useful Commands

### Inspect image manifest
```bash
docker manifest inspect nginx:latest
```

### Check image digest
```bash
docker images --digests
```

### Save image as tar (offline transfer, no registry)
```bash
docker save -o myapp.tar myapp:v1
docker load -i myapp.tar
```

### Remove local image
```bash
docker rmi nagesh/myapp:v1
```

### List all images pulled locally
```bash
docker images
```

## 4. Kubernetes Pull Secret for Private Registry

To pull from a private ECR/Docker Hub repo in EKS (though IAM role usually gives direct access with ECR):

```bash
kubectl create secret docker-registry regcred \
  --docker-server=<account-id>.dkr.ecr.ap-south-1.amazonaws.com \
  --docker-username=AWS \
  --docker-password=$(aws ecr get-login-password --region ap-south-1) \
  --namespace=watsonx
```

Then in pod spec:
```yaml
spec:
  imagePullSecrets:
    - name: regcred
```

---
⬅️ [dockerhub.md](./dockerhub.md) | ➡️ [examples.md](./examples.md)
