FROM centos:centos7

MAINTAINER Red Hat, Inc. <container-tools@redhat.com>

LABEL io.projectatomic.nulecule.atomicappversion="0.1.11" \
      RUN="docker run -it --rm \${OPT1} --privileged -v `pwd`:/atomicapp -v /run:/run -v /:/host --net=host --name \${NAME} -e NAME=\${NAME} -e IMAGE=\${IMAGE} \${IMAGE} -v \${OPT2} run \${OPT3} /atomicapp" \
      STOP="docker run -it --rm \${OPT1} --privileged -v `pwd`:/atomicapp -v /run:/run -v /:/host --net=host --name \${NAME} -e NAME=\${NAME} -e IMAGE=\${IMAGE} \${IMAGE} -v \${OPT2} stop \${OPT3} /atomicapp" \
      INSTALL="docker run -it --rm \${OPT1} --privileged -v `pwd`:/atomicapp -v /run:/run  --name \${NAME} -e NAME=\${NAME} -e IMAGE=\${IMAGE} \${IMAGE} -v \${OPT2} install \${OPT3} --destination /atomicapp /application-entity"


# add EPEL repo for pip
RUN echo -e "[epel]\nname=epel\nenabled=1\nbaseurl=https://dl.fedoraproject.org/pub/epel/7/x86_64/\ngpgcheck=0" > /etc/yum.repos.d/epel.repo
RUN echo -e "[epel-testing]\nname=epel-testing\nenabled=1\nbaseurl=https://dl.fedoraproject.org/pub/epel/testing/7/x86_64/\ngpgcheck=0" > /etc/yum.repos.d/epel-testing.repo

RUN yum install -y atomicapp --setopt=tsflags=nodocs && \
    yum clean all

# the entrypoint
ENTRYPOINT ["/usr/bin/atomicapp"]
