FROM alpine:latest

ARG PACKER_VERSION=1.2.1
ENV PACKER_VERSION=${PACKER_VERSION}

ARG TERRAFORM_VERSION=0.11.7
ENV TERRAFORM_VERSION=${TERRAFORM_VERSION}

ARG VAULT_VERSION=0.9.5
ENV VAULT_VERSION=${VAULT_VERSION}

ARG KUBECTL_VERSION=1.10.1
ENV KUBECTL_VERSION=${KUBECTL_VERSION}

ARG HELM_VERSION=2.8.2
ENV HELM_VERSION=${HELM_VERSION}

RUN apk add --update git curl openssh unzip tar gzip \
    && curl https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip > packer.zip \
    && unzip packer.zip -d /bin \
    && rm -f packer.zip \
    && curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform.zip \
    && unzip terraform.zip -d /bin \
    && rm -f terraform.zip \
    && curl https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip > vault.zip \
    && unzip vault.zip -d /bin \
    && rm -f vault.zip \
    && curl  https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl > /bin/kubectl \
    && chmod +x /bin/kubectl \
    && curl https://kubernetes-helm.storage.googleapis.com/helm-v${HELM_VERSION}-linux-amd64.tar.gz > helm.tgz \
    && tar -zxvf helm.tgz -C /bin --strip-components=1 linux-amd64/helm \
    && rm -f helm.tgz \
    && apk add --update \
      bash \
      docker \
      python \
      python-dev \
      py-pip \
      build-base \
      libffi \
      libffi-dev \
      openssl-dev \
      openssl \
      jq \
    && pip install \
      ansible \
      pywinrm[credssp] \
      requests-credssp \
      awscli \
      pyopenssl \
      boto \
      boto3 \
      ansible-modules-hashivault \
    && rm -rf /var/cache/apk/*

RUN adduser user -D -g '' -u 10000 -h /home/user
USER 10000
