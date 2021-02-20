FROM tiangolo/nginx-rtmp

COPY nginx-template.conf /nginx-template.conf

# etc/nginx/nginx.conf
COPY prepare.sh /prepare.sh
RUN sed -i 's/\r$//' /prepare.sh
RUN chmod +x /prepare.sh
CMD /prepare.sh && "nginx" "-g" "daemon off;"