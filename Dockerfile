FROM fedora:latest

# creature comforts
ENV LANG en_US.UTF-8
ENV CONTAINER docker
ENV USER root
ENV HOME /root
ENV TERM xterm
WORKDIR /root
ADD bashrc /root/.bashrc

RUN dnf update -y && \
    dnf clean all

# install extra utilities
RUN dnf install -y gpg wget
# This sets up litecoin user
RUN groupadd -g 1000 litecoin && \
  useradd -u 1000 -g litecoin litecoin
ADD bashrc /home/litecoin/.bashrc

WORKDIR /opt

#EXPOSE 9393
#
RUN cd /opt && \
    /usr/bin/wget https://download.litecoin.org/litecoin-0.18.1/linux/litecoin-0.18.1-$(uname -m)-linux-gnu.tar.gz && \
    /usr/bin/wget https://download.litecoin.org/litecoin-0.18.1/linux/litecoin-0.18.1-$(uname -m)-linux-gnu.tar.gz.asc && \
    /usr/bin/gpg --recv-key FE3348877809386C && \
    /usr/bin/gpg --verify  litecoin-0.18.1-$(uname -m)-linux-gnu.tar.gz.asc && \
    /usr/bin/tar xvfz litecoin-0.18.1-$(uname -m)-linux-gnu.tar.gz && \
    /usr/bin/rm litecoin-0.18.1-$(uname -m)-linux-gnu.tar.gz litecoin-0.18.1-$(uname -m)-linux-gnu.tar.gz.asc

ADD start.sh /opt/start.sh
RUN chown -R litecoin.litecoin /opt/litecoin-0.18.1 /opt/start.sh
USER litecoin
ENV USER litecoin
ENV HOME /home/litecoin
ENV TERM xterm

CMD ["/opt/start.sh"]
