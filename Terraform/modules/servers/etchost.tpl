
%{ for index, ip in mon_private_ips }

${ip} mon-${index}
 %{ endfor }

%{ for index, ip in osd_private_ips }

${ip} osd-${index}
 %{ endfor }

%{ for index, ip in rgw_private_ips }

${ip} rgw-${index}
 %{ endfor }








