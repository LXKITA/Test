# Disaster recovery

## Цели учебного сервиса

- RPO: 24 часа.
- RTO: 60 минут.
- Владелец восстановления: дежурный инженер; подтверждение данных — владелец
  приложения.

## Backup

Ежедневный logical backup PostgreSQL:

```bash
docker compose exec -T database pg_dump \
  --username "$POSTGRES_USER" --format=custom "$POSTGRES_DB" \
  > "backups/postgres-$(date -u +%Y%m%dT%H%M%SZ).dump"
```

Копия должна шифроваться и храниться в другом failure domain. Snapshot диска
не заменяет application-consistent backup. Наличие файла не считается
успешным backup без проверки restore.

## Restore drill

1. Зафиксировать начало и SHA-256 backup.
2. Создать чистую временную БД, не перезаписывая production.
3. Выполнить `pg_restore --exit-on-error --clean --if-exists`.
4. Проверить ожидаемые таблицы, количество строк и контрольную бизнес-выборку.
5. Запустить приложение против восстановленной БД и smoke tests.
6. Зафиксировать фактические RPO/RTO и удалить временные ресурсы.

## Потеря кластера

1. Объявить инцидент и заморозить deployments.
2. Восстановить инфраструктуру из Terraform, platform services и Argo CD.
3. Восстановить данные из последней проверенной копии.
4. Синхронизировать workload из Git, выполнить smoke tests.
5. Переключить traffic контролируемо; наблюдать SLI.
6. Провести postmortem и обновить этот runbook.
