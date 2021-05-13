## == Built on 04-08-2021_1801 == ##

## Host: leaf01
## Device Type: l3-leaf
## Device OS: cumulus
#
net add hostname leaf01

### Add Admin Lookpback
net add loopback lo ip address 10.255.1.1/32
#
### OOB MGMT
net add interface eth0 ip address 10.1.0.101/24
#
### Add VLAN 100 (VLAN100 VLAN )
net add bridge bridge vids 100
#
### Add VLAN 200 (VLAN200 VLAN )
net add bridge bridge vids 200
#
### Add L3 address to VLAN 100
net add vlan 100 ip address 10.100.100.1/24
#
### Add VRR to VLAN 100
net add vlan 100 ip address-virtual 00:00:5e:00:01:64 10.100.100.254
#
### Add L3 address to VLAN 200
net add vlan 200 ip address 10.200.200.1/24
#
### Add VRR to VLAN 200
net add vlan 200 ip address-virtual 00:00:5e:00:01:c8 10.200.200.254
#
## Interfaces 
#
### Enable L3 on interfaces swp1
net add interface swp1 ip address 10.254.1.1/31
net add interface swp1 alias spine01-swp1
#
### Enable L3 on interfaces swp2
net add interface swp2 ip address 10.254.2.1/31
net add interface swp2 alias spine02-swp1
#
net add bridge bridge ports swp4
#
### Enable L2 Trunking on port swp4 for vlans 2,100,200 (PVID 1 is default)
net add interface swp4 bridge vids 2,100,200
net add interface swp4 alias leaf02-swp4
#
net add bridge bridge ports swp5
#
### Enable L2 Trunking on port swp5 for vlans 2,100,200 (PVID 1 is default)
net add interface swp4 bridge vids 2,100,200
net add interface swp5 alias leaf03-swp4
#
### Enable L2 on interfaces swp7
net add bridge bridge ports swp7
#
### Enable port swp7 as VLAN 100 Access Port 
net add interface swp7 bridge access 100
net add interface swp7 alias host-vlan100
#
### Enable L2 on interfaces swp8
net add bridge bridge ports swp8
#
### Enable port swp8 as VLAN 200 Access Port 
net add interface swp8 bridge access 200
net add interface swp8 alias host-vlan200
#
### Routes
#
### Commit changes
net commit

### BGP
net add bgp autonomous-system 65101
net add bgp bestpath as-path multipath-relax
net add bgp neighbor 10.254.1.0 remote-as external
net add bgp neighbor 10.254.2.0 remote-as external
net add bgp network 10.255.1.1/32
net add bgp network 10.254.1.0/31
net add bgp network 10.254.2.0/31
net add bgp network 10.100.100.0/24
net add bgp network 10.200.200.0/24
### Commit changes
net commit
