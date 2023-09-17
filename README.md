
<div align="center">
    <h1>Production Ready Ceph Object Storage Cluster</h1>
    <i>A Ceph implementation for object storage (amazon s3 compatible)</i>

</div>

### Components Used

| Name:Version            | Documentation                                                                                     | Purpose                                 | Alternatives                       | Advantages                                                                                                                                                                              |
|-------------------------|---------------------------------------------------------------------------------------------------|-----------------------------------------|------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Terraform 1.5.4         | [Docs](https://developer.hashicorp.com/terraform?product_intent=terraform)                        | Hardware Provisioner <br/>Initial Setup | `Salt` `Ansible`                   | 1. Easy syntax<br/>2. Sufficient community and documentation<br/>3. Much better suited for hardware provisioning                                                                        |
| Hetzner Provider 1.42.1 | [Docs](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs)                   | Deploying servers                       | `Vultr` `DigitalOcean`             | 1. Cheaper :)<br/>2. Good community overlooking provider                                                                                                                                |
| Ansible 2.15.2          | [Docs](https://docs.ansible.com/)                                                                 | Automating Tasks                        | `Salt`                             | 1. No footprint on target hosts                                                                                                                                                         |
| Ubuntu  22.04           | [Docs](https://www.google.com/search?client=safari&rls=en&q=ubuntu+image+22.04&ie=UTF-8&oe=UTF-8) | Operating system                        | `Debian` `Centos`                  | 1. Bigger community<br/>2. Faster releases than debian<br/>3. Bigger community than any other OS<br/>4. Not cash grapping like centos (Yet :))                                          |
| Victoriametrics latest  | [Docs](https://victoriametrics.github.io/)                                                        | Time-series Database                    | `InfluxDB` `Prometheus`            | 1. High performance<br/>2. Cost-effective<br/>3. Scalable<br/>4. Handles massive volumes of data <br/>5. Good community and documentation                                               |
| vmalert latest          | [Docs](https://victoriametrics.github.io/vmalert.html)                                            | Evaluating Alerting Rules               | `Prometheus Alertmanager`          | 1. Works well with VictoriaMetrics<br/>2. Supports different datasource types                                                                                                           |
| vmagent latest          | [Docs](https://victoriametrics.github.io/vmagent.html)                                            | Collecting Time-series Data             | `Prometheus`                       | 1. Works well with VictoriaMetrics<br/>2. Supports different data source types                                                                                                          |
| Alertmanager latest     | [Docs](https://prometheus.io/docs/alerting/latest/alertmanager/)                                  | Handling Alerts                         | `ElastAlert` `Grafana Alerts`      | 1. Handles alerts from multiple client applications<br/>2. Deduplicates, groups, and routes alerts<br/>3. Can be plugged to multiple endpoints (Slack, Email, Telegram, Squadcast, ...) |
| Grafana latest          | [Docs](https://grafana.com/docs/grafana/latest/)                                                  | Monitoring and Observability            | `Prometheus` `Datadog` `New Relic` | 1. Create, explore, and share dashboards with ease  <br/>2.Huge community and documentation<br/>3. Easy to setup and manage<br/>4. Many out of the box solutions for visualization      |
| Nodeexporter latest     | [Docs](https://prometheus.io/docs/guides/node-exporter/)                                          | Hardware and OS Metrics                 | `cAdvisor` `Collectd`              | 1. Measure various machine resources<br/>2. Pluggable metric collectors <br/>3. Basic standard for node monitoing                                                                       |
| Cephexporter latest     | [Docs](https://github.com/digitalocean/ceph_exporter)                                        | Monitoring Ceph Clusters                | `NoN I Know of`                     | 1. Works well with Ceph<br/>2. Exposes Ceph metrics to Prometheus                                                                                                                       |
| Docker latest           | [Docs](https://docs.docker.com/)                                                                  | Application Deployment and Management   | `containerd` `podman`              | 1. Much more bells and wistels are included out of the box comparing to alternatives<br/>2. Awsome community and documentation <br/>3. Easy to work with                                |



## Before you begin
> **Note**
> Each ansible role has a general and a specific Readme file. It is encouraged to read them before firing off
> 
> p.s: Start with the readme file of main setup playbook
* Create an Api on hetzner
* Create a server as terraform and ansible provisioner (Needless to say that ansible and terraform must be installed)
* Clone the project
* In modular_terraform folder create a terraform.tfvars 
    - The file must contain the following variables
      - hcloud_token "APIKEY"
      - image_name = "ubuntu-22.04"
      - server_type = "cpx31"
      - location = "hel1"
* Run terraform init to create the required lock file
* Before firing off, run terraform plan to see if everything is alright
* Run terraform apply
* Go Drink a cup of coffe and come back in 10 minutes or so (Hopefully everything must be up and running by then (: )


## Known issues
* RGW IPs are not set on the domain automatically
* No custom dashboards
* No automation for scaling or maintenance
* No audit logging (to see when,who made what changes on the cluster)
* Terraform is limited to Hetzner
* Since there is no specific range for servers, public-network of mon, in on 0.0.0.0/0 
  * Firewall policies minimize the risk
* Grafana datasource must be set manually <http://IP_ADDRESS_:8428>



## Work flow
* Run the following command for terraform to install dependencies and create the lock file
``` bash
terraform init
```
![image](https://s3.ir-thr-at1.arvanstorage.ir/kangceph/terraform_init.gif)


* Run the following command and check if there are any problems with terraform
``` bash
terraform plan
```
![image](https://s3.ir-thr-at1.arvanstorage.ir/kangceph/terraform_plan.gif)

* Apply terraform modules and get started
``` bash
terraform apply
```
![image](https://s3.ir-thr-at1.arvanstorage.ir/kangceph/terraform_apply.gif)


* Check if Mons are in quorum 
``` bash
ceph -s
ceph orch host ls
ceph df
```
![image](https://s3.ir-thr-at1.arvanstorage.ir/kangceph/ceph_works.gif)

* Check if Mons are in quorum 
```bash
ceph mon stat
```
![image](https://s3.ir-thr-at1.arvanstorage.ir/kangceph/mon_stat.gif)

* Check if Victoria_Metrics and Vmagent work
* > **Note**
> Check if all targets are scraped properly
![image](https://s3.ir-thr-at1.arvanstorage.ir/kangceph/victoriametrics_works.gif)

* Check if vmalert works
* > **Note**
> Check if alerts are gouped properly
![image](https://s3.ir-thr-at1.arvanstorage.ir/kangceph/vmalert_works.gif)


* Check if Grafana works
* > **Note**
> All dashboard are provisioned 
> To add custom dashbaord on load, add it to /Ansible/roles/Victoria_Metrics/files/Grafana/provisioning/dashboards as a .json file. It would automatically be loaded to Grafana
> Just keep in mind that you have to also copy the dashbaord using ansible to the remote destination

![image](https://s3.ir-thr-at1.arvanstorage.ir/kangceph/grafana_works.gif)


* Check if Alert manager is working
* > **Note**
> Created some alerts to demonstrate
> The alerts are being routed to Slack/Gmail
![image](https://s3.ir-thr-at1.arvanstorage.ir/kangceph/alertmanager_works.gif)



* Creating a bucket
```bash
s3cmd --config=s3cfg mb s3://bucket
```
![image](https://s3.ir-thr-at1.arvanstorage.ir/kangceph/make_bucket.gif)

* Upload objects
```bash
s3cmd --config=scfg put 1G.bin s3://bucket
```
![image](https://s3.ir-thr-at1.arvanstorage.ir/kangceph/upload_works.gif)


* To Clean up everything (including the nodes themselvs)
``` bash
terraform destroy
```
![image](https://s3.ir-thr-at1.arvanstorage.ir/kangceph/terradform_destroy.gif)

