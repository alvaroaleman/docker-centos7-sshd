FROM centos:centos7

RUN \
    # Ensure we are up to date
    yum update -y && \

    # Install openssh server
    yum install openssh-server sudo -y && \

    # Generate host keys
    ssh-keygen -q -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa && \
    ssh-keygen -q -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa && \
    ssh-keygen -q -f /etc/ssh/ssh_host_ed25519_key -N '' -t ed25519 && \

    # Create /root/.ssh folder to be able to add the pub key to the authorized_keys file
    mkdir -p /root/.ssh

ADD id_rsa.pub /root/.ssh/authorized_keys
    

EXPOSE 22

CMD /usr/sbin/sshd -D
