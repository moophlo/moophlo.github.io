# Use PHP-FPM Alpine as the base image
FROM php:8.0-fpm-alpine

# Install nginx, curl, unzip, and other required packages
RUN apk add --no-cache nginx curl unzip

# Copy custom PHP configuration to override default limits
COPY custom-php.ini /usr/local/etc/php/conf.d/custom-php.ini

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Set working directory to the web root
RUN mkdir /var/www/rainloop
WORKDIR /var/www/rainloop

# Download and install RainLoop using the official installer script
RUN curl -sL https://repository.rainloop.net/installer.php | php


# Adjust ownership for the RainLoop data directory to allow persistence
RUN find /var/www/rainloop -type d -exec chmod 755 {} \; && \
    find /var/www/rainloop -type f -exec chmod 644 {} \; && \
    chown -R www-data:www-data /var/www/rainloop

# Copy entrypoint script and make it executable
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose port 80 for HTTP traffic
EXPOSE 80

# Use the custom entrypoint script to start both PHP-FPM and nginx
CMD ["/entrypoint.sh"]
