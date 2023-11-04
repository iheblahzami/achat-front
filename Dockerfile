# Use an official Nginx base image as the base stage
FROM nginx:1.21 AS base

# Remove the default Nginx configuration
RUN rm /etc/nginx/conf.d/default.conf

# Copy your custom Nginx configuration file
COPY nginx.conf /etc/nginx/conf.d/

# Expose port 80 for web traffic
EXPOSE 80

# Use a multi-stage build to keep the final image small
FROM alpine:3.14 AS fetch

# Install the unzip utility (using apk in an Alpine-based image)
RUN apk update && apk add unzip && apk add curl unzip

# Create a directory to store the app build files
RUN mkdir /app

# Download the Angular app build from Nexus
RUN curl -o app.zip -L "http://192.168.222.133:8081/repository/achatfront/achat/1.0.0/-1.0.0.achat.zip"

# Unzip the app build into the /app directory
RUN unzip app.zip -d /app

# Use the Nginx image as the final stage
FROM base AS final

# Copy the Angular app build from the fetch stage
COPY --from=fetch /app /usr/share/nginx/html

ENTRYPOINT ["nginx", "-g", "daemon off;"]
