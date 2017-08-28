FROM phusion/baseimage:latest

# This is in accordance to : https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-get-on-ubuntu-16-04
RUN apt-get update && \
	apt-get install -y openjdk-8-jdk && \
	apt-get install -y ant && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/cache/oracle-jdk8-installer;


# Fix certificate issues, found as of 
# https://bugs.launchpad.net/ubuntu/+source/ca-certificates-java/+bug/983302
RUN apt-get update && \
	apt-get install -y ca-certificates-java && \
	apt-get clean && \
	update-ca-certificates -f && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/cache/oracle-jdk8-installer;

RUN apt-get update && \
	apt-get install -y git;

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Setup JAVA_HOME, this is useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

RUN cd opt && git clone https://github.com/linkedin/ambry.git

WORKDIR /opt/ambry/target

RUN cd /opt/ambry && ./gradlew allJar

RUN mkdir logs

EXPOSE 1174
EXPOSE 1175

RUN mkdir /etc/service/ambry
ADD ambry.sh /etc/service/ambry/run
RUN chmod +x /etc/service/ambry/run

CMD ["/sbin/my_init"]

