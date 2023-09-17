#!/bin/bash

# Read the /etc/hosts file line by line
while IFS= read -r line; do
    # Split the line into fields using whitespace as the delimiter
    read -ra fields <<< "$line"

    # Check if there are at least two fields (hostname and IP address)
    if [ ${#fields[@]} -ge 2 ]; then
        hostname="${fields[1]}"  # Use the second field as the hostname
        ip="${fields[0]}"        # Use the first field as the IP address

        # Check if the IP address is a valid IPv4 or IPv6 address
        if [[ "$ip" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ || "$ip" =~ : ]]; then
            # Exclude specific hostnames
            if [[ "$hostname" != "ip6-allnodes" && "$hostname" != "ip6-allrouters" && "$hostname" != "localhost" ]]; then
                # Check if the hostname contains "osd"
                if [[ "$hostname" == *"osd"* ]]; then
                    labels="--labels=osd"
                # Check if the hostname contains "rgw"
                elif [[ "$hostname" == *"rgw"* ]]; then
                    labels="--labels=rgw"
                # Check if the hostname contains "mon"
                elif [[ "$hostname" == *"mon"* ]]; then
                    labels="--labels=_admin,mon"
                else
                    labels=""
                fi

                # Adding the nodes to the cluster
                ceph orch host add $hostname $ip $labels
            fi
        fi
    fi
done < /etc/hosts
