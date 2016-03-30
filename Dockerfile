# Use ARM Ubunutu base image
FROM armv7/armhf-ubuntu:14.10
MAINTAINER Barry Williams <barry.e.williams42@gmail.com>

# Install dependencies
RUN apt-get update && apt-get install -y build-essential g++ curl libssl-dev apache2-utils git libxml2-dev sshfs python2.7
RUN ln -s /usr/bin/python2.7 /usr/bin/python

# Add cloud9ide user
RUN useradd -m cloud9ide

# Install cloud9ide
RUN runuser -l cloud9ide -c 'git clone https://github.com/c9/core.git /home/cloud9ide/cloud9'
ADD install-c9.sh /tmp/install-c9.sh
#todo add install script directly to users home dir
RUN mv /tmp/install-c9.sh /home/cloud9ide/ && chown cloud9ide:cloud9ide /home/cloud9ide/install-c9.sh
RUN runuser -l cloud9ide -c 'cd /home/cloud9ide/ && ./install-c9.sh'

# Update config
RUN runuser -l cloud9ide -c "sed -i -e 's_127.0.0.1_0.0.0.0_g' /home/cloud9ide/cloud9/configs/standalone.js"

# Add workspace directory
RUN mkdir /workspace && chown cloud9ide /workspace

# Cleanup apt-get
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#Expose ports: Note port 8080 - node is not run as root
EXPOSE 8080
EXPOSE 3000

# Setup entrypoint
ADD entrypoint.sh /entrypoint.sh
RUN chmod u+x /entrypoint.sh
CMD ["/entrypoint.sh"]
