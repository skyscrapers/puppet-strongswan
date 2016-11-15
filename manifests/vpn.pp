define strongswan::vpn(
  $keyexchange ="ikev1",
  $local_auth="psk",
  $remote_auth= "psk",
  $psk,
  $esp= "aes128-sha256",
  $ike= "aes128-sha256-modp3072",
  $local_subnet,
  $auto_behaviour= "start",
  $health_check=false,
  $health_check_ip = undef,
  $remote_ip,
  $remote_id="$remote_ip",
  $local_id="$local_ip",
  $local_ip,
  $remote_subnet,
  $ike_lifetime="3h",
  $lifetime="1h",
  ) {
    include strongswan::params
    $ipsec_dir = $strongswan::params::ipsec_dir
    file {
      "${strongswan::params::ipsec_dir}/ipsec.d/$title.conf":
      ensure => file,
      content => template('strongswan/etc/ipsec.d/conn.conf.erb'),
      mode   => '0755',
      owner  => root,
      group  => root;
      "${strongswan::params::ipsec_dir}/ipsec.d/$title.secrets":
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
