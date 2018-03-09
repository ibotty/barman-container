FROM centos:7
MAINTAINER Tobias Florek <tob@butter.sh>
USER 0

ENV PGREPO=https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-7-x86_64/pgdg-centos10-10-2.noarch.rpm \
    HOME=/var/lib/barman \
    PATH=/usr/pgsql-10/bin:$PATH

RUN yum install -y --setopt=tsflags=nodocs epel-release "$PGREPO"  \
 && yum install -y --setopt=tsflags=nodocs \
        barman barman-cli postgresql10 postgresql10-server \
        rsync openssh openssh-server nss_wrapper cronie \
 && yum clean all \
 && chmod a+rwX /var/lib/barman /var/log/barman /etc/barman.conf /etc/barman.d \
 && test "$(id -u barman)" -eq 997

COPY libexec/* /usr/libexec/barman-container/

USER 997
ENTRYPOINT ["/usr/libexec/barman-container/entrypoint"]
CMD ["run"]
