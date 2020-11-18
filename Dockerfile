FROM quay.io/podman/stable AS podman

FROM jenkins/jnlp-slave:latest
USER root
RUN apt-get update && apt-get install -yq iptables uidmap && apt-get clean
RUN mkdir -p /home/jenkins/.local/share/containers/storage \
	&& chown -R jenkins:jenkins /home/jenkins
COPY containers.conf storage.conf /etc/containers/
VOLUME /home/jenkins/.local/share/containers/storage
COPY entrypoint.sh /
COPY docker /usr/local/bin/
ENTRYPOINT [ "/entrypoint.sh" ]
