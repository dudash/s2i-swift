Swift source-to-image
====================
<img src="https://swift.org/assets/images/swift.svg" alt="Swift logo" height="70" >

This repository contains the source for building Swift applications as reproducible Docker images using [source-to-image](https://github.com/openshift/source-to-image).

For more information about using these images with OpenShift, please see the
official [OpenShift Documentation](https://docs.openshift.org/latest/architecture/core_concepts/builds_and_image_streams.html#source-build).

For more information about the open source Swift programming language goto the [Swift website][https://swift.org]

Versions
---------------
Swift versions available
* Swift 3.0

OS versions available
* CentOS 7

Installation
---------------
To prepare the s2i builder image:
```shell
$ git clone https://github.com/dudash/s2i-swift.git
$ cd s2i-swift
$ make build VERSION=3.0
```

Repo Organization
---------------
 <pre>
**[swift-version]**: Dockerfile to build container images from
**[swift-version/test/test-app]**: Sample application used for tests
**hack/**: Folder containing scripts which are responsible for the build and test actions performed by the Makefile
**s2i/**: Build scripts which will be injected into the builder image and executed during application source code builds
</pre>

Use
---------------
Use the `s2i` tool to build the final image that contains your application code:
```shell
$ s2i build ./3.0/test/test-app/ openshift/swift-30-centos7 swift-test-app
```
* `./3.0/test/test-app/` is the top directory of your source code.
* `openshift/swift-30-centos7` is the name of the s2i builder image created by `make build` above.
* `swift-test-app` is the name of the new application image that contains your app built from source code.

Finally, run can run the test application image to see that it worked:
```shell
$ docker run swift-test-app
```

Versions
---------------
Swift versions currently supported:
* 3.0.x