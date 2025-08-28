# Docker를 이용한 데이터베이스 배포 자동화

이 프로젝트는 쉘 스크립트와 Docker를 사용하여 다양한 종류의 데이터베이스(MariaDB, PostgreSQL, MongoDB)를 간편하게 배포하는 방법을 제공합니다.

## 사전 요구 사항

- Docker가 설치되어 있고 실행 중이어야 합니다.
- `docker-compose` (또는 `docker compose`)가 설치되어 있어야 합니다.

## 설정 방법

1.  **환경 변수 파일 생성:**
    `.env.example` 파일을 복사하여 새로운 `.env` 파일을 생성합니다.
    ```bash
    cp .env.example .env
    ```

2.  **환경 변수 파일 설정:**
    `.env` 파일을 열고 필요에 맞게 변수 값을 수정합니다.

    ```
    # 컨테이너 이름 (docker-compose가 컨테이너 이름의 접두사로 사용)
    PROJECT_NAME=ss-cool-db

    # 사용할 데이터베이스 (mariadb, postgresql, mongodb)
    DB_TYPE=mariadb

    # 호스트 머신에 노출할 포트 번호
    # 기본 포트: MariaDB(3306), PostgreSQL(5432), MongoDB(27017)
    DB_PORT=3306

    # 생성할 데이터베이스 이름
    DB_NAME=mydatabase

    # 데이터베이스 사용자 이름
    DB_USERNAME=user

    # 데이터베이스 사용자 비밀번호
    DB_PASSWORD=password
    ```

    - `PROJECT_NAME`: 프로젝트의 이름입니다. Docker 컨테이너 이름의 접두사로 사용됩니다.
    - `DB_TYPE`: 배포할 데이터베이스의 종류입니다. `mariadb`, `postgresql`, `mongodb` 중 하나를 선택할 수 있습니다.
    - `DB_PORT`: 호스트 머신에 노출할 포트 번호입니다.
    - `DB_NAME`: 생성할 데이터베이스의 이름입니다.
    - `DB_USERNAME`: 데이터베이스 사용자의 이름입니다.
    - `DB_PASSWORD`: 데이터베이스 사용자의 비밀번호입니다.

## 사용 방법

데이터베이스를 배포하려면 `deploy_db.sh` 스크립트를 실행합니다.

```bash
bash deploy_db.sh
```

스크립트는 다음 작업을 수행합니다:
- `.env` 파일에서 설정을 읽어옵니다.
- 동일한 이름의 기존 컨테이너가 있으면 중지하고 삭제합니다.
- 선택한 데이터베이스를 위한 새로운 Docker 컨테이너를 시작합니다.
- 완료되면 컨테이너의 상태를 표시합니다.

데이터베이스는 `db/` 디렉토리의 스크립트를 기반으로 예제 `users` 테이블/컬렉션으로 초기화됩니다.
