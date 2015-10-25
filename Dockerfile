FROM centos:centos7

ENV container docker

    # Install systemd
    # For details, check out https://hub.docker.com/_/centos/
    RUN yum -y swap -- remove fakesystemd -- install systemd systemd-libs
    RUN yum -y update; yum clean all; \
    (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
    rm -f /lib/systemd/system/multi-user.target.wants/*;\
    rm -f /etc/systemd/system/*.wants/*;\
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*;\
    rm -f /lib/systemd/system/anaconda.target.wants/*;


RUN \
    # Install openssh server
    yum install openssh-server sudo -y && \

    # Generate host keys
    ssh-keygen -q -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa && \
    ssh-keygen -q -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa && \
    ssh-keygen -q -f /etc/ssh/ssh_host_ed25519_key -N '' -t ed25519 && \

    # Create /root/.ssh folder to be able to add the pub key to the authorized_keys file
    mkdir -p /root/.ssh

# Add our keypair
ADD id_rsa.pub /root/.ssh/authorized_keys
    
# This is needed as the container must access the hosts cgroups
VOLUME [ "/sys/fs/cgroup" ]

EXPOSE 22

CMD /usr/sbin/sshd -D
