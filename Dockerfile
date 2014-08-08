# Agent + RTC components
#
# VERSION               0.0.1

FROM    denmat/oracle_base_65
MAINTAINER bkanyid "bradon@kanyid.org"

# Install repos for puppet and dependencies 
RUN rpm -ivh http://yum.puppetlabs.com/el/6/products/i386/puppetlabs-release-6-7.noarch.rpm
RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm

# Make sure the package repository is up to date
RUN yum -y update 

# Install puppet stuff
RUN yum install -y puppet 

# Install nice things
RUN yum install -y vim wget curl git tar unzip

# setup sshd
RUN yum install -y openssh-server openssh-clients
RUN echo 'root:root' | chpasswd
RUN sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config

## Suppress error message 'Could not load host key: ...'
RUN /usr/bin/ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -C '' -N ''
RUN /usr/bin/ssh-keygen -t rsa -f /etc/ssh/ssh_host_dsa_key -C '' -N ''

# Install Oracle JDK
RUN curl -LO 'http://download.oracle.com/otn-pub/java/jdk/7u51-b13/jdk-7u51-linux-x64.rpm' -H 'Cookie: oraclelicense=accept-securebackup-cookie' && rpm -i jdk-7u51-linux-x64.rpm
RUN rm jdk-7u51-linux-x64.rpm

# Install RTC 4.0.6 SCM tools
RUN wget http://ca-toronto-dl02.jazz.net/mirror/downloads/rational-team-concert/4.0.6/4.0.6/RTC-scmTools-Linux64-4.0.6.zip?tjazz=8a679iq497432X34f476w8m6kE4Q2u -O /root/RTC.zip
RUN unzip /root/RTC.zip -d /root/.jazzextract
RUN echo 'export PATH=/root/.jazzextract/jazz/scmtools/eclipse/:$PATH' >> /root/.bashrc

# Fix some jvm args with java 7 + RTC 4.0.6
RUN sed -i 's/-Xshareclasses:nonfatal/#-Xshareclasses:nonfatal/g' /root/.jazzextract/jazz/scmtools/eclipse/scm.ini
RUN sed -i 's/-Xquickstart/#-Xquickstart/g' /root/.jazzextract/jazz/scmtools/eclipse/scm.ini
RUN sed -i 's/-Xdump/#-Xdump/g' /root/.jazzextract/jazz/scmtools/eclipse/scm.ini

# Add startup script
ADD ./start.sh /root/

EXPOSE 22
CMD ["/bin/bash", "/root/start.sh"]
