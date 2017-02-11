Swift source-to-image
====================
<img src="https://swift.org/assets/images/swift.svg" alt="Swift logo" height="70" >
<img src="https://www.openshift.com/images/logos/openshift/Logotype_RH_OpenShift_wLogo_RGB_Gray.svg" alt="OCP logo" height="70" >

<h1>THIS IS IN WORK - YYMV</h1>

This repository contains the source for building Swift applications as reproducible Docker images using [source-to-image](https://github.com/openshift/source-to-image).

For more information about using these images with OpenShift, please see the
official [OpenShift Documentation](https://docs.openshift.org/latest/architecture/core_concepts/builds_and_image_streams.html#source-build).

For more information about the open source Swift programming language goto the [Swift website](https://swift.org).


<h3>Below you can read how to build and how to use.  FYI, you don't have to build this image - I'll try to keep updated versions of it available on docker hub.  And maybe evetually Red Hat will incorporate this into their secure openshift repos.<h3>


Prereqs (need to be installed to *build*)
---------------
* s2i
* docker-squash

Versions available
---------------
Swift versions available
* Swift 3.0

OS versions available
* ubuntu14 = Ubuntu 14.04
* centos7 = CentOS 7 (IN WORK)
* rhel7 = RHEL 7 (IN WORK)

Building this repo
---------------
To prepare the s2i builder image (for builing on Ubuntu 14.04 & Swift 3.0):
```shell
$ git clone https://github.com/dudash/s2i-swift.git
$ cd s2i-swift
$ make build VERSION=3.0 TARGET=ubuntu14
```

This repo organization
---------------
<pre>
**[swift-version]**: Dockerfile to build container images from
**[swift-version/test/test-app]**: Sample application used for tests
**hack/**: Folder containing scripts which are responsible for the build and test actions performed by the Makefile
**s2i/**: Build scripts which will be injected into the builder image and executed during application source code builds
</pre>

Using this image
---------------
Use the `s2i` tool to build the final image that contains your application code - in this case the provided test app:
```shell
$ s2i build ./3.0/test/test-app/ openshift/swift-30-ubuntu14 swift-test-app
```
* `./3.0/test/test-app/` is the top directory of the source code (replace test path with your code's path).
* `openshift/swift-30-ubuntu14` is the name of the s2i builder image created by `make build` above (including the repo).
* `swift-test-app` is the name of the new application image that contains your app built from source code.

Finally, run your application in a container to see that it worked (swift-test-app is the image you created using s2i):
```shell
$ docker run swift-test-app
```

Using this in Open Shift
---------------
We can create a custom builder image in Open Shift to build this S2I image and push it into your OpenShift registry:
TBD

We can install the S2I Swift image with a template to be used for integrating Swift source code repositories:
TBD


How to structure your code for this builder image
---------------

**Package Manager Builds**
You can leverage the following to customize your build process when running `s2i build -e "..."`
Local package dependencies should be placed in a subfolder called "LocalPackages" - see the test app as an example.

**Straight Source Builds**
You can just point s2i to a folder of swift files and it will compile them into an executable called "app"

* EXTRA_COMPILE_OPTIONS to pass extra options to swiftc
  e.g. s2i build -e "EXTRA_COMPILE_OPTIONS='-Xcc -fmodule-map-file=libbsd.modulemap'"
