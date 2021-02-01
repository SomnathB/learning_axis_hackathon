#!/bin/bash
echo "kubectl --namespace=himanshumps --v=4 set image deployment vertx-demo vertx-demo=quay.io/himanshumps/vertx_demo:latest"
ls -altr $PWD
echo "1"
kubectl version --client
echo "2"
kubectl config current-context
echo "3"
kubectl config view
echo "4"
kubectl --kubeconfig=$PWD/okteto-kube.config --namespace=himanshumps set image deployment vertx-demo vertx-demo=quay.io/himanshumps/vertx_demo:latest
echo "5"
echo "=================== Generating s2i for buildah ==================="
s2i build  --as-dockerfile Dockerfile https://github.com/himanshumps/vertx-starter.git quay.io/himanshumps/ubi_java8 vertx_demo
echo "=================== Running s2i with buildah ==================="
#buildah bud  -v $PWD/maven/:/tmp/maven/settings/:Z --layers -t quay.io/himanshumps/vertx_demo .
echo "=================== Listing the images ==================="
#buildah images
echo "=================== Pushing the image to quay registry ==================="
#buildah push quay.io/himanshumps/vertx_demo:latest
echo "=================== Logging in openshift ==================="
#oc login --insecure-skip-tls-verify --token=kUch6fTfQ6C6bFZ2QdhlGt2NMfKpJIgbrFNen2WMIj4 --server=https://api.shared-na4.na4.openshift.opentlc.com:6443
echo "=================== Updating the imagestream for automated deployment ==================="
#oc import-image vertx-demo1 -n hackathon
echo "=================== Image updated in openshift ==================="
echo "=================== Update the deployed image on okteto ==================="
echo "kubectl --kubeconfig=$PWD/okteto-kube.config --namespace=himanshumps --v=4 set image deployment vertx-demo vertx-demo=quay.io/himanshumps/vertx_demo:latest"
ls $PWD
kubectl --kubeconfig=$PWD/okteto-kube.config --namespace=himanshumps set image deployment vertx-demo vertx-demo=quay.io/himanshumps/vertx_demo:latest
echo "=================== Deployment completed in okteto ==================="
