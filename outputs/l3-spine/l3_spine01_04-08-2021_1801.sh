## == Built on 04-08-2021_1801 == ##

## Host: spine01
## Device Type: l3-spine
## Device OS: cumulus
#
net add hostname spine01

### Add Admin Lookpback
net add loopback lo ip address 10.255.0.1/32
#
### OOB MGMT
net add interface eth0 ip address 10.1.0.10/24
#
### Add VLAN unassigned (unused VLAN )
net add bridge bridge vids unassigned
#
## Interfaces 
#
### Enable L3 on interfaces swp1
net add interface swp1 ip address 10.254.1.0/31
net add interface swp1 alias leaf01-swp1
#
### Enable L3 on interfaces swp2
net add interface swp2 ip address 10.254.1.2/31
net add interface swp2 alias leaf02-swp1
#
### Enable L3 on interfaces swp3
net add interface swp3 ip address 10.254.1.4/31
net add interface swp3 alias leaf03-swp1
#
### Routes
net add routing route 0.0.0.0/0 10.1.0.1 vrf mgmt
#
### Commit changes
net commit

### BGP
net add bgp autonomous-system 65001
net add bgp bestpath as-path multipath-relax
net add bgp neighbor ebgp_leaf peer-group
net add bgp neighbor ebgp_leaf remote_as external
net add bgp neighbor ebgp_leaf default-originate
net add bgp neighbor 10.254.1.1 peer-group ebgp_leaf
net add bgp neighbor 10.254.1.3 peer-group ebgp_leaf
net add bgp neighbor 10.254.1.5 peer-group ebgp_leaf
net add bgp network 10.255.0.1/32
net add bgp network 10.254.1.0/31
net add bgp network 10.254.1.2/31
net add bgp network 10.254.1.4/31
### Commit changes
net commit
