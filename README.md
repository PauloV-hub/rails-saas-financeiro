# ContaBoa API - SaaS Financeiro

Esta é a API REST funcional de um SaaS Financeiro, desenvolvida com foco em segurança, escalabilidade e arquitetura isolada de dados. O ecossistema gerencia usuários, categorias e transações de forma totalmente protegida.

### Principais Funcionalidades
* **Autenticação Stateless:** Controle de acesso seguro utilizando tokens JWT via Devise.
* **Arquitetura Multitenant:** Isolamento lógico completo de dados a nível de banco de dados, garantindo privacidade estrita entre contas.
* **Dashboard Temporal Dinâmico:** Endpoints que calculam saldos, receitas e despesas por agregação SQL direta, filtrados dinamicamente por período (mês/ano).

---

### Things covered:

* **Ruby version**
  * Ruby 3.3.x (Rodando via contêiner oficial Docker)
  * Rails 8.1.x

* **System dependencies**
  * Docker e Docker Compose instalados na máquina servidora/desenvolvimento.

* **Configuration**
  * As variáveis de ambiente críticas (como chaves secretas do JWT e credenciais de banco) são gerenciadas de forma segura através do arquivo `.env` na raiz do projeto:
    ```env
    DEVISE_JWT_SECRET_KEY=sua_chave_secreta_aqui
    ```
  * O arquivo `docker-compose.yml` está configurado para carregar o escopo do `.env` automaticamente nos serviços.

* **Database creation**
  * O banco de dados relacional utilizado é o **PostgreSQL 16**.
  * Para criar a estrutura do banco e das tabelas a partir do ambiente isolado, execute:
    ```powershell
    docker compose exec web bundle exec rails db:create
    ```

* **Database initialization**
  * Para aplicar as migrações estruturais (incluindo os relacionamentos e chaves estrangeiras de isolamento multitenant), execute:
    ```powershell
    docker compose exec web bundle exec rails db:migrate
    ```

* **Services (job queues, cache servers, search engines, etc.)**
  * **Redis:** Utilizado como servidor de cache de alta performance e broker de mensagens.
  * **Sidekiq:** Responsável pelo processamento assíncrono de background jobs e filas recorrentes da aplicação.
  * Ambos os serviços sobem e se comunicam nativamente em paralelo através da rede isolada do Docker.

* **Deployment instructions**
  1. Clone o repositório para o servidor de destino.
  2. Configure o arquivo `.env` com as credenciais de produção.
  3. Certifique-se de que o Docker está ativo e execute o comando abaixo para compilar as imagens e iniciar todo o ecossistema em segundo plano:
     ```powershell
     docker compose up -d
     ```
  4. O servidor Puma iniciará automaticamente exposto na porta `3000`.
