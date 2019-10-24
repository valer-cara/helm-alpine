FROM alpine

RUN apk add --no-cache git make curl bash

ENV HELM_VERSION v2.15.1

# Install helm
RUN TMP=$(mktemp -d helm.XXXXXXX) \
 && curl --output - https://storage.googleapis.com/kubernetes-helm/helm-$HELM_VERSION-linux-amd64.tar.gz | tar -C $TMP -zxvf - \
 && mv $TMP/linux-amd64/helm /usr/local/bin/helm \
 && rm -rf $TMP

RUN helm init --client-only \
 && helm plugin install https://github.com/hypnoglow/helm-s3.git

