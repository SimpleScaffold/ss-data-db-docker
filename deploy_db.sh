#!/bin/bash

set -e

# .env 파일 존재 확인
if [ ! -f .env ]; then
    echo "Error: .env 파일이 존재하지 않습니다."
    echo "Please create .env file from .env.example:"
    echo "cp .env.example .env"
    echo "Then edit .env file with your database configuration."
    exit 1
fi

# .env에서 PROJECT_NAME과 DB_TYPE 읽기
PROJECT_NAME=$(grep PROJECT_NAME .env | cut -d '=' -f2 | tr -d '\r' | xargs)
DB_TYPE=$(grep DB_TYPE .env | cut -d '=' -f2 | tr -d '\r' | xargs)

# PROJECT_NAME이 비어있는지 확인
if [ -z "$PROJECT_NAME" ]; then
    echo "Error: .env 파일에서 PROJECT_NAME을 찾을 수 없습니다."
    exit 1
fi

# DB_TYPE이 비어있는지 확인
if [ -z "$DB_TYPE" ]; then
    echo "Error: .env 파일에서 DB_TYPE을 찾을 수 없습니다."
    echo "Please set DB_TYPE in .env file (mariadb, postgresql, or mongodb)"
    exit 1
fi

echo "Deploying database: $DB_TYPE"

# DB_TYPE에 따라 컨테이너 이름 및 프로필 지정
case "$DB_TYPE" in
  mariadb)
    CONTAINER_NAME="${PROJECT_NAME}-mariadb"
    PROFILE="mariadb"
    ;;
  postgresql)
    CONTAINER_NAME="${PROJECT_NAME}-postgresql"
    PROFILE="postgresql"
    ;;
  mongodb)
    CONTAINER_NAME="${PROJECT_NAME}-mongodb"
    PROFILE="mongodb"
    ;;
  *)
    echo "지원하지 않는 DB_TYPE입니다: $DB_TYPE"
    echo "Supported types: mariadb, postgresql, mongodb"
    exit 1
    ;;
esac


# Docker가 실행 중인지 확인
if ! docker info > /dev/null 2>&1; then
    echo "Error: Docker가 실행되지 않고 있습니다."
    echo "Please start Docker and try again."
    exit 1
fi

# 기존 컨테이너 중지 및 삭제
if [ "$(docker ps -aq -f name="^${CONTAINER_NAME}$")" ]; then
  echo "기존 컨테이너 [$CONTAINER_NAME]가 존재합니다. 삭제 중..."
  docker stop "$CONTAINER_NAME" && docker rm "$CONTAINER_NAME"
fi

# 새로 컨테이너 실행
echo "Starting database container with profile: $PROFILE"
docker compose --env-file .env --profile "$PROFILE" up -d

# 컨테이너 상태 확인
sleep 5
if [ "$(docker ps -q -f name="^${CONTAINER_NAME}$")" ]; then
    echo "✅ 데이터베이스 배포 완료!"
    echo "Container: $CONTAINER_NAME"
    echo "Status: $(docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}' -f name="^${CONTAINER_NAME}$")"
else
    echo "❌ 컨테이너 시작에 실패했습니다."
    echo "Logs:"
    docker compose --env-file .env --profile "$PROFILE" logs
    exit 1
fi
