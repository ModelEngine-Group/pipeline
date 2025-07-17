#!/bin/bash
set -eux

export OS_TYPE=$(uname -s)
if [[ "${OS_TYPE}" == "Darwin" ]]; then
  export SED="sed -i '' "
else
  export SED="sed -i"
fi