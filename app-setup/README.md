# Rebtel Web Application Setup

This README documents the steps I took to set up the Rebtel web application using Kubernetes and NGINX Ingress Controller. 

## Folder Structure
```
.
├── app-config
│   ├── Dockerfile
│   ├── index.html
│   ├── nginx.conf
│   └── styles.css
└── kube-resources
    ├── cluster-issuer.yaml
    ├── nginx-ingress-controller-values.yaml
    ├── rebtel-web-app.yaml
    └── rebtel-web-ingress.yaml
```


## Steps Taken for Setup

### 1. Install NGINX Ingress Controller

To set up the NGINX Ingress Controller, I followed these steps:

- Created the controller using DaemonSet.
- Added a side container to the controller, limiting its resource usage to a maximum of 0.2 cores and 256 mI.
- Created a volume for NGINX logs, which was shared between both the controller and the side container.
- Enabled the Web Application Firewall (WAF) with OWASP ModSecurity CRSs in blocking mode.

Here are the commands I executed:

```
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
helm repo add nginx-ingress-controller https://kubernetes.github.io/ingress-nginx
helm repo update
helm install nginx-ingress-controller nginx-ingress-controller/ingress-nginx -f kube-resources/nginx-ingress-controller-values.yaml --namespace nginx-ingress-controller --create-namespace
```

### 2. Build and Deploy Docker Image

Next, I created a hardened Docker image containing a simple web page and uploaded it to my container registry. I ensured the requirements outlined to setup the deployment:

The following commands were used for these tasks:
```
aws ecr create-repository --repository-name rebtel-web-image --region eu-central-1 --profile aws-admin
aws ecr get-login-password --region eu-central-1 --profile aws-admin | docker login --username AWS --password-stdin 552601825397.dkr.ecr.eu-central-1.amazonaws.com
docker build --platform linux/amd64 -t rebtel-web-image:latest . 
docker tag rebtel-web-image:latest 552601825397.dkr.ecr.eu-central-1.amazonaws.com/rebtel-web-image:latest 
docker push 552601825397.dkr.ecr.eu-central-1.amazonaws.com/rebtel-web-image:latest
```

### 3. Set Up Domain and TLS
I registered a free domain at noip.com with the hostname https://nazimfs-rebtel.hopto.org/. To secure the domain, I performed the following steps:

- Installed the cert-manager Helm chart to create a Let's Encrypt cluster issuer for my wildcard domain.
- Configured an Ingress for my application using the wildcard certificate and pointed it to the subdomain created earlier.

The commands i used were:
```
helm repo add jetstack https://charts.jetstack.io
helm repo update
kubectl create namespace cert-manager
helm install cert-manager jetstack/cert-manager --namespace cert-manager --version v1.11.0 --set installCRDs=true
kubectl apply -f cluster-issuer.yaml
kubectl apply -f rebtel-web-ingress.yaml
```

The application can now be accessed at: https://nazimfs-rebtel.hopto.org/.

## Verification
To verify the setup, I checked the following:

- The SSL Labs score for the domain, which returned an A+ rating (as shown in the image file `SSL_Lab_Score.png`)
- I also performed a script injection test, which returned a 403 Forbidden response, confirming that the WAF is functioning properly:
```
curl 'https://nazimfs-rebtel.hopto.org//?q="><script>alert(1)</script>'
<html>
<head><title>403 Forbidden</title></head>
<body>
<center><h1>403 Forbidden</h1></center>
<hr><center>nginx</center>
</body>
</html>
```
