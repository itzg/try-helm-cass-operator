This provides a composite Helm chart that includes the cass-operator helm chart and monitoring from the kube-prometheus-stack.

## Quick setup

Create nodepool for cassandra pod/nodes where the nodes need the label `purpose=cassandra`. The number of nodes should be the same or greater than the `cassandra.clusterSize` value. 

Create nodepool for apps, where nodes will have the label `purpose=apps`.

Setup helm dependencies

```shell script
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add stable https://kubernetes-charts.storage.googleapis.com/
helm repo add datastax https://datastax.github.io/charts
helm repo update
helm dependency update
```

Install chart
```shell script
helm --namespace loadtest install loadtest .  --create-namespace
```

With the Cassandra CRD in place, follow up with an upgrade and enable Cassandra cluster creation:

```shell script
helm --namespace loadtest upgrade loadtest . --debug --set cassandra.enabled=true
```