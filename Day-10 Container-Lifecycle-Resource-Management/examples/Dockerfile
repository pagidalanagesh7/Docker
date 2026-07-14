FROM nginx:alpine

# Copy static content (example)
COPY ./html /usr/share/nginx/html

# Health check - Docker equivalent of a K8s liveness probe
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD curl -f http://localhost/ || exit 1

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
