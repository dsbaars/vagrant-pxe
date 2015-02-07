# eth1 being the bridged network interface is a dangered assumption
# I couldn't find a way to detect this properly though
$pxe_server_ip = $::ipaddress_eth1
$proxy_subnet = $::network_eth1

class { 'dnsmasq':
    enable_tftp       => true,
    tftp_root         => '/pxe',
    port => 0,
    config_hash => {
        'dhcp-range' => "${pxe_server_ip},proxy",
        'dhcp-option' => 'vendor:PXEClient,6,2b',
        'dhcp-match' => 'set:ipxe,175',
        'dhcp-no-override' => '',
        'pxe-prompt' => 'net:#ipxe,"Press F8 for boot menu", 3',
        'pxe-service' => [
            'net:#ipxe,X86PC, "Boot from network", pxelinux',
            'net:#ipxe,X86PC, "Boot from local hard disk", 0']
    }
}

# class { 'dnsmasq::dhcpproxy':
#
# }

dnsmasq::dhcpboot { 'hadoop-pxe':
    file       => 'pxelinux.0',
    hostname   => $::hostname, #optional
    bootserver => $pxe_server_ip
}
