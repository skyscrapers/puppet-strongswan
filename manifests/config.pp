# == Class: strongswan::config
#
class strongswan::config inherits strongswan::params{
  $ipsec_dir = $strongswan::params::ipsec_dir
  file { ["$ipsec_dir",]:
    ensure => directory,
    mode => '0700',
  }
  file {
    "${strongswan::params::ipsec_dir}/ipsec.conf":
    ensure => file,
    content => template('strongswan/etc/ipsec.d/ipsec.conf.erb'),
    mode   => '0650',
    owner  => root,
    group  => root;
    "${strongswan::params::ipsec_dir}/ipsec.secrets":
    ensure => file,
    content => template('strongswan/etc/ipsec.d/ipsec.secrets.erb'),
    mode   => '0600',
    owner  => root,
    group  => root,
    notify  => Service['strongswan'];
  }
  create_resources('strongswan::vpn', hiera_hash('strongswan::vpns', {}))
}
