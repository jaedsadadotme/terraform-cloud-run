# Terraform Cloud Run

### Require
- gcp auth
- terraform

### Init
```sh
$ terraform init
```

### Plan the code
```sh
$ terraform plan -var key_path=<key.json>
```

### Apply
```sh
$ terraform apply -var key_path=<key.json> --auto-approve
```

### Delete (Optional)
```sh
$ terraform destroy --auto-approve 
```