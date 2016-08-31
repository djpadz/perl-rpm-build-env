FROM centos:6.6

ENV TERM=vt100 LESS=-i\ -R

RUN yum install -y perl-CPAN perl-libwww-perl rpm-build openssh-clients tar perl-YAML perl-IO-Socket-SSL perl-parent perl-Readonly gcc gcc-c++ openssl-devel

RUN \
	echo yes | cpan; perl -MCPAN -e 'my $c = "CPAN::HandleConfig"; $c->load(doit => 1, autoconfig => 1); $c->edit(prerequisites_policy => "follow"); $c->edit(build_requires_install_policy => "yes"); $c->commit'

RUN cpan Test::More Pod::PlainText Getopt::ArgvFile

RUN cpan Crypt::OpenSSL::RSA JSON::XS Date::Parse Types::Serialiser

ADD root/ /

RUN mkdir -p /root/rpm/SRPMS /root/rpm/BUILD /root/rpm/SOURCES /root/rpm/SPECS /root/rpm/RPMS
