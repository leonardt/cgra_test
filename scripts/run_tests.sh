#!/usr/bin/env bash
set -xe

declare -a apps_16=("abs" "shift" "ucomp"
                    "arith" "sminmax" "uminmax")

for file in "${apps_16[@]}"
do
    # fix mapped core ir json
    app="dataset/${file}.json"
    ${COREIR_FIX} dataset/design_mapped_${file}.json ${app}
    # run pnr
    ${PNR} ${CGRA_INFO} ${app}
    # make sure the bsb file exists
    ls -l "dataset/${file}.bsb"
    ${SCRIPT_DIR}/run_app.sh $file
    # test travis
    exit 0
done
