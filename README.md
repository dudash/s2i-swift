# Swift source-to-image

<img src="https://swift.org/assets/images/swift.svg" alt="Swift logo" height="70" >
<img src="https://www.openshift.com/images/logos/openshift/Logotype_RH_OpenShift_wLogo_RGB_Gray.svg" alt="OCP logo" height="70" >

This repository contains the source for building Swift applications as reproducible Docker images using [source-to-image](https://github.com/openshift/source-to-image).

For more information about using these images with OpenShift, please see the
official [OpenShift Documentation](https://docs.openshift.org/latest/architecture/core_concepts/builds_and_image_streams.html#source-build).

For more information about the open source Swift programming language goto the [Swift website](https://swift.org).


<h3>Below you can read how to build and how to use.  FYI, you don't have to build this repo, you can use a prebuilt image - I'll try to keep updated versions of it available on docker hub.<h3>

[![docker hub stats](http://dockeri.co/image/dudash/swift-30-ubuntu14)](https://hub.docker.com/r/dudash/swift-30-ubuntu/)


## Versions available

Swift versions available
* Swift 3.0

OS versions available
* ubuntu14 = Ubuntu 14.04
* centos7 = CentOS 7 (IN WORK)
* rhel7 = RHEL 7 (IN WORK)


## Using this image

You'll need to have the [s2i tool](https://github.com/openshift/source-to-image).

### Find and get the image you want (VERSION and PLATFORM)

```shell
$ docker search dudash/swift
$ docker pull dudash/swift-VER-PLATFORM
```

### Using with the local test app
Use the `s2i` tool to build the final image that contains your application code - in this case the test app provided in this repo:

```shell
$ git clone https://github.com/dudash/s2i-swift.git
$ s2i build ./3.0/test/test-app/ dudash/swift-30-ubuntu14 swift-test-app
```
* `./3.0/test/test-app/` is the top directory of the source code (replace test path with your code's path).
* `openshift/swift-30-ubuntu14` is the name of the s2i builder image created by `make build` above (including the repo).
* `swift-test-app` is the name of the new application image that contains your app built from source code.

Finally, run your application in a container to see that it worked (swift-test-app is the image you created using s2i):
```shell
$ docker run swift-test-app
```

### Using with github projects

Use the `s2i` tool to build the final image that contains your application code

* Hello swift from github example
```shell
$ s2i build https://github.com/dudash/openshiftexamples-simpleswift.git dudash/swift-30-ubuntu14 hello-swift
$ docker run hello-swift
```
* Apple's swift example package-dealer on github (with logging set to 5):
```shell
$ s2i build --loglevel 5 https://github.com/apple/example-package-dealer.git dudash/swift-30-ubuntu14 package-dealer
$ docker run package-dealer
```

### How to structure your code

**Package Manager Builds**

You can build swift apps for linux that leverage Swift Package Manager.  The build process assumes you will have a Package.swift at the top level describing your app and it's dependencies.  Your app's Swift code should be located in a "Sources" directory.  Local package dependencies should be placed in a directory called "LocalPackages" (see the test app as an example).

**Straight Source Builds**

You can just point s2i to a folder of swift files and it will compile them into an executable.

* EXTRA_COMPILE_OPTIONS to pass extra options to swiftc
  e.g. s2i build -e "EXTRA_COMPILE_OPTIONS='-Xcc -fmodule-map-file=libbsd.modulemap'"


### Using in Open Shift

We can install the S2I Swift image with a template to be used for integrating Swift source code repositories:
```shell
$ oc create -n openshift -f https://raw.githubusercontent.com/dudash/s2i-swift/master/openshift-resources/swift-30-linux-all-imagestreamlist.json
```
(note: drop the -n openshift if you don't have admin rights... or ask your admin to create it)


## Building this repo

### Build 
To prepare the s2i builder image (for building on Ubuntu 14.04 & Swift 3.0):
```shell
$ git clone https://github.com/dudash/s2i-swift.git
$ cd s2i-swift
$ make build VERSION=3.0 TARGET=ubuntu14
```

### Repo organization
<pre>
**[swift-version]**: Dockerfile to build container images from
**[swift-version/test/test-app]**: Sample application used for tests
**hack/**: Folder containing scripts which are responsible for the build and test actions performed by the Makefile
**s2i/**: Build scripts which will be injected into the builder image and executed during application source code builds
</pre>

