#!/usr/bin/env bash
set -xe

declare -a apps_16=("abs" "shift" "ucomp"
                    "arith" "sminmax" "uminmax")

BUILD_V=1

for file in "${apps_16[@]}"
do
    # fix mapped core ir json
    app="dataset/${file}.json"
    ${COREIR_FIX} dataset/design_mapped_${file}.json ${app}
    # run pnr
    ${PNR} ${CGRA_INFO} ${app}
    # make sure the bsb file exists
    ls -l "dataset/${file}.bsb"
    if [ ${BUILD_V} ]; then
       ${SCRIPT_DIR}/run_app.sh $file
    fi
    exit 1
done
