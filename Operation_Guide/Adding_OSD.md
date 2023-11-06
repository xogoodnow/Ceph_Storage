## Adding OSD to ceph cluster
> **Note**
> 
>> Before adding the nodes, add the hosts with their ip address to /etc/hosts
>>> Also you must add the ceph.pub key to the root (optional) directory of the host
```bash
ceph orch host add osd-4 10.0.0.44 --labels=osd
```


## Add the disks on the node that you just added to the cluster
```bash
ceph orch daemon add osd osd-4:/dev/sdb
```


## Apply all OSDs (using their labels)
```bash
ceph orch apply osd --all-available-devices
```


## You can see the new capacity via the following commands
> **Note**
>> Keep in mind that in a production environment, you better manage the crush weight of the osd so the object rebalancing procedure would not disrupt the cluster
>>> ceph osd crush add --id=osd.4 --weight=0.0 --args=string
```bash
ceph osd tree
```
```bash
ceph osd df
```







