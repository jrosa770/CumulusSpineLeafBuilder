# BasicSpineLeaf

## Cumulus Builder

### Hostvar File Arrangement

#### Purpose

Serves as a YAML equivalent of a prospective and/ or existing switch.

#### Benefit

Platform agnostic, can be used to build configurations for Cumulus as well as Cisco, Arista, Junos, etc. The application depends on the playbook's template and language.

#### Examples

> Simple Layer 2 Cumulus:

```yml
---
hostname: l2_switch
device_type: 'l2-tor'
os: cumulus
os_ver: '4.2'
lo_ip: '10.255.1.1/32'
oob_interface: eth0
oob_ip: '10.1.0.101/24'
oob_sw: mgmt01

vlans:
  - name: VLAN200
    vid: 200
    vlan_ip: '10.2.200.10/24'
    state: keep

interfaces:
  - name: swp1
    description: 'lan01-swp1'
    type: l2-access
    l2_vid: 2
    state: keep
```

> Simple Layer 2 Cisco:

```yml
---
hostname: l2_switch
device_type: 'l2-tor'
os: ios
os_ver: '15.1'
lo_ip: '10.255.1.1/32'
oob_interface: G0
oob_ip: '10.1.0.101/24'
oob_sw: mgmt01

vlans:
  - name: VLAN200
    vid: 200
    vlan_ip: '10.2.200.10/24'
    state: keep

interfaces:
  - name: 'G0/1'
    description: 'lan01-G1/0/1'
    type: l2-access
    l2_vid: 2
    state: keep
```

*As seen in the examples, the variables are the same for both platforms but the different values is what dictates the usage.*

> Simple Layer 3 Cumulus:

```yml
---
hostname: l2_switch
device_type: 'l2-tor'
os: cumulus
os_ver: '4.2'
lo_ip: '10.255.1.1/32'
oob_interface: eth0
oob_ip: '10.1.0.101/24'
oob_sw: mgmt01

...

interfaces:
  - name: swp11
    description: 'core01-swp51'
    type: routed
    swp_ip: '10.1.1.2/30'
    state: keep
```

> Simple Layer 3 Arista:

```yml
---
hostname: l2_switch
device_type: 'l2-tor'
os: eos
os_ver: '4.25'
lo_ip: '10.255.1.1/32'
oob_interface: eth0
oob_ip: '10.1.0.101/24'
oob_sw: mgmt01

...

interfaces:
  - name: 'ethernet 1/1/11
    description: 'core01-e1/1/51'
    type: routed
    swp_ip: '10.1.1.2/30'
    state: keep
```

> Simple Static Routes:

```yml
static_routes:
  mgmt_default:
    - '0.0.0.0/0 10.0.0.1 vrf mgmt'
  others:
    - '0.0.0.0/0 10.1.1.254'
    - '192.168.0.0/24 10.2.2.254'
```

> Simple BGP (Cumulus) no peer groups

```yml
bgp:
  state: present
  local_as: 65101
  default_advertise: absent

bgp_advertise:
  - '10.255.1.1/32'
  - '10.2.2.0/24'
  - '10.100.100.0/24'
  - '10.200.200.0/24'

bgp_peer_groups:
  - name: absent

peer_group_attributes:
  - 'remote_as external'

bgp_neighbors:
  - neighbor_ip: '10.2.2.1'
    neighbor_name: spine01
    remote_as: external
    peer_group: absent

  - neighbor_ip: '10.2.2.2'
    neighbor_name: spine02
    remote_as: external
    peer_group: absent
```

> Simple BGP (Cumulus) with peer groups

```yml
bgp:
  state: present
  local_as: 65001
  default_advertise: present

bgp_advertise:
  - '10.255.0.1/32'
  - '10.2.2.0/24'

bgp_peer_groups:
  - name: ebgp_leaf

peer_group_attributes:
  - 'remote_as external'

bgp_neighbors:
  - neighbor_ip: '10.2.2.10'
    neighbor_name: leaf01
    peer_group: ebgp_leaf

  - neighbor_ip: '10.2.2.20'
    neighbor_name: leaf02
    peer_group: ebgp_leaf

  - neighbor_ip: '10.2.2.30'
    neighbor_name: leaf03
    peer_group: ebgp_leaf
```