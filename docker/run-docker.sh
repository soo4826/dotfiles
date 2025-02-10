# Naive up
docker compose -f docker-compose.yaml up -d --build

# Specific .env
# docker compose --env-file .env -f docker-compose.yaml up -d --build