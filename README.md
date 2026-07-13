# DevOps за 60 дней

Практический учебный репозиторий для двухмесячного DevOps-интенсива по
[roadmap.sh/devops](https://roadmap.sh/devops/). Он рассчитан на уверенное
пользование Linux и сетями, но не требует опыта с Git и Bash.

## Как учиться

1. Откройте [ежедневную программу](docs/curriculum.md) и выполняйте дни по
   порядку.
2. Тратьте 60–90 минут на материалы, 2,5–3 часа на лабораторную и 30–45 минут
   на конспект и самопроверку.
3. Заполняйте [журнал прогресса](docs/progress.md). День засчитывается только
   после получения указанного артефакта и ответа на вопросы самопроверки.
4. Начиная с 50-го дня используйте этот репозиторий как итоговый проект.

Пометка **«Из вакансий»** обозначает технологии, добавленные после проверки
актуальных российских вакансий: Helm, Argo CD, registry, Vault,
PostgreSQL/Redis/Kafka, SLI/SLO и DevSecOps.

## Итоговый проект

Репозиторий содержит безопасный минимальный Python API и инфраструктурный
каркас:

```text
app/                    HTTP API, health/readiness и Prometheus metrics
deploy/helm/            Kubernetes chart, RBAC и NetworkPolicy
infra/ansible/          идемпотентная роль Nginx
infra/terraform/        учебная инфраструктура Yandex Cloud
monitoring/             Prometheus alerts и Grafana dashboard
nginx/                  reverse proxy
scripts/                Bash/Python лабораторные
docs/runbooks/           эксплуатационные инструкции
.gitlab-ci.yml          lint, tests, security scan, image и Helm
compose.yaml            локальный API + PostgreSQL + Nginx
```

Архитектура и критерии защиты описаны в
[документации проекта](docs/capstone.md).

## Быстрый старт

Требования: Python 3.12+, Docker с Compose v2.

```bash
python3 -m venv .venv
. .venv/bin/activate
python -m pip install -r app/requirements-dev.txt
pytest
docker compose up --build
curl http://localhost/health
curl http://localhost/ready
curl http://localhost/metrics
```

Для остановки и удаления локальных данных:

```bash
docker compose down --volumes
```

Секреты задаются через окружение. Файл `.env` намеренно игнорируется; начните
с `.env.example` и никогда не коммитьте реальные значения.

## Проверки

```bash
python -m pytest
bash -n scripts/*.sh
docker compose config
helm lint deploy/helm/devops-api
terraform -chdir=infra/terraform fmt -check -recursive
terraform -chdir=infra/terraform validate
ansible-playbook --syntax-check infra/ansible/playbook.yml
```

Облачные ресурсы платные. Перед `terraform apply` настройте бюджет и всегда
выполняйте `terraform destroy` после лабораторной.
