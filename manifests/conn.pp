define strongswan::conn(
  $local_ip = "$strongswan::params::local_ip",
  $remote_ip=undef,
  $remote_subnet=undef,
  $local_auth="$strongswan::params::local_auth",
  $remote_auth="$strongswan::params::remote_auth",
  $ike="$strongswan::params::ike",
  $esp="$strongswan::params::esp",
  $psk="$strongswan::params::psk",
  $auto_behaviour = "$strongswan::params::auto_behaviour",
  $keyexchange="$strongswan::params::keyexchange",
  $local_subnet="$strongswan::params::local_subnet",
  $ikelifetime = "$strongswan::params::ikelifetime",
  $lifetime = "$strongswan::params::lifetime",
  $health_check ="${strongswan::params::health_check}",
  $health_check_ip ="${strongswan::params::health_check_ip}",
  ) {

    file {
      "/etc/ipsec.d/$title.conf":
      ensure => file,
      content => template('strongswan/etc/ipsec.d/conn.conf.erb'),
      mode   => '0755',
      owner  => root,
      group  => root;
      "/etc/ipsec.d/$title.secrets":
      ensure => file,
      content => template('strongswan/etc/ipsec.d/conn.secrets.erb'),
      mode   => '0755',
      owner  => root,
      group  => root,
      notify  => Service['strongswan'];

    }
    if ("${strongswan::params::health_check}"){
      cron { "VPN healthcheck $title":
      command => "count=0; for i in {1..15} ; do count=$((\$count+`ping $ -q -c 3 | grep received| awk '{print \$4}'`));  if [ \$count -eq 0 ]; then echo 'NO PING, RESTARTING';sudo systemctl restart strongswan.service;else echo 'WORKING FINE. Successful Pings:' \$count; fi; sleep 3; count=0; done;",
      minute  => '*',
      user    => "root"
      }
    }
  }
