# Database Deployment Automation with Docker

This project provides a simple way to deploy different types of databases (MariaDB, PostgreSQL, MongoDB) using Docker and a shell script.

## Prerequisites

- Docker must be installed and running.
- `docker-compose` (or `docker compose`) must be installed.

## Setup

1.  **Create the environment file:**
    Copy the example environment file to a new `.env` file:
    ```bash
    cp .env.example .env
    ```

2.  **Configure the environment file:**
    Open the `.env` file and edit the variables according to your needs.

    ```
    # Container name - used by docker-compose to prefix container names
    PROJECT_NAME=ss-cool-db

    # Database to use (mariadb, postgresql, or mongodb)
    DB_TYPE=mariadb

    # Port to expose on the host machine
    # Default ports: MariaDB(3306), PostgreSQL(5432), MongoDB(27017)
    DB_PORT=3306

    # Database name
    DB_NAME=mydatabase

    # Database username
    DB_USERNAME=user

    # Database password
    DB_PASSWORD=password
    ```

    - `PROJECT_NAME`: A name for your project. This will be used as a prefix for the Docker container name.
    - `DB_TYPE`: The type of database you want to deploy. Supported values are `mariadb`, `postgresql`, and `mongodb`.
    - `DB_PORT`: The port number to expose on your host machine.
    - `DB_NAME`: The name of the database to create.
    - `DB_USERNAME`: The username for the database.
    - `DB_PASSWORD`: The password for the database user.

## Usage

To deploy the database, run the `deploy_db.sh` script:

```bash
bash deploy_db.sh
```

The script will:
- Read the configuration from the `.env` file.
- Stop and remove any existing container with the same name.
- Start a new Docker container for the selected database.
- Show the status of the container upon completion.

The database will be initialized with a sample `users` table/collection based on the scripts in the `db/` directory.
