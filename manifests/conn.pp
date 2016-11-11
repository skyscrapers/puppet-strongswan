define strongswan::conn(
  $keyexchange ="ikev1",
  $local_auth="psk",
  $remote_auth= "psk",
  $psk,
  $esp= "aes128-sha256",
  $ike= "aes128-sha256-modp3072",
  $local_subnet= "",
  $ikelifetime= 28800,
  $lifetime= 3600,
  $auto_behaviour= "start",
  $health_check=false,
  $health_check_ip = undef,
  $remote_ip,
  $local_ip,
  $remote_subnet,
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
    if ("$health_check"){
      cron { "VPN healthcheck $title":
      command => "count=0; for i in {1..15} ; do count=$((\$count+`ping $ -q -c 3 | grep received| awk '{print \$4}'`));  if [ \$count -eq 0 ]; then echo 'NO PING, RESTARTING';sudo systemctl restart strongswan.service;else echo 'WORKING FINE. Successful Pings:' \$count; fi; sleep 3; count=0; done;",
      minute  => '*',
      user    => "root"
      }
    }
  }
