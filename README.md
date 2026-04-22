🏢 Enterprise HR Management System (Self-Hosted)
Este projeto consiste numa solução completa de gestão de recursos humanos, integrando infraestrutura de redes, base de dados relacional e uma interface moderna. Foi desenvolvido para operar num ambiente de servidor isolado, garantindo a máxima segurança e autonomia na gestão de dados críticos.

A arquitetura de rede foi desenhada para simular um cenário empresarial real, onde o servidor Ubuntu atua como gateway, gerindo o tráfego entre a rede externa e um segmento de LAN privado. Através da implementação de um servidor DHCP nativo, garantimos a conectividade automática para as estações de trabalho clientes.

No coração do sistema encontra-se uma base de dados PostgreSQL, estruturada com integridade referencial para gerir funcionários, departamentos e níveis de permissão. Esta escolha permite uma escalabilidade robusta e consultas complexas, fundamentais para a geração de relatórios e manutenção da consistência dos dados.

A aplicação foi construída em Python utilizando a framework Flask, focando-se em funções básicas e cálculos simples para garantir uma manutenção facilitada. A lógica de negócio está isolada das camadas de apresentação, seguindo os princípios de desenvolvimento modular e boas práticas de engenharia de software.

A interface de utilizador adota o Fluent Design, inspirado no Windows 11, proporcionando uma experiência de utilização fluida e visualmente apelativa através de efeitos de transparência e desfoque. O objetivo foi criar um sistema funcional que, ao mesmo tempo, fosse intuitivo e visualmente integrado no ecossistema moderno.

A persistência do serviço é assegurada através da criação de daemons de sistema no Ubuntu, permitindo que a aplicação se recupere automaticamente de falhas. Todo o processo de deployment é facilitado por scripts de automação, permitindo replicar esta infraestrutura em qualquer servidor em poucos minutos.
🖼️ Demonstração do Projeto
📝 Resumo do Projeto
Sistema de gestão de funcionários self-hosted com infraestrutura de rede isolada, base de dados PostgreSQL e interface inspirada no Windows 11 Fluent Design.

Tags: #ITInfrastructure #Python #Flask #PostgreSQL #LinuxAdmin #SelfHosted #Networking

📂 Estrutura de Ficheiros
Para facilitar a compreensão e manutenção do sistema, o repositório está organizado da seguinte forma:

app/: Contém o núcleo da aplicação, incluindo os modelos de dados (models.py), ficheiros estáticos (CSS/Imagens) e os templates HTML da interface.

scripts/: Suite de automação em Bash para configuração de rede (setup_network.sh), instalação de dependências (setup_app.sh) e criação do serviço de sistema (setup_service.sh).

sql/: Inclui o ficheiro schema.sql, responsável por criar toda a estrutura de tabelas e dados iniciais na base de dados PostgreSQL.

.env.example: Ficheiro de exemplo para configuração de variáveis de ambiente, servindo de guia para o utilizador configurar as suas próprias credenciais.

.gitignore: Define as regras de exclusão para o Git, impedindo que ficheiros sensíveis (como a password do DB no .env) ou pastas temporárias sejam partilhados.

run.py: O ponto de entrada da aplicação Flask, responsável por inicializar o servidor web e as rotas principais.

README.md: Documentação técnica completa e guia de instalação do projeto.

projeto_gestao_funcionarios*.jpg: Capturas de ecrã para demonstração visual da interface e funcionalidades do sistema.

👨‍💻 Desenvolvido por
João Fernandes 
