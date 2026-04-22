#!/bin/bash
# Automação de Rede e DHCP
if [ "$EUID" -ne 0 ]; then echo "❌ Corre com sudo"; exit; fi

echo "--- Configuração de Rede ---"
ip -br link | awk '{print $1}' | grep -v "lo"
read -p "Placa WAN (Internet): " WAN_IF
read -p "Placa LAN (Interna): " LAN_IF
read -p "IP do Servidor (ex: 192.168.100.1): " LAN_IP

# Netplan
cat <<EOF > /etc/netplan/01-netcfg.yaml
network:
  version: 2
  ethernets:
    $WAN_IF: {dhcp4: true}
    $LAN_IF:
      dhcp4: false
      addresses: [$LAN_IP/24]
EOF
netplan apply

# DHCP
apt-get install -y isc-dhcp-server
sed -i "s/INTERFACESv4=\"\"/INTERFACESv4=\"$LAN_IF\"/g" /etc/default/isc-dhcp-server
NET_BASE=$(echo $LAN_IP | cut -d. -f1-3)
cat <<EOF >> /etc/dhcp/dhcpd.conf
subnet $NET_BASE.0 netmask 255.255.255.0 {
  range $NET_BASE.10 $NET_BASE.50;
  option routers $LAN_IP;
  option domain-name-servers 8.8.8.8;
}
EOF
systemctl restart isc-dhcp-server
echo "✅ Rede e DHCP prontos!"
