# 🏢 Sistema de Gestão de Funcionários (Self-Hosted)

Um projeto Full-Stack focado em infraestrutura independente (Self-Hosting), gestão de dados relacionais e design moderno. 

Este sistema foi concebido para correr num servidor Linux dedicado, isolado numa rede privada (LAN Segment), servindo os clientes através de uma API Flask com uma interface inspirada no **Windows 11 Fluent Design**.

## 🛠️ Stack Tecnológica & Arquitetura

**Infraestrutura de Rede (Ubuntu Server):**
* Servidor DHCP (`isc-dhcp-server`) para atribuição automática de IPs à rede cliente.
* Configuração de IP Estático e rotas via `Netplan`.

**Backend & Dados:**
* **Base de Dados:** PostgreSQL (Relacional, com chaves estrangeiras para Departamentos e Permissões).
* **Lógica:** Python com Micro-framework Flask.
* **Segurança:** Variáveis de ambiente isoladas (`.env`).

**Frontend:**
* HTML5 puro e CSS3 avançado.
* Interface com Efeito *Mica* / *Glassmorphism* (Backdrop-filter).
* Design responsivo e limpo sem dependência de bibliotecas externas pesadas.

## ✨ Funcionalidades Principais
- [x] Operações CRUD completas (Criar, Ler, Atualizar, Apagar).
- [x] Upload e visualização de imagens (Avatares dinâmicos).
- [x] Controlo de Níveis de Permissão (Admin, Gestor, Funcionário).
- [x] Organização estruturada por Departamentos.

## 👨‍💻 Desenvolvido por
**João Fernandes**
