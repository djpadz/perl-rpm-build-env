FROM centos:6.6

ENV TERM=vt100 LESS=-i\ -R

ENTRYPOINT [ "/bin/bash", "-l" ]

WORKDIR "/root"

RUN yum install -y rpm-build openssh-clients tar gcc gcc-c++ openssl-devel perl-*

ADD root/ /

RUN cpan Test::More Pod::PlainText Getopt::ArgvFile Bundle::CPAN JSON::XS

RUN useradd -N -M -d /Users/djpadz djpadz

RUN mkdir -p /root/rpm/SRPMS /root/rpm/BUILD /root/rpm/SOURCES /root/rpm/SPECS /root/rpm/RPMS

RUN ln -s /root/rpm/RPMS /RPMS
