# This container can provide an environment for building and running Swift applications.
# latest info on swift releases for linux are here: https://swift.org/download/#releases

FROM openshift/base-centos7

MAINTAINER Jason Dudash <jason.dudash@gmail.com>

EXPOSE 8080

ENV SWIFT_MAJOR_VERSION=3 \
    SWIFT_MINOR_VERSION=0 \
    SWIFT_PATCH_VERSION=2

ENV SWIFT_VERSION=${SWIFT_MAJOR_VERSION}.${SWIFT_MINOR_VERSION} \
    PATH=$PATH:/usr/local/usr/bin

LABEL io.k8s.description="Platform for building and running Swift applications" \
      io.k8s.display-name="Swift ${SWIFT_VERSION}" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,swift,swift${SWIFT_MAJOR_VERSION}${SWIFT_MINOR_VERSION}"

# Install toolchain
# https://swift.org/builds/swift-3.0.2-release/ubuntu1604/swift-3.0.2-RELEASE/swift-3.0.2-RELEASE-ubuntu16.04.tar.gz
RUN yum install -y centos-release-scl && \
    INSTALL_PKGS="clang libicu-devel" && \
    yum install -y --setopt=tsflags=nodocs --enablerepo=centosplus $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all -y && \
    (curl -L https://swift.org/builds/swift-3.0.2-release/ubuntu1604/swift-3.0.2-RELEASE/swift-3.0.2-RELEASE-ubuntu16.04.tar.gz | \
        tar -xz -C /usr/local) \

# Copy the S2I scripts from the specific language image to $STI_SCRIPTS_PATH
COPY ./s2i/ $STI_SCRIPTS_PATH
USER 1001
CMD $STI_SCRIPTS_PATH/usage