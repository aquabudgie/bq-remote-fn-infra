#!/bin/bash

pushd infra
tofu destroy -var-file=".tfvars"
popd