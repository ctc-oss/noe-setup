#!/usr/bin/env bash

source env.sh

OS_NAME="rocky"
OS_VERSION="8"
OS_ARCH="x86"
TF_ACTION=""
VENDOR="qemu"

for i in "$@"; do
  case $i in
    --os-name=*)
        OS_NAME="${i#*=}"
        shift # past argument=value
    ;;
    --os-arch=*)
        OS_ARCH="${i#*=}"
        shift # past argument=value
    ;;
    --os-version)
        OS_VERSION="${i#*=}"
        shift # past argument with no value
    ;;
    -a=*|--tf-action=*)
        TF_ACTION="${i#*=}"
        shift # past argument with no value
    ;;
    -v=*|--vendor=*)
        VENDOR="${i#*=}"
        shift
    ;;
    -*|--*)
      echo "Unknown option $i"
      exit 1
      ;;
    *)
      ;;
  esac
done

[[ -z $TF_ACTION || (! -z $TF_ACTION && $TF_ACTION != "apply" && $TF_ACTION != "destroy") ]] \
&& (echo "Must provide terraform action (apply/destroy)"; exit 1) \
|| true

cd terraform/$VENDOR

[[ -f .terraform ]] && true || terraform init
terraform $TF_ACTION \
    --auto-approve=true \
    --var-file="../os_tfvars/$OS_NAME/$OS_NAME-$OS_VERSION-$OS_ARCH.tfvars"

cd ../../
