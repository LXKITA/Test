# Базовая диагностика и hardening

## Сеть: проверяйте снизу вверх

1. Link/address: `ip -brief link`, `ip -brief address`.
2. Route: `ip route get 1.1.1.1`.
3. DNS: `dig +short example.com`, затем `dig +trace example.com`.
4. Socket: `ss -lntup`; установлено ли соединение — `ss -tnp`.
5. TCP: `tcpdump -ni any 'host <IP> and port <PORT>'`.
6. TLS: `openssl s_client -connect host:443 -servername host`.
7. HTTP: `curl --verbose --fail-with-body https://host/path`.
8. Process/service: `systemctl status NAME`, `journalctl -u NAME --since -15m`.

Запишите ожидаемый адрес, route, DNS answer, порт и status code до поиска
отклонения. Timeout обычно указывает на потерю трафика/firewall/route, а
`connection refused` — на достижимый хост без слушающего socket.

## Нет места на диске

1. `df -hT` — заполнение blocks; `df -ih` — inodes.
2. `du -xhd1 /var | sort -h` — крупные каталоги в пределах filesystem.
3. `lsof +L1` — удалённые, но всё ещё открытые файлы.
4. `journalctl --disk-usage` и состояние logrotate.
5. Освободите место контролируемо; не удаляйте неизвестные файлы.
6. Устраните источник роста, проверьте retention и добавьте alert.

## SSH hardening

Перед изменением `sshd_config` откройте второй сеанс и убедитесь, что вход по
ключу работает. Проверяйте конфигурацию через `sshd -t`, затем reload, а не
restart.

- отдельный непривилегированный пользователь;
- `PasswordAuthentication no`;
- `PermitRootLogin no`;
- минимальный список sudo-команд;
- актуальные пакеты и только необходимые listening ports;
- firewall default deny inbound, явные SSH/HTTP/HTTPS rules;
- приватный ключ имеет режим `0600` и никогда не передаётся/не коммитится.

При потере доступа используйте консоль провайдера/VM, а не ослабляйте правила
вслепую.
