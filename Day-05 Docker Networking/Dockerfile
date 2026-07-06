# Use the official Nginx image
FROM nginx:latest

# Add a simple custom web page
RUN echo "<h1>Docker Networking Demo</h1><p>Container is running successfully!</p>" > /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]