# == Class= strongswan==params()
#
class strongswan::params (
  $keyexchange ="ikev1",
  $local_auth="psk",
  $remote_auth= "psk",
  $psk= undef,
  $esp= "aes128-sha256",
  $ike= "aes128-sha256-modp3072",
  $local_subnet= "",
  $ikelifetime= 28800,
  $lifetime= 3600,
  $xauto_behaviour= "start",
  $health_check=false,
  $health_check_ip = undef,
  ) {
}
