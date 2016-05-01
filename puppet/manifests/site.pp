# The base image misses dnsmasq in the package list
class { '::apt':
  update => {
    frequency => 'daily',
  }
}

# eth1 being the bridged network interface is a dangered assumption
# I couldn't find a way to detect this properly though
$pxe_server_ip = $::ipaddress_eth1
$proxy_subnet = $::network_eth1

class { '::dnsmasq':
    enable_tftp => true,
    tftp_root   => '/pxe',
    port        => 0,
    config_hash => {
        'dhcp-range'       => "${pxe_server_ip},proxy",
        'dhcp-option'      => 'vendor:PXEClient,6,2b',
        'dhcp-match'       => 'set:ipxe,175',
        'dhcp-no-override' => '',
        'pxe-prompt'       => 'net:#ipxe,"Press F8 for boot menu", 3',
        'pxe-service'      => [
            'net:#ipxe,X86PC, "Boot from network", pxelinux',
            'net:#ipxe,X86PC, "Boot from local hard disk", 0']
    },
    require     => Class['Apt']
}

# class { 'dnsmasq::dhcpproxy':
#
# }

::dnsmasq::dhcpboot { 'bootme-pxe':
    file       => 'pxelinux.0',
    hostname   => $::hostname, #optional
    bootserver => $pxe_server_ip
}

# For better debugging enable daemon.log
service { 'rsyslog':
    ensure => 'running',
    enable => true,
}

file { '/etc/rsyslog.d/60-daemon.conf':
  ensure => file,
  source => '/vagrant/puppet/files/daemon-log-enable.conf',
  notify => Service['rsyslog']
}
