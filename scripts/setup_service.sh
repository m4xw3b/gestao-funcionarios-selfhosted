#!/bin/bash
# Criação do Serviço Systemd
USER_NAME=$(whoami)
PROJECT_DIR=$(readlink -f ..)

cat <<EOF | sudo tee /etc/systemd/system/gestao_app.service
[Unit]
Description=Serviço Gestão Funcionários
After=network.target postgresql.service

[Service]
User=$USER_NAME
WorkingDirectory=$PROJECT_DIR
Environment="PATH=$PROJECT_DIR/venv/bin"
EnvironmentFile=$PROJECT_DIR/.env
ExecStart=$PROJECT_DIR/venv/bin/python3 run.py
Restart=always

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable gestao_app.service
sudo systemctl start gestao_app.service
echo "✅ Serviço ativado e em execução!"
