# Skills Index

Краткая навигация по пакету `llm-project-rules-pack`.

## Skills

- `llm-project-start.md` — запуск нового LLM-проекта: бизнес-постановка, метрики, прототип, переход к разработке
- `llm-architecture-decisions.md` — выбор между prompt / RAG / tools / workflow / agent / fine-tuning
- `llm-project-audit.md` — аудит существующего LLM-проекта по 12 правилам
- `llm-production-hardening.md` — усиление production-системы: critic, HITL, downsizing, fine-tuning, serving-оптимизации
- `references/llm-checklist.md` — общий чеклист аудита и фиксации статусов

## Быстрый выбор

- Новый проект → `llm-project-start.md`
- Нужен выбор архитектуры → `llm-architecture-decisions.md`
- Нужен аудит текущей системы → `llm-project-audit.md`
- Нужна оптимизация после прототипа / пилота → `llm-production-hardening.md`
- Нужен единый чеклист → `references/llm-checklist.md`

## Рекомендуемый порядок

1. `llm-project-start.md`
2. `llm-architecture-decisions.md`
3. `llm-project-audit.md`
4. `llm-production-hardening.md`

## Назначение пакета

Пакет нужен, чтобы не смешивать в одном skill:
- запуск проекта
- выбор архитектуры
- аудит
- production-оптимизацию

Основной принцип: сначала бизнес-цель и прототип, потом архитектурные решения, затем аудит и усиление production.
