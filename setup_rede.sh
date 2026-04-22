#!/bin/bash
# ==============================================================================
# Assistente de Configuração Inicial: Rede e DHCP (Ubuntu Server)
# ==============================================================================

if [ "$EUID" -ne 0 ]; then
  echo "❌ Erro: Por favor, corre este script com 'sudo' (ex: sudo ./setup_rede.sh)"
  exit
fi

echo "======================================================"
echo "🔧 INÍCIO DA CONFIGURAÇÃO DE REDE E DHCP"
echo "======================================================"
echo ""
ip -br link | awk '{print $1}' | grep -v "lo"
echo ""

read -p "👉 1. Digita o nome da placa de INTERNET (Bridge, ex: ens33): " WAN_IF
read -p "👉 2. Digita o nome da placa de REDE INTERNA (LAN, ex: ens34): " LAN_IF
read -p "👉 3. Digita o IP Fixo para o servidor (ex: 192.168.100.1): " LAN_IP
read -p "👉 4. Digita a base da rede para o DHCP (ex: 192.168.100): " NET_BASE

echo "⏳ A iniciar as configurações..."

# Configuração do Netplan
mkdir -p /etc/netplan/backup
mv /etc/netplan/*.yaml /etc/netplan/backup/ 2>/dev/null

cat <<EOF > /etc/netplan/01-config-rede.yaml
network:
  version: 2
  ethernets:
    $WAN_IF:
      dhcp4: true
    $LAN_IF:
      dhcp4: false
      addresses:
        - $LAN_IP/24
EOF
netplan apply

# Instalação e Configuração do Servidor DHCP
apt-get update -qq
apt-get install -y isc-dhcp-server > /dev/null

sed -i "s/INTERFACESv4=\"\"/INTERFACESv4=\"$LAN_IF\"/g" /etc/default/isc-dhcp-server

cat <<EOF >> /etc/dhcp/dhcpd.conf
subnet $NET_BASE.0 netmask 255.255.255.0 {
  range $NET_BASE.10 $NET_BASE.50;
  option routers $LAN_IP;
  option domain-name-servers 8.8.8.8, 8.8.4.4;
}
EOF

systemctl restart isc-dhcp-server
systemctl enable isc-dhcp-server

echo "✅ INSTALAÇÃO CONCLUÍDA COM SUCESSO!"
