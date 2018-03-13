FROM alpine:latest

ARG PACKER_VERSION=1.2.1
ENV PACKER_VERSION=${PACKER_VERSION}

ARG TERRAFORM_VERSION=0.11.3
ENV TERRAFORM_VERSION=${TERRAFORM_VERSION}

ARG VAULT_VERSION=0.9.5
ENV VAULT_VERSION=${VAULT_VERSION}

RUN apk add --update git curl openssh unzip \
    && curl https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip > packer_${PACKER_VERSION}_linux_amd64.zip \
    && unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /bin \
    && rm -f packer_${PACKER_VERSION}_linux_amd64.zip \
    && apk add --update \
      python \
      python-dev \
      py-pip \
      build-base \
      libffi \
      libffi-dev \
      openssl-dev \
    && pip install ansible awscli jq \
    && curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin \
    && rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && curl https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip > vault_${VAULT_VERSION}_linux_amd64.zip \
    && unzip vault_${VAULT_VERSION}_linux_amd64.zip -d /bin \
    && rm -f vault_${VAULT_VERSION}_linux_amd64.zip \
    && rm -rf /var/cache/apk/*

RUN adduser user -D -g '' -u 1000 -h /home/user
USER 1000
