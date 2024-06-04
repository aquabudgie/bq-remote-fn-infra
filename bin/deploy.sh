#!/bin/bash

pushd infra
tofu plan -var-file=".tfvars"
popd