## What this playbook does
* Prepares every node for production use
* Tune the kernel for better performance 
* Installs docker on all nodes as the main CRI
* Setting up the basis on each node for deployin Ceph
* Initiate the cluster on the first mon node
* Copy the ceph key on all ceph nodes so they could be managed by cephadm
* Runs a bash script on mon-0, so it would add all nodes with their intended usecase and labels
* Add node exporter to all nodes
* Disable default node/ceph exporter on nodes
* Set up ceph exporter on all nodes except for the monitoring nodes
* Creates a client on RGW for testing purposes
* Setups victoria metrics stack on monitoring nodes

