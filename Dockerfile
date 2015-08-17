FROM java:openjdk-7-jre
MAINTAINER Attila Maczak attila@maczak.hu

RUN apt-get update -y && apt-get install -y git

RUN wget -O /tmp/go-agent.deb http://download.go.cd/gocd-deb/go-agent-15.2.0-2248.deb
RUN dpkg -i /tmp/go-agent.deb
RUN rm /tmp/go-agent.deb


VOLUME ["/var/lib/go-agent"]

RUN sed -r -i "s/^(GO_SERVER)=(.*)/\1=\$SERVER_PORT_8153_TCP_ADDR/g" /etc/default/go-agent

CMD /usr/lib/jvm/java-7-openjdk-amd64/bin/java -jar /usr/share/go-agent/agent-bootstrapper.jar $SERVER_PORT_8153_TCP_ADDR $SERVER_PORT_8153_TCP_PORT
