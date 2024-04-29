# Deploy
To deploy: 
```shell
cd platform
terraform init 
terraform apply --auto-approve
```

# Demo
Once deployed

1. Connect to consul-backend and start the sidecar
```shell
consul connect proxy -sidecar-for webapp-backend-01 > webapp-backend.log &
```

2. Connect to consul-frontend and start the sidecar
```shell
consul connect proxy -sidecar-for webapp-frontend-01 > webapp-frontend.log &
```
 - To test that the proxy is working
    ```shell
    curl localhost:5000 # This should return "Hello from backend". 
    ```

3. To see the consul UI
```shell
<public_dns_of_server_1>:8500
```