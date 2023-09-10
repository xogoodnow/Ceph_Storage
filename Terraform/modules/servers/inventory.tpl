all:
    children:
        helsinki:
            hosts:
            %{ for index, ip in mon_ips }
                mon-hel-${index}:
                    ansible_host: ${ip}
                    ansible_user: root
                    mode: 'mon'
                    init_cluster: ${index == 0 ? "'true'" : "'false'"}
            %{ endfor }
            %{ for index, ip in osd_ips }
                osd-hel-${index}:
                    ansible_host: ${ip}
                    ansible_user: root
                    mode: 'osd'
                    init_cluster: 'false'
            %{ endfor }
            %{ for index, ip in rgw_ips }
                rgw-hel-${index}:
                    ansible_host: ${ip}
                    ansible_user: root
                    mode: 'rgw'
                    init_cluster: 'false'
            %{ endfor }