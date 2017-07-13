FROM alpine:3.6

RUN apk add --update \
  python-dev \
  py-pip \
  py-setuptools \
  ca-certificates \
  gcc \
  musl-dev \
  linux-headers \
  jq \
  bash \
  && pip install --no-cache-dir pip setuptools \
  && pip install --no-cache-dir python-openstackclient==3.11.0 \
  && pip install --no-cache-dir python-neutronclient==6.3.0  \
  && pip install --no-cache-dir python-designateclient==2.6.0 \
  && apk del gcc musl-dev linux-headers \
  && rm -rf /var/cache/apk/*

# Add a volume so that a host filesystem can be mounted .
# e.g. docker run -v ${PWD}:/data jmcvea/openstack-client
VOLUME ["/data"]

ENV PS1="\W $ "

# Default is to start a shell. A more common behavior would be to override the command when starting.
# e.g. docker run -ti jmcvea/openstack-client openstack server list
CMD ["/bin/bash"]
