# Runbook: DevOps API

## High error rate

1. Подтвердите alert и время начала:
   `sum(rate(http_requests_total{status=~"5.."}[5m])) by (path)`.
2. Сопоставьте начало с deployment/Argo CD history.
3. Найдите request ID в Loki:
   `{app="devops-api"} |= "status=5"`.
4. Проверьте Pods, events, readiness и dependency:
   `kubectl get pods`, `kubectl describe pod`, `kubectl logs`,
   `kubectl get endpoints`.
5. Если причина — новая версия, остановите распространение и выполните
   `helm rollback` либо Git revert для GitOps. Не исправляйте ресурс вручную.
6. Если недоступна БД, не перезапускайте её вслепую: проверьте connection
   saturation, storage, locks и provider status.
7. После восстановления подтвердите normal error rate и закройте alert.
8. Для SEV-1/SEV-2 создайте postmortem.

## High latency

1. Разложите p50/p95/p99 по path.
2. Проверьте CPU/memory throttling, replicas и pending Pods.
3. Проверьте latency/error/saturation базы и сети.
4. Снимите профиль или trace до изменения ресурсов.
5. Масштабирование допустимо как mitigation, но не заменяет root cause.

## Readiness failure

`/ready` проверяет подключение к PostgreSQL. `/health` проверяет только процесс.
Не заменяйте readiness на liveness: иначе сбой БД вызовет бесполезный цикл
перезапуска Pods.
