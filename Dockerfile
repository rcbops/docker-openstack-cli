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
  && pip install --no-cache-dir pip setuptools \
  && pip install --no-cache-dir python-openstackclient==3.11.0 python-neutronclient==6.3.0 \
  && apk del gcc musl-dev linux-headers \
  && rm -rf /var/cache/apk/*

# Add a volume so that a host filesystem can be mounted .
# e.g. docker run -v ${PWD}:/data jmcvea/openstack-client
VOLUME ["/data"]

# Default is to start a shell. A more common behavior would be to override the command when starting.
# e.g. docker run -ti jmcvea/openstack-client openstack server list
CMD ["/bin/sh"]
