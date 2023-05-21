# Use a lightweight base image
FROM nginx:alpine

# Copy the index.html file to the appropriate location in the container
COPY index.html /usr/share/nginx/html/

# Expose port 80 to allow incoming traffic
EXPOSE 80

# Start the NGINX server when the container launches
CMD ["nginx", "-g", "daemon off;"]
