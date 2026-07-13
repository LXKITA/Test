# Ежедневная программа

Каждый урок занимает 4–5 часов: теория (60–90 минут), практика (2,5–3 часа),
конспект и самопроверка (30–45 минут). Ссылки проверены при составлении курса
13 июля 2026 года. Актуальный синтаксис всегда сверяйте с официальной
документацией инструмента.

## Дни 1–7: Git и Bash

### День 1. DevOps, SDLC и стенд
- Материалы: [DevOps Roadmap](https://roadmap.sh/devops/),
  [DevOps — Yandex Cloud](https://yandex.cloud/ru/docs/glossary/devops),
  [Pro Git: введение](https://git-scm.com/book/ru/v2/Введение-О-системе-контроля-версий).
- Практика: подготовьте Ubuntu 24.04 VM, Git, Python и Docker; нарисуйте путь
  commit → CI → registry → deployment → monitoring.
- Артефакт: схема и описание различий CI, delivery и deployment.

### День 2. Git: жизненный цикл файла
- Материалы: [Pro Git: основы](https://git-scm.com/book/ru/v2/Основы-Git-Создание-Git-репозитория).
- Практика: `init/status/add/commit/diff`, `.gitignore`, пять атомарных
  коммитов и сравнение staged/unstaged.
- Артефакт: чистый `git status` и понятная история.

### День 3. Git: история и восстановление
- Материалы: [история](https://git-scm.com/book/ru/v2/Основы-Git-Просмотр-истории-коммитов),
  [отмена](https://git-scm.com/book/ru/v2/Основы-Git-Отмена-изменений).
- Практика: `log/show/restore/revert/reset`; восстановите файл тремя способами
  и безопасно отмените опубликованный commit.
- Артефакт: таблица команд для working tree, index и commits.

### День 4. Git: ветки и конфликты
- Материалы: [ветки](https://git-scm.com/book/ru/v2/Ветвление-в-Git-Ветки-в-Git),
  [merge](https://git-scm.com/book/ru/v2/Ветвление-в-Git-Основы-ветвления-и-слияния).
- Практика: две feature-ветки, fast-forward, merge commit и ручное разрешение
  конфликта.
- Артефакт: `git log --graph --oneline --all`.

### День 5. Git: remote
- Материалы: [удалённые репозитории](https://git-scm.com/book/ru/v2/Основы-Git-Работа-с-удалёнными-репозиториями),
  [GitLab SSH](https://docs.gitlab.com/user/ssh/).
- Практика: SSH-ключ, clone/fetch/pull/push и merge request.
- Артефакт: опубликованная ветка без ключей и секретов.

### День 6. Bash: shell и потоки
- Материалы: [Bash manpage на русском](https://man.archlinux.org/man/bash.1.ru).
- Практика: quoting, environment, exit codes, stdin/stdout/stderr и pipes;
  доработайте `scripts/system-report.sh`.
- Артефакт: отчёт об ОС, CPU, памяти и дисках без ошибок ShellCheck.

### День 7. Bash: управляющие конструкции
- Материалы: [Bash manual](https://man.archlinux.org/man/bash.1.ru).
- Практика: `if/case/for/while`, functions, traps, `grep/awk/xargs`;
  протестируйте `scripts/backup.sh` на успехе и трёх ошибках.
- Артефакт: backup с retention, журналом и строгой обработкой ошибок.

## Дни 8–17: Python, Linux и сеть

### День 8. Python для автоматизации
- Материал: [Хендбук Python](https://education.yandex.ru/handbook/python).
- Практика: JSON-инвентарь → фильтрация серверов → CSV.
- Артефакт: небольшой скрипт с функциями и понятным CLI.

### День 9. Python CLI
- Материалы: [Хендбук](https://education.yandex.ru/handbook/python),
  [Python tutorial RU](https://pythondoc.ru/docs/python/3.10/tutorial/).
- Практика: `pathlib/json/argparse/logging/exceptions`; запустите
  `scripts/healthcheck.py` для успешного URL, timeout и неверного URL.
- Артефакт: предсказуемые коды возврата 0/1/2.

### День 10. Python, HTTP и subprocess
- Материалы: [requests](https://education.yandex.ru/handbook/python/article/modul-requests),
  [subprocess](https://docs.python.org/3/library/subprocess.html).
- Практика: объедините локальные метрики и HTTP healthcheck в JSON; не
  используйте `shell=True`.
- Артефакт: диагностический отчёт, вызываемый из Bash.

### День 11. Пользователи и права Linux
- Материал: [Debian Administrator’s Handbook](https://debian-handbook.info/browse/ru-RU/stable/index.html).
- Практика: service user без login, group directory, umask/ACL и минимальное
  sudo-правило.
- Артефакт: позитивные и негативные тесты доступа.

### День 12. Процессы и systemd
- Материал: [сервисы Unix](https://debian-handbook.info/browse/ru-RU/stable/unix-services.html).
- Практика: установите `systemd/devops-healthcheck.service` и `.timer`,
  вызовите сбой и найдите его через `journalctl`.
- Артефакт: unit-файлы и runbook диагностики.

### День 13. Диски, пакеты и логи
- Материал: [Debian Handbook](https://debian-handbook.info/browse/ru-RU/stable/index.html).
- Практика: loopback filesystem, заполнение места, inode check и logrotate.
- Артефакт: чек-лист «нет места на диске».

### День 14. Сетевой troubleshooting
- Материалы: [курс сетей](https://asozykin.ru/courses/networks_online),
  [сеть Debian](https://debian-handbook.info/browse/ru-RU/stable/network-infrastructure.html).
- Практика: `ip/ss/dig/curl/traceroute/tcpdump`; снимите DNS и TCP handshake.
- Артефакт: `docs/runbooks/network.md`.

### День 15. HTTP, DNS и TLS
- Материалы: [DNS](https://www.cloudflare.com/ru-ru/learning/dns/what-is-dns/),
  [HTTPS](https://developer.mozilla.org/ru/docs/Glossary/HTTPS),
  [ACME](https://letsencrypt.org/ru/docs/challenge-types/).
- Практика: `dig +trace`, `curl -v`, `openssl s_client`.
- Артефакт: схема DNS → TCP → TLS → HTTP.

### День 16. Nginx
- Материалы: [руководство Nginx](https://nginx.org/ru/docs/beginners_guide.html),
  [обработка запросов](https://nginx.org/ru/docs/http/request_processing.html).
- Практика: установите `nginx/default.conf`, отдайте статику и
  проксируйте API; проверьте graceful reload.
- Артефакт: воспроизводимая конфигурация и access/error logs.

### День 17. SSH, firewall и hardening
- Материалы: [nftables](https://debian-handbook.info/browse/ru-RU/stable/sect.firewall-packet-filtering.html),
  [Debian Handbook](https://debian-handbook.info/browse/ru-RU/stable/index.html).
- Практика: key-only SSH после проверки второго сеанса, минимальный firewall,
  audit открытых портов.
- Артефакт: `docs/runbooks/hardening.md`; сохраните рабочий доступ к VM.

## Дни 18–30: доставка и Infrastructure as Code

### День 18. Модель Docker
- Материал: [Docker с нуля](https://selectel.ru/blog/courses/docker-from-scratch/).
- Практика: run/inspect/logs/exec/stats, port/volume и эфемерность контейнера.
- Артефакт: таблица различий контейнера и VM.

### День 19. Dockerfile
- Материал: [создание образа](https://selectel.ru/blog/tutorials/how-to-create-docker-image/).
- Практика: разберите `app/Dockerfile`: cache, multi-stage, non-root,
  healthcheck и `.dockerignore`.
- Артефакт: минимальный воспроизводимый image.

### День 20. Docker network и storage
- Материалы: [Docker](https://selectel.ru/blog/courses/docker-from-scratch/),
  [Compose](https://selectel.ru/blog/docker-compose/).
- Практика: app → PostgreSQL по service DNS, named volume и persistence.
- Артефакт: схема сети `compose.yaml`.

### День 21. Compose
- Материал: [Docker Compose](https://selectel.ru/blog/docker-compose/).
- Практика: поднимите Nginx + API + PostgreSQL, проверьте healthchecks,
  restart и удаление/recreate контейнеров.
- Артефакт: локальная контрольная точка, запускаемая одной командой.

### День 22. GitLab CI/CD
- Материалы: [pipeline](https://habr.com/ru/companies/maxilect/articles/799177/),
  [видеокурс](https://www.youtube.com/playlist?list=PLg5SS_4L6LYuJxTrdU5vzBaVGlZko8Hsy).
- Практика: изучите lint/test/build jobs в `.gitlab-ci.yml`.
- Артефакт: зелёный pipeline на push.

### День 23. Quality gates
- Материал: [stages и needs](https://habr.com/ru/companies/otus/articles/841474/).
- Практика: test до build, `needs`, rules, protected variables и SHA tags.
- Артефакт: DAG pipeline, не печатающий secrets.

### День 24. Registry **[Из вакансий]**
- Материалы: [push в YC Registry](https://yandex.cloud/ru/docs/container-registry/operations/docker-image/docker-image-push),
  [права](https://yandex.cloud/ru/docs/container-registry/security/).
- Практика: push SHA/version tag, затем pull по digest и least-privilege access.
- Артефакт: прослеживаемый immutable image.

### День 25. Ansible
- Материал: [Ansible — Selectel](https://selectel.ru/blog/sistema-upravleniya-konfiguraciej-ansible/).
- Практика: запустите `infra/ansible/playbook.yml` на учебной VM дважды.
- Артефакт: второй запуск сообщает `changed=0`.

### День 26. Ansible role
- Материалы: [Ansible — Selectel](https://selectel.ru/blog/sistema-upravleniya-konfiguraciej-ansible/),
  [официальная документация](https://docs.ansible.com/projects/ansible/latest/index.html).
- Практика: variables, template, handler и encrypted secret.
- Артефакт: переиспользуемая роль `nginx`.

### День 27. Terraform
- Материалы: [курс Terraform](https://yandex.cloud/ru/training/terraform),
  [quickstart](https://yandex.cloud/ru/docs/tutorials/infrastructure-management/terraform-quickstart).
- Практика: init/validate/plan, затем apply только с бюджетом; завершите destroy.
- Артефакт: прочитанный до применения plan.

### День 28. State и modules
- Материал: [модули YC](https://yandex.cloud/ru/docs/terraform/tutorials/terraform-modules).
- Практика: module, version constraints, sensitive variables, drift; state и
  `.tfvars` не должны попасть в Git.
- Артефакт: модульный IaC и чистый `git status`.

### День 29. Yandex Cloud
- Материалы: [курсы YC](https://yandex.cloud/ru/training/training-pro),
  [документация](https://yandex.cloud/ru/docs/).
- Практика: VPC, subnet, security group, service account и VM по least
  privilege через Terraform.
- Артефакт: схема и уничтоженный после проверки стенд.

### День 30. Эксплуатация облака
- Материал: [документация YC](https://yandex.cloud/ru/docs/).
- Практика: cloud-init, budget alert, snapshot/restore; сопоставьте
  YC Compute/VPC/IAM и AWS EC2/VPC/IAM.
- Артефакт: runbook создания и teardown.

## Дни 31–42: Kubernetes, GitOps и observability

### День 31. Архитектура Kubernetes
- Материалы: [Kubernetes RU](https://kubernetes.io/ru/docs/home/),
  [курс Selectel](https://selectel.ru/blog/courses/dive-into-kubernetes/).
- Практика: Kind/Minikube и cluster-info/get/describe/logs/events.
- Артефакт: схема control plane и cheat sheet.

### День 32. Workloads
- Материалы: [Kubernetes](https://kubernetes.io/ru/docs/home/),
  [kubectl](https://kubernetes.io/ru/docs/reference/kubectl/overview/).
- Практика: Deployment, probes, resources, rolling update и rollback.
- Артефакт: восстановление после плохого rollout.

### День 33. Конфигурация
- Материал: [Kubernetes](https://kubernetes.io/ru/docs/home/).
- Практика: ConfigMap, Secret, namespace, quota и service account.
- Артефакт: config отсутствует в image, secret отсутствует в Git.

### День 34. Service и Ingress
- Материалы: [сеть K8s](https://kubernetes.io/ru/docs/concepts/cluster-administration/networking/),
  [Ingress](https://docs.selectel.ru/managed-kubernetes/networks/loadbalancing-with-ingress/set-up-ingress/).
- Практика: debug Pod → DNS → Service → Pod и host routing.
- Артефакт: запрос через Ingress виден в логах.

### День 35. Storage
- Материалы: [тома](https://yandex.cloud/ru/docs/managed-kubernetes/concepts/volume),
  [StorageClass](https://yandex.cloud/ru/docs/managed-kubernetes/operations/volumes/manage-storage-class).
- Практика: PVC, recreate Pod и persistence; изучите reclaim policy.
- Артефакт: схема жизненного цикла тома.

### День 36. Helm **[Из вакансий]**
- Материалы: [Helm](https://helm.sh/ru/docs/),
  [templates](https://helm.sh/ru/docs/chart_template_guide/getting_started/).
- Практика: lint/template/install/upgrade/rollback chart из `deploy/helm`.
- Артефакт: dev/prod values и успешный rollback.

### День 37. NetworkPolicy
- Материалы: [сеть K8s](https://habr.com/ru/articles/886528/),
  [NetworkPolicy](https://habr.com/ru/companies/beeline_cloud/articles/857972/).
- Практика: default deny и точечные app → DB, ingress → app rules.
- Артефакт: позитивные и негативные сетевые тесты.

### День 38. RBAC
- Материалы: [Kubernetes](https://kubernetes.io/ru/docs/home/),
  [DevSecOps](https://yandex.cloud/ru-kz/training/devsecops).
- Практика: `kubectl auth can-i`, non-root, drop capabilities, read-only root.
- Артефакт: минимальные права приложения.

### День 39. Argo CD **[Из вакансий]**
- Материалы: [GitOps](https://yandex.cloud/ru/training/deploy),
  [Argo CD](https://habr.com/ru/companies/oleg-bunin/articles/952900/).
- Практика: установите `deploy/argocd/application.yaml`, вызовите drift и
  восстановите состояние из Git.
- Артефакт: Git — источник желаемого состояния.

### День 40. Prometheus
- Материалы: [Managed Prometheus](https://yandex.cloud/ru/docs/monitoring/operations/prometheus/),
  [лабораторная](https://wikival.bmstu.ru/doku.php?id=prometheus_grafana_loki_-_observability).
- Практика: scrape `/metrics`, RED/USE и четыре PromQL-запроса.
- Артефакт: traffic/errors/latency/saturation queries.

### День 41. Grafana и alerts
- Материал: [Monitoring Stack](https://yandex.cloud/ru/docs/stackland/concepts/components/monitoring).
- Практика: импортируйте dashboard, установите rules, вызовите alert/recovery.
- Артефакт: actionable alerts и связанный runbook.

### День 42. Loki и ELK **[Из вакансий]**
- Материалы: [Logging Stack](https://yandex.cloud/ru/docs/stackland/concepts/components/logging),
  [Loki](https://yandex.cloud/ru/docs/managed-kubernetes/operations/applications/loki),
  [Cloud Search](https://cloud.ru/docs/css/ug/index).
- Практика: JSON logs → Loki → Grafana, поиск request ID и ошибки.
- Артефакт: LogQL query и отсутствие secrets/PII в логах.

## Дни 43–49: SRE и DevSecOps

### День 43. SLI/SLO/SLA **[Из вакансий]**
- Материал: [Atlassian](https://www.atlassian.com/ru/incident-management/kpis/sla-vs-slo-vs-sli).
- Практика: рассчитайте availability/latency SLI, 30-дневный SLO и error
  budget в `docs/slo.md`.
- Артефакт: формулы и источники данных.

### День 44. Инциденты **[Из вакансий]**
- Материалы: [справочник](https://www.atlassian.com/ru/incident-management/handbook),
  [blameless postmortem](https://www.atlassian.com/ru/incident-management/postmortem/blameless).
- Практика: плохой deployment, rollback, timeline и postmortem.
- Артефакт: заполненный `docs/postmortem-template.md`.

### День 45. Security pipeline **[Из вакансий]**
- Материалы: [DevSecOps](https://yandex.cloud/ru-kz/training/devsecops),
  [Trivy](https://redos.red-soft.ru/base/redos-8_0/8_0-security/8_0-scan-vuln/8_0-trivy/).
- Практика: image/filesystem/IaC/secret scan и исправление critical finding.
- Артефакт: блокирующий security job с обоснованной allowlist.

### День 46. Vault **[Из вакансий]**
- Материалы: [Vault в K8s](https://yandex.cloud/ru/docs/managed-kubernetes/operations/applications/hashicorp-vault),
  [секреты](https://yandex.cloud/ru/docs/managed-kubernetes/tutorials/marketplace/hashicorp-vault).
- Практика: локальный dev Vault, KV и ротация; не используйте dev mode вне
  лаборатории.
- Артефакт: схема потока секрета без Git/image.

### День 47. PostgreSQL **[Из вакансий]**
- Материалы: [введение](https://postgrespro.ru/education/books/introbook),
  [DBA1](https://edu.postgrespro.ru/16/dba1-16/dba1_00_introduction.html).
- Практика: limited role, `pg_dump`, удаление, restore и verification.
- Артефакт: проверенный backup/restore runbook.

### День 48. Redis/Valkey и Kafka **[Из вакансий]**
- Материалы: [Redis](https://cloud.ru/docs/redis/ug/topics/concepts__basic-commands),
  [Valkey](https://yandex.cloud/ru/docs/managed-valkey/),
  [Kafka](https://yandex.cloud/ru/docs/managed-kafka/).
- Практика: TTL/eviction и producer/consumer; определите failure modes.
- Артефакт: таблица метрик DB/cache/broker.

### День 49. Backup и DR
- Материалы: [PostgreSQL DBA1](https://edu.postgrespro.ru/16/dba1-16/dba1_00_introduction.html),
  [инциденты](https://www.atlassian.com/ru/incident-management/handbook).
- Практика: restore в чистое окружение, измерьте RTO, задайте RPO.
- Артефакт: `docs/runbooks/disaster-recovery.md`.

## Дни 50–60: итоговый проект

### День 50. Архитектура
Прочитайте `docs/capstone.md`, нарисуйте собственную схему, threat model,
acceptance criteria и ADR. Обоснуйте каждую технологию.

### День 51. Приложение
Разберите `app/`, добавьте endpoint и тест. Артефакт: testable API с
health/readiness/metrics и чистой структурой.

### День 52. Контейнеризация
С чистого окружения запустите Compose, миграцию, backup и smoke test.
Артефакт: стек одной командой.

### День 53. CI
Прогоните lint → tests → build → scans → push → Helm package. Релиз разрешён
только для tag. Артефакт: повторяемый pipeline.

### День 54. IaC
Terraform plan/apply/destroy и два запуска Ansible. Артефакт: предсказуемый
plan, `changed=0`, отсутствие state/secrets в Git.

### День 55. Kubernetes
Установите chart, проверьте probes/resources/security/NetworkPolicy и rollout.
Артефакт: доступ через Ingress и self-healing.

### День 56. GitOps
Измените image tag через MR, выполните Argo sync и rollback через Git revert.
Артефакт: полный commit → image → GitOps → cluster trace.

### День 57. Observability
Создайте load/error, покажите metrics/logs/dashboard/alert и SLO.
Артефакт: dashboard, rules и runbook.

### День 58. Failure drills
Удалите Pod, сломайте readiness, остановите DB и ротируйте secret. Запишите
MTTR и исправления в журнал экспериментов.

### День 59. Документация и интервью
Дайте незнакомому человеку поднять проект по README. Ответьте вслух на вопросы
из `docs/interview.md` и сравните навыки с десятью свежими вакансиями.

### День 60. Защита
С чистого стенда: deploy, изменение через MR, CI/GitOps, инцидент/rollback,
restore, dashboard и postmortem. Запишите 10–15-минутное demo и составьте
персональный backlog на 90 дней.
