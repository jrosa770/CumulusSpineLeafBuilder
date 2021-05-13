## Host: l2_leaf01
## Device Type: l2-leaf
## Device OS: cumulus
#
net add hostname l2_leaf01

### Add Admin Lookpback
net add loopback lo ip address 10.255.1.10/32
#
### OOB MGMT
net add interface eth0 ip address NA
#
### Add VLAN 10 (infra_oob_vrf_mgmt VLAN )
net add bridge bridge vids 10
#
### Add L3 address to VLAN 10
net add vlan 10 ip address 10.255.10.1/24
#
### Add VRR to VLAN 10
net add vlan 10 ip address-virtual 00:00:5e:00:0a 10.255.10.254/24
#
## Interfaces 
#
### Enable L2 on interfaces swp1
net add bridge bridge ports swp1
#
### Enable port swp1 as VLAN 10 Access Port 
net add interface swp1 bridge access 10
net add interface swp1 alias spine01-eth0
#
### Enable L2 on interfaces swp2
net add bridge bridge ports swp2
#
### Enable port swp2 as VLAN 10 Access Port 
net add interface swp2 bridge access 10
net add interface swp2 alias spine02-eth0
#
### Enable L2 on interfaces swp4
net add bridge bridge ports swp4
#
### Enable port swp4 as VLAN 10 Access Port 
net add interface swp4 bridge access 10
net add interface swp4 alias leaf01-eth0
#
### Enable L2 on interfaces swp5
net add bridge bridge ports swp5
#
### Enable port swp5 as VLAN 10 Access Port 
net add interface swp5 bridge access 10
net add interface swp5 alias leaf02-eth0
#
### Enable L3 on interfaces swp11
net add interface swp11 ip address 10.0.0.10/24
net add interface swp11 alias core01-swp1
#
### Routes
net add routing route 0.0.0.0/0 10.0.0.254
#
### Commit changes
net commit
