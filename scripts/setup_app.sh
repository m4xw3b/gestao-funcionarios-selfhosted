#!/bin/bash
# Instalação do Motor e Ambiente
if [ "$EUID" -ne 0 ]; then echo "❌ Corre com sudo"; exit; fi

read -p "Password para o Utilizador SQL 'admin': " DB_PASS

# Instalar pacotes
apt-get install -y postgresql postgresql-contrib python3-pip python3-venv

# Configurar Postgres
sudo -u postgres psql -c "CREATE USER admin WITH PASSWORD '$DB_PASS';"
sudo -u postgres psql -c "CREATE DATABASE gestao_db OWNER admin;"
# Importar o schema criado anteriormente
sudo -u postgres psql -d gestao_db -f ../sql/schema.sql

# Configurar Python
python3 -m venv ../venv
source ../venv/bin/activate
pip install flask psycopg2-binary python-dotenv

# Ficheiro .env
cat <<EOF > ../.env
DB_PASSWORD=$DB_PASS
FLASK_APP=run.py
EOF

echo "✅ App e Base de Dados configuradas!"
