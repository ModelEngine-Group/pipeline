#!/bin/bash
set -eux

source "${WORKSPACE}/env.sh"

cd "${WORKSPACE}/app-platform/frontend"
${SED} 's#fit-framework#elsa#g' package.json

if [[ "${OS_TYPE}" == "Darwin" ]]; then
  cd "${WORKSPACE}/elsa/framework/elsa/fit-elsa"
  ${SED} "s#sed -i #sed -i '' #g" package.json
fi
