FROM --platform=linux/amd64 nginx:alpine

# Copy HTML and CSS files to the nginx web directory
COPY index.html /usr/share/nginx/html/index.html
COPY styles.css /usr/share/nginx/html/styles.css

# Copy custom NGINX configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Expose a custom port
EXPOSE 8888

# Run nginx on custom port 8888
CMD ["nginx", "-g", "daemon off;"]
