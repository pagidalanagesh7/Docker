# Minimal, optimized Nginx image for serving static content
FROM nginx:1.27-alpine

# Copy static site content into Nginx's default serving directory
COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
