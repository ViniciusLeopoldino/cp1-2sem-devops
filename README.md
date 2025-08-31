# Projeto: Migração para Docker Compose

Este documento detalha o processo de migração de um projeto web com banco de dados para um ambiente conteinerizado usando Docker Compose.

## 1. Estrutura do Projeto

* `pom.xml`: Gerenciador de dependências e construção do projeto Maven.
* `Dockerfile`: Contém as instruções para construir a imagem da aplicação.
* `docker-compose.yml`: Define e orquestra os serviços (`app`, `db` e `adminer`), redes e volumes.
* `src/main/resources/application.properties`: Contém as configurações da aplicação.

## 2. Instruções de Uso

Para executar este projeto, certifique-se de ter o **Docker** e o **Docker Compose** instalados.

1.  **Pré-requisitos:** O projeto original, incluindo todos os arquivos Java, HTML e de configuração, deve estar na mesma pasta.
2.  **Construção e Execução:** Execute o comando para iniciar os serviços com Docker Compose:

    ```bash
    docker-compose up -d --build
    ```

    Este comando irá:
    * Construir a imagem da aplicação a partir do `Dockerfile`.
    * Fazer o download das imagens oficiais do PostgreSQL e Adminer.
    * Iniciar os containers da aplicação, do banco de dados e do Adminer em segundo plano.
    * Criar uma rede virtual para a comunicação entre eles.

## 3. Comandos Essenciais do Docker Compose

* `docker-compose up`: Inicia os serviços.
* `docker-compose up -d`: Inicia os serviços em segundo plano.
* `docker-compose down`: Para os serviços.
* `docker-compose down -v`: Para e remove os containers e os volumes persistentes.
* `docker-compose ps`: Verifica o status dos containers.
* `docker-compose logs -f <nome_do_serviço>`: Vê os logs de um serviço específico (ex: `docker-compose logs -f app`).
* `docker-compose exec <nome_do_serviço> bash`: Executa um comando dentro do container.

## 4. Processo de Deploy Passo a Passo

1.  **Configuração dos Arquivos:** O `Dockerfile` e o `docker-compose.yml` já estão configurados para o ambiente de containers.
2.  **Build e Execução:**
    * Navegue até o diretório do projeto no seu terminal.
    * Execute `docker-compose up -d --build`.
3.  **Teste e Validação:**
    * Acesse a aplicação em `[http://localhost:8080](http://localhost:8080/web/brinquedos)`.
    * Acesse o Adminer em `[http://localhost:8081](http://localhost:8081/web/brinquedos)` e conecte-se ao banco de dados:
        * **Sistema:** PostgreSQL
        * **Servidor:** db
        * **Usuário:** user
        * **Senha:** password
        * **Banco de Dados:** brinquedosdb
    * Execute as operações CRUD (criar, listar, editar e deletar) através da interface web da aplicação.
    * No Adminer, verifique se os dados estão na tabela `TDS_TB_Brinquedos`.
    * Para provar a persistência, pare os containers com `docker-compose down -v` (removendo os volumes) e depois inicie-os novamente com `docker-compose up -d`. O banco de dados estará vazio. Repita o teste de persistência sem a flag `-v`.
    * `docker-compose down` e `docker-compose up -d` deve manter os dados.

## 5. Troubleshooting Básico

* **Container não inicia**: Use `docker-compose logs -f app` para verificar o motivo.
* **Conexão com o banco falha**: Verifique as variáveis de ambiente no `docker-compose.yml` e o nome do host (`db`).
* **Erro de `network`**: Confirme se a rede `app-network` está definida e se os serviços estão a utilizando.
