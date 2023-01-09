### Remember that anyone who can access the Docker socket can trivially root the entire host; 
## running this command allows any local process to do that
## WARNING ##   sudo chmod 666 /var/run/docker.sock  
#sudo usermod -aG docker ${USER}
## Change the permissions of /var/run/docker.sock for the current user.
#sudo chown $USER /var/run/docker.sock


## Remove running processes
#sudo aa-remove-unknown
##sudo lsof -i -P -n | grep LISTEN
#sudo lsof -t -i:443
#systemctl status docker

####### Build and run ORACLE container
# docker build -t ol9_dragen:latest .
# docker run -dit --name dragen ol9_dragen:latest


## execute command from docker to conatiner
## docker exec -it ol7_slim_con ls

# ------------------------------------------------------------------------------
# Dockerfile to build basic Oracle Linux container images
# Based on Oracle Linux 9 - Slim
# ------------------------------------------------------------------------------

# Set the base image to Oracle Linux 7 - Slim
#FROM oraclelinux:9-slim
#FROM oraclelinux:9
FROM centos:7
# File Author / Maintainer
# Use LABEL rather than deprecated MAINTAINER
# MAINTAINER Tim Hall (tim@oracle-base.com)
LABEL maintainer="kmezhoud@gmail.com"


# ------------------------------------------------------------------------------
# enable ssh login
RUN yum -y install openssh-server ed openssh-clients tlog glibc-langpack-en && \
    yum clean all && systemctl enable sshd;
RUN sed -i 's/#Port.*$/Port 2022/' /etc/ssh/sshd_config && \
    chmod 775 /var/run && \
    rm -f /var/run/nologin
RUN mkdir /etc/systemd/system/sshd.service.d/ && \
    echo -e '[Service]\nRestart=always' > /etc/systemd/system/sshd.service.d/sshd.conf

RUN yum -y install systemd; yum clean all;

# install network tools ifconfig
RUN yum -y install net-tools
#RUN yum update  && yum -y install sudo 
#    && yum -y install awk \ 
#    && yum -y install dirname \
#    && yum -y install grep #\
#    && yum -y install md5sum \
#    && yum -y install rpm \
#    && yum -y install sort \
#    && yum -y install tr \
#    && yum -y install logger \
#    && yum -y install sed
    #awk dirname grep md5sum rpm sort tr logger sed

#RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo

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


COPY dragen-4.0.3-8.el7.x86_64.run /${ORACLE_HOME}
WORKDIR /${ORACLE_HOME}

#CMD sudo sh dragen-4.0.3-8.el7.x86_64.run


# End