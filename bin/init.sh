#!/bin/bash

pushd infra
tenv detect
tofu init
popd