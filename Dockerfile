FROM ubuntu:18.04

USER root

# change root password to `ubuntu`
RUN echo 'root:ubuntu' | chpasswd

ENV DEBIAN_FRONTEND noninteractive

# install ssh server
RUN \
	apt-get update && \
	apt-get install -y openssh-server sudo curl && \
	rm -rf /var/lib/apt/lists/*

# workdir for ssh
RUN mkdir -p /run/sshd

# generate server keys
RUN ssh-keygen -A

# allow root to login
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
RUN sed -i 's/#Port 22/Port 8822/g' /etc/ssh/sshd_config

EXPOSE 8822

# run ssh server
CMD ["/usr/sbin/sshd", "-D", "-o", "ListenAddress=0.0.0.0"]
