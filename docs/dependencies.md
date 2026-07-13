# Эксплуатация зависимостей

## PostgreSQL

Наблюдайте connections/utilization, transaction rate, slow queries, locks,
deadlocks, replication lag, WAL и disk space. Проверяйте backup через restore.
Приложению выдавайте отдельную роль без superuser и только нужные права.

## Redis/Valkey

Ключевые сигналы: memory usage, evictions, hit ratio, blocked clients,
connections, replication lag и persistence errors. Cache miss не должен
ломать сервис. До выбора eviction policy определите, потеря каких ключей
допустима. Репликация не является backup.

Лаборатория:

```bash
docker run --rm --name valkey -p 6379:6379 valkey/valkey:latest \
  valkey-server --maxmemory 32mb --maxmemory-policy allkeys-lru
docker exec valkey valkey-cli SET lesson complete EX 60
docker exec valkey valkey-cli TTL lesson
docker exec valkey valkey-cli INFO memory
```

## Kafka

Ключевые понятия: broker, topic, partition, replication factor, producer,
consumer group и offset. Наблюдайте under-replicated partitions, offline
partitions, consumer lag, request latency, disk и controller health.
Увеличение partitions меняет распределение ключей и не является безрисковой
операцией.

## Vault

Dev mode допустим только для локальной лаборатории:

```bash
docker run --rm --cap-add=IPC_LOCK -p 8200:8200 \
  -e VAULT_DEV_ROOT_TOKEN_ID=course hashicorp/vault:latest server -dev \
  -dev-listen-address=0.0.0.0:8200
export VAULT_ADDR=http://127.0.0.1:8200 VAULT_TOKEN=course
vault kv put secret/devops-api database_url=postgresql://example
vault kv get secret/devops-api
```

Не коммитьте token или вывод команды. В production нужны TLS, unseal/KMS,
durable storage, audit devices, backup, policy least privilege, auth methods,
leases и проверенная ротация. Kubernetes Secret и base64 не обеспечивают
шифрование сами по себе.
