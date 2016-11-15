# == Class= strongswan==params()
#
class strongswan::params (

  ) {
    case $::osfamily {
      "RedHat": {
        $ipsec_dir =  "/etc/strongswan"
      }
      "Debian": {
        $ipsec_dir =  "/etc"
      }
    }
}
