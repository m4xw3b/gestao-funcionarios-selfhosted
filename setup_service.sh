#!/bin/bash
# Automação para criar o serviço de sistema para a App Flask

USER_NAME=$(whoami)
PROJECT_DIR=$(pwd)

cat <<EOF | sudo tee /etc/systemd/system/gestao_funcionarios.service
[Unit]
Description=Serviço de Gestão de Funcionários - Auchan
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
sudo systemctl enable gestao_funcionarios.service
sudo systemctl start gestao_funcionarios.service

echo "✅ Aplicação configurada como serviço de sistema e em execução!"
