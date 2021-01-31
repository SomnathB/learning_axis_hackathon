echo "=================== Generating s2i for buildah ==================="
s2i build  --as-dockerfile Dockerfile https://github.com/himanshumps/vertx-starter.git quay.io/himanshumps/ubi_java8 vertx_demo
echo "=================== Running s2i with buildah ==================="
buildah bud  -v $PWD/maven/:/tmp/maven/settings/:Z --layers -t quay.io/himanshumps/vertx_demo .
echo "=================== Listing the images ==================="
buildah images
echo "=================== Pushing the image to quay registry ==================="
buildah push quay.io/himanshumps/vertx_demo:latest
echo "=================== Logging in openshift ==================="
oc login --insecure-skip-tls-verify=false --token=kUch6fTfQ6C6bFZ2QdhlGt2NMfKpJIgbrFNen2WMIj4 --server=https://api.shared-na4.na4.openshift.opentlc.com:6443
echo "=================== Updating the imagestream for automated deployment ==================="
oc import-image vertx-demo1 -n hackathon
echo "=================== Image updated in openshift ==================="
echo "=================== Update the deployed image on okteto ==================="
kubectl --kubeconfig=./okteto-kube.config --namespace=himanshumps set image deployment vertx-demo vertx-demo=quay.io/himanshumps/vertx_demo:latest
echo "=================== Deployment completed in okteto ==================="
