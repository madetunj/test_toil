#!/usr/bin/env bash
 
rm -rf workdir outdir jobstore

mkdir workdir outdir 
 
toil-cwl-runner --batchSystem=lsf \
--disableCaching \
--logFile log.txt \
--jobStore jobstore \
--clean never \
--defaultMemory 200M \
--maxMemory 5G \
--maxCores 2 \
--workDir workdir \
--cleanWorkDir never \
--outdir ./outdir \
./workflow/echo_cat_wf.cwl in.yml 1>log.out 2>log.err


for NF in outdir/*; do 
  GS=(gold_standard/$file)
  cmp $NF $GS
done
for NF in $(ls -1 outdir/*); do 
    NF=${NF##*/};
    echo "comparing $NF";
    GS=(gold_standard/$NF);
    cmp outdir/$NF $GS; 
done

