#!/bin/bash
# Bootstrap Let's Encrypt certificates for nmalic.xyz
# Run this ONCE on first deploy before starting the full stack.

set -e

DOMAIN="nmalic.xyz"
EMAIL="admin@nmalic.xyz"   # <-- change to your real email
STAGING=0                   # Set to 1 for testing to avoid rate limits

RSA_KEY_SIZE=4096
DATA_PATH="./certbot"

# Download recommended TLS parameters
if [ ! -e "$DATA_PATH/conf/options-ssl-nginx.conf" ] || \
   [ ! -e "$DATA_PATH/conf/ssl-dhparams.pem" ]; then
  echo "### Downloading recommended TLS parameters ..."
  mkdir -p "$DATA_PATH/conf"
  curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot-nginx/certbot_nginx/_internal/tls_configs/options-ssl-nginx.conf \
    > "$DATA_PATH/conf/options-ssl-nginx.conf"
  curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot/certbot/ssl-dhparams.pem \
    > "$DATA_PATH/conf/ssl-dhparams.pem"
fi

# Create dummy certificate so nginx can start
echo "### Creating dummy certificate for $DOMAIN ..."
LIVE_PATH="$DATA_PATH/conf/live/$DOMAIN"
mkdir -p "$LIVE_PATH"
docker run --rm \
  -v "$(pwd)/$DATA_PATH/conf:/etc/letsencrypt" \
  certbot/certbot \
  certonly --standalone --non-interactive \
  --agree-tos --email "$EMAIL" \
  -d "$DOMAIN" -d "www.$DOMAIN" \
  2>/dev/null || \
docker run --rm \
  -v "$(pwd)/$DATA_PATH/conf:/etc/letsencrypt" \
  certonly --force-renewal \
  2>/dev/null || true

# Generate self-signed dummy cert if certbot failed (nginx needs it to start)
if [ ! -f "$LIVE_PATH/fullchain.pem" ]; then
  echo "### Generating temporary self-signed certificate ..."
  docker run --rm \
    -v "$(pwd)/$LIVE_PATH:/certs" \
    alpine sh -c "
      apk add --no-cache openssl &&
      openssl req -x509 -nodes -newkey rsa:$RSA_KEY_SIZE -days 1 \
        -keyout /certs/privkey.pem \
        -out /certs/fullchain.pem \
        -subj '/CN=localhost'
    "
  cp "$LIVE_PATH/fullchain.pem" "$LIVE_PATH/chain.pem"
fi

# Start nginx only (to answer ACME HTTP challenge)
echo "### Starting nginx ..."
docker compose up --force-recreate -d app

# Wait for nginx to be ready
sleep 5

# Obtain real Let's Encrypt certificate
echo "### Requesting Let's Encrypt certificate for $DOMAIN ..."
STAGING_ARG=""
if [ "$STAGING" = "1" ]; then
  STAGING_ARG="--staging"
fi

docker compose run --rm certbot certonly \
  --webroot \
  --webroot-path=/var/www/certbot \
  $STAGING_ARG \
  --email "$EMAIL" \
  --agree-tos \
  --no-eff-email \
  --force-renewal \
  -d "$DOMAIN" -d "www.$DOMAIN"

# Reload nginx with real certs
echo "### Reloading nginx ..."
docker compose exec app nginx -s reload

echo "### Done! Starting full stack ..."
docker compose up -d
