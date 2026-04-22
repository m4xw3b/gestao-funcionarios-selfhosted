#!/bin/bash

# ==============================================================================
# Assistente de Instalação: PostgreSQL, Python e Estrutura de Projeto
# Desenvolvido para: Projeto Gestão de Funcionários (João Fernandes)
# ==============================================================================

if [ "$EUID" -ne 0 ]; then
  echo "❌ Erro: Por favor, corre este script com 'sudo'."
  exit
fi

echo "======================================================"
echo "🐘 CONFIGURAÇÃO DE BASE DE DADOS E AMBIENTE PYTHON"
echo "======================================================"
echo ""

# 1. Pedir credenciais ao utilizador
read -p "👉 Define a password para o utilizador 'admin' do SQL: " DB_PASS
echo ""

# 2. Instalação de pacotes do sistema
echo "⏳ A instalar PostgreSQL, Python3-pip e Venv..."
apt-get update -qq
apt-get install -y postgresql postgresql-contrib python3-pip python3-venv > /dev/null

# 3. Configuração do PostgreSQL (Utilizador e Base de Dados)
echo "-> A criar utilizador 'admin' e base de dados 'gestao_db'..."
sudo -u postgres psql -c "CREATE USER admin WITH PASSWORD '$DB_PASS';"
sudo -u postgres psql -c "CREATE DATABASE gestao_db OWNER admin;"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE gestao_db TO admin;"

# 4. Criação da Estrutura de Pastas do Projeto
echo "-> A criar estrutura de pastas (app, templates, static)..."
mkdir -p app/templates app/static/css app/static/img

# 5. Configuração do Ambiente Virtual (Venv)
echo "-> A criar ambiente virtual Python..."
python3 -m venv venv
source venv/bin/activate

echo "-> A instalar Flask, Psycopg2 e Dotenv..."
pip install flask psycopg2-binary python-dotenv > /dev/null

# 6. Criação do ficheiro de configuração .env
echo "-> A gerar ficheiro .env de segurança..."
cat <<EOF > .env
DB_PASSWORD=$DB_PASS
FLASK_APP=run.py
FLASK_ENV=development
EOF

echo ""
echo "======================================================"
echo "✅ CONFIGURAÇÃO CONCLUÍDA!"
echo "1. Base de Dados 'gestao_db' criada para o user 'admin'."
echo "2. Ambiente Virtual (venv) pronto."
echo "3. Estrutura de pastas montada."
echo "4. Ficheiro .env gerado com a tua password."
echo "======================================================"
echo "Dica: Ativa o ambiente com 'source venv/bin/activate' antes de rodar o projeto."
