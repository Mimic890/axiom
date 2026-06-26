# Axiom

Личный AI-агент на базе [nanobot](https://github.com/HKUDS/nanobot). Работает через Telegram, использует несколько моделей через OpenRouter.

## Модели

| Пресет | Модель | Назначение |
|--------|--------|------------|
| `normal` | Xiaomi MiMo-V2.5 | Повседневные задачи, по умолчанию |
| `hard` | Xiaomi MiMo-V2.5-Pro | Сложные задачи |
| `ultra` | Z-AI GLM-5.2 | Ультра-сложные задачи, reasoning |
| `free` | OpenRouter Owl-Alpha | Бесплатный fallback |

Переключение в чате: `/model <пресет>`

## Установка

### Требования

- Linux сервер (Ubuntu/Debian или NixOS)
- Python 3.12+
- [uv](https://docs.astral.sh/uv/) или pip

### 1. Клонирование и конфиг

```bash
git clone https://github.com/Mimic890/axiom.git
cd axiom
```

Скопируй `config.json` и файлы workspace в `~/.nanobot/`:

```bash
mkdir -p ~/.nanobot/workspace/memory
cp config.json ~/.nanobot/
cp -r workspace/* ~/.nanobot/workspace/
```

### 2. Переменные окружения

```bash
cp .env.example ~/.nanobot/.env
# отредактируй ~/.nanobot/.env, добавь свои ключи
chmod 600 ~/.nanobot/.env
```

### 3. Установка nanobot

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
source ~/.local/bin/env
uv tool install nanobot-ai
```

### 4. Запуск

**Ручной:**
```bash
bash -c 'set -a; source ~/.nanobot/.env; set +a; nanobot gateway'
```

**Systemd (Ubuntu/Debian):**
```bash
sudo cp axiom.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now axiom
sudo journalctl -u axiom -f
```

**NixOS:**
```bash
sudo cp axiom.nix /etc/nixos/modules/
# импортируй в /etc/nixos/configuration.nix
sudo nixos-rebuild switch
```

## Структура репозитория

```
axiom/
├── axiom.nix          # NixOS модуль
├── axiom.service      # Systemd сервис для Ubuntu
├── config.json        # Конфигурация nanobot
├── .env.example       # Шаблон переменных окружения
├── .gitignore
├── workspace/
│   ├── SOUL.md        # Личность агента
│   ├── SYSTEM.md      # Правила поведения
│   ├── USER.md        # Профиль пользователя
│   ├── AGENTS.md      # Инструкции для агента
│   ├── HEARTBEAT.md   # Периодические задачи
│   └── memory/        # Долгосрочная память
└── README.md
```

## Лицензия

MIT

---