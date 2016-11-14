# strongswan

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with strongswan](#setup)
    * [Setup requirements](#setup-requirements)
    * [Beginning with strongswan](#beginning-with-strongswan)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

This module allows to install strongswan and configure as many vpn connection as required.


## Setup

### Setup Requirements

In case you are using this module with a RedHat distro you will need to have the epel repo installed

### Beginning with strongswan

In order to make it working you will need to include the module in your manifest and you can setup the vpns using hiera.

## Usage

A sample configuration using hiera can be found here:
```
---
  strongswan::vpns:
    vpn1:
      remote_ip: "1.2.3.4"
      local_ip: "5.6.7.8"
      keyexchange: "ikev1"
      remote_subnet: "10.0.0.0/16"
      local_subnet: "10.3.8.192/28"
      ike: aes256-sha1-modp1024
      esp: aes256-sha1-modp1024
      psk: "password"
      ike_lifetime: "24h"
      ike: "1h"

```

## Reference

TODO

## Limitations

TODO

## Development

TODO
