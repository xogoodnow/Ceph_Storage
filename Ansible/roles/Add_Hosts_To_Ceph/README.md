## What this role does
* Adds a bash scrip to the node (mon-0).
> **Note**
> The script read /etc/hosts and checks the name of each node and add the appropriate labels for each of them so they can be properly added to the cluster
* Runs the scrip so the ndoes would be added.
* Adds the external disks of OSD ndoes to the cluster for storage capacity
* Enables RGW on port 8585.
* Pauses for RGWs to be set up properly
* Apply OSDs to the cluster (based on the labels)
* Applys all mons so they would be highly available (based on labels)
* In the end prints out some informative data about the clluster
