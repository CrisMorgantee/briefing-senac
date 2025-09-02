# Pizzaria Deliziosa — Scrum Lab (UC9 • Senac)

> Repositório de apoio à aula prática de Scrum da UC9 – Desenvolver Algoritmos. Aqui você encontra o briefing do
> produto, templates de histórias, script para semear o backlog e o roteiro de trabalho do time.

## Sumário

- Objetivo
- Estrutura do Repositório
- Primeiros passos
- Semeando o backlog (12 histórias)
- Workflow (Scrum) — Papéis, Cerimônias e Artefatos
- Definition of Ready (DoR) & Definition of Done (DoD)
- Convenções (labels, branches, commits)
- Critérios de Aceite — exemplo
- Teste de mesa — exemplo
- Roteiro da aula
- Métricas didáticas
- Troubleshooting (gh CLI)
- Licença e Créditos

---

## 📌 Objetivo

Vivenciar um ciclo Scrum completo (Sprint curta) num produto fictício — App da Pizzaria — passando por Briefing →
Backlog → Planning → Execução → Review → Retro. Ao final, cada squad terá um increment demonstrável e artefatos
organizados no GitHub.

---

## 🗂️ Estrutura do Repositório

Como está neste projeto:

```
.
├── .github/
│   └── ISSUE_TEMPLATE/
│       └── user-story.yml
├── docs/
│   ├── briefing-pizzaria-deliziosa.md
│   └── ISSUE_TEMPLATE_USER_STORY.md
└── scripts/
│   └── seed_issues.sh
├── README.md
```

- docs/briefing-pizzaria-deliziosa.md — Briefing do produto e backlog inicial (12 histórias exemplo).
- .github/ISSUE_TEMPLATE/ — Templates para abrir histórias (Issue Form em YAML).
- docs/ISSUE_TEMPLATE_USER_STORY.md — Template markdown alternativo para User Stories.
- scripts/seed_issues.sh — Script Bash para criar labels e semear 12 histórias como issues no GitHub.

---

## 🚀 Primeiros passos (5–10 min)

1) Pré‑requisitos

- Conta no GitHub e GitHub CLI instalado (gh --version).
- Estar autenticado: gh auth login → deve aparecer “Logged in” em gh auth status.
- Issues habilitadas no repositório (se não puder habilitar, peça ao dono do repo).

2) Briefing do produto

- O briefing de referência está em docs/briefing-pizzaria-deliziosa.md. Compare o briefing do seu squad com esse modelo
  ao final da aula.

3) Template de histórias (Issue Form)

- Ao criar “New issue”, escolha User Story e preencha As a / I want / So that + Acceptance Criteria (Given/When/Then).

4) Quadro do GitHub Projects

- Crie um Project (template Team planning) com as colunas: Backlog → Selected for Sprint → In Progress → In Review →
  Done.
- Campos úteis: Story Points (Number), Priority (High/Medium/Low), Sprint (Text), Area (Select:
  Catalog/Cart/Checkout/Orders/Admin).

---

## 🌱 Semeando o backlog (12 histórias)

O script seed_issues.sh automatiza a criação de labels e publica 12 User Stories com critérios de aceite.

No diretório do repositório, rode:

```
chmod +x ./scripts/seed_issues.sh
./scripts/seed_issues.sh
```

Ou especifique o repositório de destino:

```
./scripts/seed_issues.sh owner/repo
```

O script:

- Checa autenticação (gh auth status).
- Auto-detecta ou usa o repositório informado.
- Habilita Issues se necessário.
- Garante labels: feature, area:catalog, area:cart, area:checkout, area:orders, area:admin.
- Cria 12 issues com título, corpo e Story Points; imprime as URLs.

Observação técnica: usa gh api e envia múltiplas labels via parâmetros repetidos labels[]. Compatível com gh recentes (
ex.: 2.78.0) e contorna limitações de gh issue create --json.

---

## 🧭 Workflow (Scrum)

Papéis (tradução e explicação breves):

- PO (Product Owner): prioriza o backlog, maximiza valor do produto e aceita/recusa entregas.
- SM (Scrum Master): facilita cerimônias, remove impedimentos e protege o foco do time.
- Dev Team: planeja, estima, implementa, testa e demonstra o increment ao final da Sprint.

Cerimônias (na aula):

- Sprint Planning (15 min) — selecionar 3–5 histórias (8–13 pts) e quebrar em tarefas.
- Execução (50 min) — mover cards no Project e realizar Dailies a cada 10 min (30–60s por pessoa: fiz, farei,
  impedimentos).
- Review (15 min) — demo do que está Done (atendendo DoD e critérios de aceite).
- Retrospective (10 min) — quadro Parar / Continuar / Começar e 1 melhoria acionável.

Artefatos:

- Product Backlog (issues com user stories), Sprint Backlog (seleção da Sprint), Increment (resultado potencialmente
  entregável).

---

## ✅ Definition of Ready (DoR) & Definition of Done (DoD)

DoR — quando uma história está pronta para entrar na Sprint:

- Descrição clara (As a / I want / So that).
- Acceptance Criteria em Given/When/Then.
- Estimada (1/3/5 pts) e com prioridade definida.

DoD — quando uma história é considerada concluída:

- Implementada e testada (inclua teste de mesa se houver regras de negócio relevantes).
- Revisada (pair/PR) e integrada ao incremento.
- Demonstrável na Review, sem work in progress.

---

## 🏷️ Convenções

Labels: feature, area:catalog, area:cart, area:checkout, area:orders, area:admin

Branches (exemplos):

- feature/apply-coupon-to-cart
- feature/checkout-pix-payment
- feature/order-status-tracking

Commits (sugestão: Conventional Commits):

- feat(cart): add stuffed crust option
- fix(checkout): prevent invalid coupon
- chore(ci): update node version

---

## 📐 Critérios de Aceite — exemplo

```
Given a cart with items
When I enter a valid coupon "PIZZA10"
Then I see 10% off on the total and the coupon is marked as applied
```

---

## 🧪 Teste de mesa (exemplo rápido)

| Caso | Itens                 | Entrega | Cupom   | Esperado |
|-----:|-----------------------|---------|---------|----------|
|    A | 2 × R$30 (sem borda)  | Não     | —       | 60,00    |
|    B | 1 × R$50 (Z2 + borda) | Sim     | PIZZA10 | 55,80    |
|    C | vazio                 | —       | —       | 0,00     |

---

## 🧩 Troubleshooting (gh CLI)

- GraphQL: Could not resolve to a Repository → use o slug real owner/repo ou gh repo view --json nameWithOwner -q
  .nameWithOwner para auto‑detectar.
- unknown flag: --json em gh issue create → o script já usa gh api e não depende desse recurso.
- Issues desabilitadas → Settings → Features → Issues (ou deixe o script habilitar automaticamente).
- Sem permissão para criar labels/issues → verifique permissões no repositório.

---

## 📃 Licença

Uso educacional no contexto da UC9 (Senac).

## 🤝 Créditos

Planejamento didático baseado no plano de aula da UC9, com foco em prática de Scrum, critérios de aceite e teste de
mesa.