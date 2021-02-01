#!/bin/bash
echo "=================== Generating s2i for buildah ==================="
s2i build  --as-dockerfile Dockerfile https://github.com/himanshumps/vertx-starter.git quay.io/himanshumps/ubi_java8 vertx_demo
echo "=================== Running s2i with buildah ==================="
buildah bud  -v $PWD/maven/:/tmp/maven/settings/:Z --layers -t quay.io/himanshumps/vertx_demo .
echo "=================== Listing the images ==================="
buildah images
echo "=================== Pushing the image to quay registry ==================="
buildah push quay.io/himanshumps/vertx_demo:latest
