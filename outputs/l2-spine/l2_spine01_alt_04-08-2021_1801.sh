## == Built on 04-08-2021_1801 == ##

## Host: spine01
## Device Type: l2-spine
## Device OS: cumulus
#
net add hostname spine01

### Add Admin Lookpback
net add loopback lo ip address 10.255.0.1/32
#
### OOB MGMT
net add interface eth0 ip address 10.1.0.10/24
#
### Add VLAN 2 (egress VLAN )
net add bridge bridge vids 2
#
### Add L3 address to VLAN 2
net add vlan 2 ip address 10.2.2.1/24
#
### Add VRR to VLAN 2
net add vlan 2 ip address-virtual 00:00:5e:00:01:02 10.2.2.254
#
## Interfaces 
#
### Enable L2 on interfaces swp1
net add bridge bridge ports swp1
#
### Enable port swp1 as VLAN 2 Access Port 
net add interface swp1 bridge access 2
net add interface swp1 alias leaf01-swp1
#
### Enable L2 on interfaces swp2
net add bridge bridge ports swp2
#
### Enable port swp2 as VLAN 2 Access Port 
net add interface swp2 bridge access 2
net add interface swp2 alias leaf02-swp1
#
### Enable L2 on interfaces swp3
net add bridge bridge ports swp3
#
### Enable port swp3 as VLAN 2 Access Port 
net add interface swp3 bridge access 2
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
net add bgp neighbor listen range 10.1.0.0/24 peer-group ebgp_leaf
net add bgp network 10.255.0.1/32
net add bgp network 10.2.2.0/24
### Commit changes
net commit
