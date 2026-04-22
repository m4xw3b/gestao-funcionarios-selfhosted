# 🏢 Sistema de Gestão de Funcionários (Self-Hosted)

> **Resumo:** Plataforma full-stack em Python/Flask para gestão de recursos humanos, alojada em servidor Ubuntu com rede isolada, DHCP próprio e base de dados PostgreSQL.

**Tags:** `#Python` `#Flask` `#UbuntuServer` `#PostgreSQL` `#SelfHosted` `#Networking` `#FluentDesign`

---

## 📖 Sobre o Projeto
Este projeto simula um ambiente empresarial real e isolado. Foi concebido para correr num servidor Linux dedicado, atuando como o seu próprio router e gestor de rede, servindo os clientes através de uma API Flask com uma interface inspirada no **Windows 11 Fluent Design**.

## 🛠️ Stack Tecnológica & Arquitetura

### 1. Infraestrutura de Rede (O Laboratório)
O ambiente utiliza duas Máquinas Virtuais para garantir isolamento e segurança:
* **Ubuntu Server (Router/Gateway):** Configurado com duas placas de rede. Uma em modo Bridge (para acesso à Internet) e outra num LAN Segment interno.
* **Cliente Windows 10:** Configurado no LAN Segment, sem acesso direto à internet física.
* **Automação DHCP:** O servidor Ubuntu utiliza o `isc-dhcp-server` para atribuir IPs dinamicamente à rede cliente. As rotas e IPs estáticos do servidor são geridos via `Netplan`.

### 2. Backend & Persistência de Dados
* **Base de Dados:** PostgreSQL (Relacional). Estruturada com chaves estrangeiras ligando `Departamentos`, `Permissoes` e `Funcionarios`.
* **Lógica de Servidor:** Python com o micro-framework Flask.
* **Segurança:** Utilização de ambientes virtuais (`venv`) e isolamento de credenciais através de variáveis de ambiente (`.env`).

### 3. Frontend (Interface de Utilizador)
* HTML5 puro e CSS3 avançado, injetados via `Jinja2`.
* Interface com Efeito *Mica* / *Glassmorphism* (`backdrop-filter: blur(20px)`).
* Sistema de formulários dinâmicos com suporte a upload de ficheiros (Avatares).

---

## ✨ Funcionalidades Principais
- [x] **Operações CRUD Completas:** Ler, Adicionar, Editar e Apagar registos de funcionários.
- [x] **Gestão de Ficheiros:** Upload seguro e visualização dinâmica de imagens de perfil.
- [x] **Controlo de Acessos:** Níveis de Permissão estruturados (Admin, Gestor, Funcionário).
- [x] **Script de Setup Automático:** Script Bash (`setup_rede.sh`) incluído para automatizar futuras configurações de Netplan e DHCP em novos servidores.

---

## ⚙️ Guia Rápido de Instalação (Servidor Novo)

Caso necessite de replicar a infraestrutura num servidor Ubuntu limpo, execute o script de automação de rede fornecido na raiz do projeto:

```bash
chmod +x setup_rede.sh
sudo ./setup_rede.sh
