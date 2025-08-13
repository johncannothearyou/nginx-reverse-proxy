FROM nginx:alpine
RUN apk add --no-cache certbot certbot-nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY start-with-ssl.sh /start-with-ssl.sh
RUN chmod +x /start-with-ssl.sh
EXPOSE 80 443
ENTRYPOINT ["/start-with-ssl.sh"]
