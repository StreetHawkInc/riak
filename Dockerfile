FROM debian:buster
RUN apt-get update && apt-get --assume-yes upgrade
RUN apt-get --assume-yes install build-essential autoconf libncurses5-dev openssl libssl-dev fop xsltproc unixodbc-dev git curl
RUN curl https://raw.githubusercontent.com/kerl/kerl/master/kerl > /usr/bin/kerl
RUN chmod a+x /usr/bin/kerl
RUN kerl build git git://github.com/basho/otp.git OTP_R16B02_basho10 R16B02-basho10
RUN kerl install R16B02-basho10 ~/erlang/R16B02-basho10
SHELL ["/bin/bash", "-c", "source ~/erlang/R16B02-basho10/activate"]
RUN mkdir -p /opt/riak/
ADD . /opt/riak/
WORKDIR /opt/riak/
RUN make deps
RUN make
#RUN make test