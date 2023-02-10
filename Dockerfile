### Remember that anyone who can access the Docker socket can trivially root the entire host; 
## running this command allows any local process to do that
## WARNING ##   sudo chmod 666 /var/run/docker.sock  
#sudo usermod -aG docker ${USER}
## Change the permissions of /var/run/docker.sock for the current user.
#sudo chown $USER /var/run/docker.sock

# Extract installer file
#sh  dragen-4.0.3-8.el7.x86_64.run --noexec --target Dragen_bkp

## Remove running processes
#sudo aa-remove-unknown
##sudo lsof -i -P -n | grep LISTEN
#sudo lsof -t -i:443
#systemctl status docker

## Build  OL8 iso with dragen installer
#docker build -t ol8_ill_drag_el8:latest .

## run image interactively
# docker run -h ol8_illu_drag_el8 -i -t ol8_illu_drag_el8:latest bash
## run it and detach
# docker run dit --name ol8_illu_drag_el8  ol8_illu_drag_el8:latest

## execute command from docker to conatiner
## docker exec -it ol8_illu_drag_el8 ls
## docker attach ol8_illu_drag_el8

# ------------------------------------------------------------------------------
# Dockerfile to build basic Oracle Linux container images
# Based on Oracle Linux 9 - Slim
# ------------------------------------------------------------------------------

# Set the base image to Oracle Linux 7 - Slim
#FROM oraclelinux:9-slim
#FROM oraclelinux:9
#FROM centos:7
FROM ol8_illumina
# File Author / Maintainer
# Use LABEL rather than deprecated MAINTAINER
# MAINTAINER Tim Hall (tim@oracle-base.com)
LABEL maintainer="kmezhoud@gmail.com"


# ------------------------------------------------------------------------------
# enable ssh root login
RUN apt-get -y update && \
    apt-get install -y apt-utils && \
    apt-get install -y vim && \
    apt-get install -y openssh-server && \
    echo 'root:mypassword' | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    ssh-keygen -t rsa
    #Copy the public key to the remote systems that the UAA is managing:
    #scp ~/.ssh/id_rsa.pub <remote machine>
    #Log in to the remote systems and import the public key to the authorize keys.
    #cat <Uploaded id_rsa.pub> >> ~/.ssh/authorized_keys
    #or
    # ssh-copy-id remote_host

# install network tools ifconfig
#RUN apt-get -y install net-tools;

# install rpm Python2
#RUN apt-get install -y python2 && \
#    apt-get -y install rpm;

RUN apt-get clean all;
    

# ------------------------------------------------------------------------------
# Define the build arguments, setting default values.
ARG ORACLE_HOME=/home_dragen  
ARG DATA_LOCATION=/data_dragen

# ------------------------------------------------------------------------------
# Define the environment variables, setting default values using the arguments.
ENV ORACLE_HOME=${ORACLE_HOME} \
    DATA_LOCATION=${DATA_LOCATION}
    
# ------------------------------------------------------------------------------
RUN mkdir -p ${ORACLE_HOME} && \
    mkdir -p ${DATA_LOCATION}


#COPY dragen-4.0.3-8.el7.x86_64.run /${ORACLE_HOME}
COPY dragen-4.0.3-8.el8.x86_64.run /${ORACLE_HOME}
WORKDIR /${ORACLE_HOME}

#CMD sudo sh dragen-4.0.3-8.el7.x86_64.run


#EXPOSE 22
# start sshr service
ENTRYPOINT service ssh restart && bash
CMD ["/usr/sbin/sshd", "-D"]