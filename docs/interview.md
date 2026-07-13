# Самопроверка перед собеседованием

Ответьте вслух без командной строки, затем подтвердите ответ лабораторией.

1. Чем working tree отличается от index и commit?
2. Почему опубликованное изменение безопаснее отменять `revert`, а не reset?
3. Что произойдёт с `"$value"` и `$value`, если значение содержит пробелы?
4. Чем exit code, stdout и stderr полезны в pipeline?
5. Как systemd решает, когда перезапускать процесс?
6. Почему `connection refused` и timeout ведут к разным гипотезам?
7. Как DNS, TCP, TLS и HTTP участвуют в открытии HTTPS URL?
8. Чем container отличается от image и от VM?
9. Почему tag `latest` не обеспечивает воспроизводимость deployment?
10. Чем bind mount отличается от named volume?
11. Какие gates должны предшествовать публикации артефакта?
12. Что означает идемпотентность Ansible?
13. Что хранит Terraform state и почему он чувствителен?
14. Как Deployment, ReplicaSet и Pod связаны через reconciliation loop?
15. Чем readiness probe отличается от liveness probe?
16. Как Service находит Pods и зачем нужен Ingress controller?
17. Почему Kubernetes Secret в base64 не является безопасным хранилищем?
18. Что измеряют RED и USE, чем metric отличается от log?
19. Как SLI, SLO, SLA и error budget связаны между собой?
20. Чем mitigation инцидента отличается от root cause и corrective action?

## Практические задачи

- Найти причину недоступного endpoint, двигаясь по сетевым слоям.
- Исправить конфликт Git и объяснить итоговый граф.
- Уменьшить небезопасный Dockerfile и запустить процесс non-root.
- Написать минимальный GitLab job с artifact и dependency.
- Прочитать Terraform plan и назвать операции create/update/replace/destroy.
- Найти причину Pending/CrashLoopBackOff/NotReady Pod.
- Написать PromQL для 5xx ratio и p95 latency.
- Выполнить rollback и доказать восстановление по SLI.
- Восстановить PostgreSQL backup в отдельное окружение.
- Провести пятиминутный blameless incident review.

Если ответ строится только вокруг названия команды, добавьте: модель работы,
failure modes, безопасность, наблюдаемость и способ отката.
