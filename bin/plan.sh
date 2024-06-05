#!/bin/bash

pushd infra
tofu fmt
tofu plan -var-file=".tfvars"
popd
