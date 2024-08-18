#!/bin/bash

# Create the directory for iptables rules if it doesn't exist
mkdir -p /etc/iptables

# Flush existing iptables rules
iptables -F
iptables -X

# Drop all incoming/outgoing traffic related to common BitTorrent ports
iptables -A INPUT -p tcp --dport 6881:6889 -j DROP
iptables -A INPUT -p udp --dport 6881:6889 -j DROP
iptables -A INPUT -p tcp --dport 6969 -j DROP
iptables -A INPUT -p udp --dport 6969 -j DROP
iptables -A INPUT -p tcp --dport 51413 -j DROP
iptables -A INPUT -p udp --dport 51413 -j DROP

# Drop traffic from known torrent trackers IPs (replace with actual IPs)
iptables -A OUTPUT -d 87.98.162.88 -j DROP
iptables -A OUTPUT -d 195.154.123.123 -j DROP
iptables -A OUTPUT -d 104.31.18.30 -j DROP
iptables -A OUTPUT -d 104.31.19.30 -j DROP

# Drop connections containing BitTorrent-related signatures (Deep Packet Inspection)
iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP
iptables -A FORWARD -m string --algo bm --string "get_peers" -j DROP
iptables -A FORWARD -m string --algo bm --string "find_node" -j DROP

# Drop UPnP (Universal Plug and Play) traffic, often used by torrent clients to bypass firewall rules
iptables -A INPUT -p udp --dport 1900 -j DROP
iptables -A INPUT -p udp --sport 1900 -j DROP

# Block known DHT (Distributed Hash Table) ports often used by torrent clients
iptables -A INPUT -p udp --dport 6881:6889 -j DROP
iptables -A INPUT -p udp --dport 6969 -j DROP
iptables -A INPUT -p udp --dport 51413 -j DROP

# Save the iptables rules to a file
iptables-save > /etc/iptables/rules.v4

# Create a systemd service file to load iptables rules at boot
cat <<EOT > /etc/systemd/system/iptables-restore.service
[Unit]
Description=Restore iptables firewall rules
Before=network-pre.target
Wants=network-pre.target
DefaultDependencies=no

[Service]
Type=oneshot
ExecStart=/sbin/iptables-restore < /etc/iptables/rules.v4
ExecReload=/sbin/iptables-restore < /etc/iptables/rules.v4
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOT

# Reload systemd to recognize the new service
systemctl daemon-reload

# Enable the service to load iptables rules at boot
systemctl enable iptables-restore

# Start the service immediately
systemctl start iptables-restore

echo "Torrent blocking rules applied and service created successfully."

sleep 1