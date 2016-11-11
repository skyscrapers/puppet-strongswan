# == Class: strongswan::config
#
class strongswan::config {
  file {
    '/etc/ipsec.conf':
    ensure => file,
    content => template('strongswan/etc/ipsec.d/ipsec.conf.erb'),
    mode   => '0755',
    owner  => root,
    group  => root;
    '/etc/ipsec.secrets':
    ensure => file,
    content => template('strongswan/etc/ipsec.d/ipsec.secrets.erb'),
    mode   => '0755',
    owner  => root,
    group  => root,
    notify  => Service['strongswan'];
  }
  create_resources('strongswan::conn', hiera_hash('strongswan::vpns', {}))
}
