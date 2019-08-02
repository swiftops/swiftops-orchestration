FROM ubuntu:16.04

LABEL maintainer="deepak@digite.com"

# Set the debconf frontend to Noninteractive
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update && apt-get install -y --no-install-recommends -q wget apt-transport-https curl unzip lsb-release runit

RUN wget http://nginx.org/keys/nginx_signing.key
RUN apt-key add nginx_signing.key
RUN rm nginx_signing.key
RUN printf "deb http://nginx.org/packages/mainline/ubuntu/ xenial nginx\\n" | tee /etc/apt/sources.list.d/nginx.list

# Install NGINX OSS mainline version
RUN apt-get update && apt-get install -y --no-install-recommends nginx \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# forward request logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 443

ENV CT_URL https://releases.hashicorp.com/consul-template/0.15.0/consul-template_0.15.0_linux_amd64.zip
RUN curl -O $CT_URL && unzip consul-template_0.15.0_linux_amd64.zip -d /usr/local/bin

COPY nginx.service /etc/service/nginx/run
COPY consul-template.service /etc/service/consul-template/run
RUN chmod +x /etc/service/nginx/run
RUN chmod +x /etc/service/consul-template/run

RUN rm -v /etc/nginx/conf.d/*
COPY nginx.conf /etc/consul-templates/nginx.conf
COPY index.html /etc/consul-templates/index.html
COPY logo.png /usr/share/nginx/html/logo.png
COPY digite.com.crt /etc/nginx/digite.com.crt
COPY digite.com.key /etc/nginx/digite.com.key

CMD ["/usr/bin/runsvdir", "/etc/service"]
