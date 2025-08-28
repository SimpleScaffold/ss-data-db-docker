# Database Deployment with Docker

[한국어 버전](#도커를-이용한-데이터베이스-배포)

This project provides automated database deployment using Docker Compose. It supports multiple database types: MariaDB, PostgreSQL, and MongoDB.

## Prerequisites

- Docker
- Docker Compose
- Bash shell (for Linux/macOS) or Git Bash (for Windows)

## Quick Start

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd ss-data-db-docker
   ```

2. **Create environment file**
   ```bash
   cp .env.example .env
   # Edit .env file with your database configuration
   ```

3. **Deploy database**
   ```bash
   chmod +x deploy_db.sh
   ./deploy_db.sh
   ```

## Environment Variables

Create a `.env` file with the following variables:

```env
# Project Configuration
PROJECT_NAME=ss
DB_TYPE=mongodb  # Options: mariadb, postgresql, mongodb

# Database Configuration
DB_NAME=auth_db
DB_USERNAME=admin
DB_PASSWORD=your_secure_password
DB_PORT=27017  # Default ports: MariaDB(3306), PostgreSQL(5432), MongoDB(27017)
```

## Supported Databases

| Database | Version | Port | Profile |
|----------|---------|------|---------|
| MariaDB | 11 | 3306 | mariadb |
| PostgreSQL | 16 | 5432 | postgresql |
| MongoDB | 7 | 27017 | mongodb |

## Manual Deployment

You can also deploy manually using Docker Compose:

```bash
# Deploy specific database
docker compose --env-file .env --profile mongodb up -d

# Stop and remove containers
docker compose --env-file .env --profile mongodb down

# View logs
docker compose --env-file .env --profile mongodb logs -f
```

## Data Persistence

Database data is persisted using Docker volumes:
- `ss_mariadb_data`: MariaDB data
- `ss_postgresql_data`: PostgreSQL data  
- `ss_mongodb_data`: MongoDB data

## Troubleshooting

### Common Issues

1. **Port already in use**: Change `DB_PORT` in `.env` file
2. **Permission denied**: Make sure `deploy_db.sh` is executable (`chmod +x deploy_db.sh`)
3. **Container name conflict**: The script automatically removes existing containers

### Logs and Debugging

```bash
# View container logs
docker logs ss-auth-mongodb

# Access database container
docker exec -it ss-auth-mongodb bash

# Check container status
docker ps -a
```

## Project Structure

```
ss-data-db-docker/
├── deploy_db.sh          # Automated deployment script
├── docker-compose.yml    # Docker Compose configuration
├── .env.example         # Environment variables template
├── README.md            # This file
└── db/                  # Database initialization scripts
    ├── mariadb/
    │   └── init-db.sql
    ├── postgresql/
    │   └── init-db.sql
    └── mongodb/
        └── init.js
```

---

# 도커를 이용한 데이터베이스 배포

[English Version](#database-deployment-with-docker)

이 프로젝트는 Docker Compose를 사용하여 데이터베이스 배포를 자동화합니다. MariaDB, PostgreSQL, MongoDB 등 여러 데이터베이스 타입을 지원합니다.

## 사전 요구사항

- Docker
- Docker Compose
- Bash shell (Linux/macOS용) 또는 Git Bash (Windows용)

## 빠른 시작

1. **저장소 클론**
   ```bash
   git clone <repository-url>
   cd ss-data-db-docker
   ```

2. **환경 변수 파일 생성**
   ```bash
   cp .env.example .env
   # .env 파일을 데이터베이스 설정에 맞게 편집
   ```

3. **데이터베이스 배포**
   ```bash
   chmod +x deploy_db.sh
   ./deploy_db.sh
   ```

## 환경 변수

다음 변수들을 포함한 `.env` 파일을 생성하세요:

```env
# 프로젝트 설정
PROJECT_NAME=ss
DB_TYPE=mongodb  # 옵션: mariadb, postgresql, mongodb

# 데이터베이스 설정
DB_NAME=auth_db
DB_USERNAME=admin
DB_PASSWORD=your_secure_password
DB_PORT=27017  # 기본 포트: MariaDB(3306), PostgreSQL(5432), MongoDB(27017)
```

## 지원하는 데이터베이스

| 데이터베이스 | 버전 | 포트 | 프로필 |
|-------------|------|------|--------|
| MariaDB | 11 | 3306 | mariadb |
| PostgreSQL | 16 | 5432 | postgresql |
| MongoDB | 7 | 27017 | mongodb |

## 수동 배포

Docker Compose를 사용하여 수동으로도 배포할 수 있습니다:

```bash
# 특정 데이터베이스 배포
docker compose --env-file .env --profile mongodb up -d

# 컨테이너 중지 및 제거
docker compose --env-file .env --profile mongodb down

# 로그 보기
docker compose --env-file .env --profile mongodb logs -f
```

## 데이터 영속성

데이터베이스 데이터는 Docker 볼륨을 사용하여 영속됩니다:
- `ss_mariadb_data`: MariaDB 데이터
- `ss_postgresql_data`: PostgreSQL 데이터
- `ss_mongodb_data`: MongoDB 데이터

## 문제 해결

### 일반적인 문제

1. **포트가 이미 사용 중**: `.env` 파일에서 `DB_PORT` 변경
2. **권한 거부**: `deploy_db.sh`가 실행 가능한지 확인 (`chmod +x deploy_db.sh`)
3. **컨테이너 이름 충돌**: 스크립트가 기존 컨테이너를 자동으로 제거

### 로그 및 디버깅

```bash
# 컨테이너 로그 보기
docker logs ss-auth-mongodb

# 데이터베이스 컨테이너 접근
docker exec -it ss-auth-mongodb bash

# 컨테이너 상태 확인
docker ps -a
```

## 프로젝트 구조

```
ss-data-db-docker/
├── deploy_db.sh          # 자동화된 배포 스크립트
├── docker-compose.yml    # Docker Compose 설정
├── .env.example         # 환경 변수 템플릿
├── README.md            # 이 파일
└── db/                  # 데이터베이스 초기화 스크립트
    ├── mariadb/
    │   └── init-db.sql
    ├── postgresql/
    │   └── init-db.sql
    └── mongodb/
        └── init.js
```
