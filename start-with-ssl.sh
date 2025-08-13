#!/bin/sh

# Stop nginx if it's running
nginx -s stop || echo "Nginx is not running, proceeding with certificate generation."

# Check if certificates exist, if not, run the init script
if [ ! -d "/etc/letsencrypt/live/johncannothearyou.com" ]; then
    domain="johncannothearyou.com"
    email="johncannothearyou@gmail.com"

    # Get the certificate
    certbot certonly --standalone \
                        --agree-tos \
                        --non-interactive \
                        --email $email \
                        --domain $domain \
                        --domain www.$domain \
fi

if [ ! -d "/etc/letsencrypt/live/immich.johncannothearyou.com" ]; then
    domain="immich.johncannothearyou.com"
    email="immich.johncannothearyou@gmail.com"

    # Get the certificate
    certbot certonly --standalone \
                        --agree-tos \
                        --non-interactive \
                        --email $email \
                        --domain $domain \
                        --domain www.$domain \
fi

# Add a cron job to renew the certificate
echo "0 12 * * * certbot renew --quiet" | crontab -

# Start Nginx
nginx -g "daemon off;"
