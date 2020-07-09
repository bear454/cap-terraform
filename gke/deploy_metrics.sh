#! /bin/sh
export APISRV="$(kubectl cluster-info| head -n 1|grep -o ' at .*$'| cut -f3 -d' '| cut -f3 -d'/'|cut -f1 -d':' | sed 's/\x1b\[[0-9;]*m//g')"
cat $METRICS_FILE $SCF_FILE > ./capConfigurationFile.yaml
sed -i "s/MASTER_URL/https:\/\/$APISRV/g"  ./capConfigurationFile.yaml
helm install suse/metrics     --name susecf-metrics  --version 1.2.1   --namespace metrics    --values ./capConfigurationFile.yaml
