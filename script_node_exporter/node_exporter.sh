#/bin/bash

     sudo useradd --no-create-home --shell /usr/sbin/nologin prometheus
     sudo useradd --no-create-home --shell /bin/false node_exporter
     sudo mkdir /etc/prometheus
     sudo mkdir /var/lib/prometheus
     sudo chown prometheus:prometheus /etc/prometheus
     sudo chown prometheus:prometheus /var/lib/prometheus
     wget https://github.com/prometheus/node_exporter/releases/download/v1.5.0/node_exporter-1.5.0.linux-amd64.tar.gz
     tar xvf node_exporter-1.5.0.linux-amd64.tar.gz
     sudo cp node_exporter-1.5.0.linux-amd64/node_exporter /usr/local/bin
     sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter
     rm -rf node_exporter-1.5.0.linux-amd64.tar.gz node_exporter-1.0.1.linux-amd64
     

cat <<'EOF' >>$HOME/node_exporter.service

[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
EOF

     sudo cp node_exporter.service /etc/systemd/system/node_exporter.service
     sudo systemctl daemon-reload
     sudo systemctl start node_exporter
     sudo systemctl status node_exporter
     sudo systemctl enable node_exporter
