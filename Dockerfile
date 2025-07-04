FROM ubuntu:22.04

# Set noninteractive mode and time zone
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Kolkata

# Update mirrors, install required packages, and configure timezone
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    sed -i 's|http://archive.ubuntu.com/ubuntu/|http://mirror.math.princeton.edu/pub/ubuntu/|g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y tzdata apache2 curl wget && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ADD index.html /var/www/html
# Expose Apache HTTP port
EXPOSE 80

# Run Apache in foreground
CMD ["apachectl", "-D", "FOREGROUND"]
