## Build/Destroy terraform resources

```
cd tf_code
terraform init -input=false
terraform apply -input=false -auto-approve
terraform destroy -input=false -auto-approve
```

## start atlantis container
```
# follow steps at: https://www.runatlantis.io/guide/testing-locally.html#install-terraform

# start atlantis container
docker-compose up
```
