#!/bin/bash

pushd infra
tofu apply -var-file=".tfvars"
popd