# Dominando o Briefing — Guia Completo e Prático

> Objetivo: transformar ideias vagas em requisitos claros, reduzir retrabalho e criar uma ponte direta entre briefing → backlog → implementação.

---

## 1) O que é Briefing e por que é tão importante?

**Briefing** é um **diálogo estruturado** entre cliente e equipe que captura **objetivo do negócio**, **contexto**, *
*regras**, **requisitos** e **restrições** antes de qualquer linha de código. Um bom briefing:

- Evita mal-entendidos e alinha expectativas.
- Converte desejos em requisitos mensuráveis.
- Antecipar riscos e reduzir retrabalho.
- Gera insumos para o Product Backlog (Scrum), casos de uso (RUP) ou features (FDD).

**Antipadrões comuns sem briefing:**

- “Soluções” antes de compreender o problema (**solutioneering**).
- Lista de telas sem regras de negócio por trás.
- Falta de critérios de aceite → “pronto” vira opinião.

---

## 2) Estrutura Essencial do Briefing (com exemplos)

Organize o briefing em blocos. A seguir, um guia com perguntas assertivas e exemplos práticos (use em entrevista com o cliente/usuário).

### 2.1 Contexto e Objetivo

- **Qual problema de negócio resolve?** (ex.: “reduzir fila e erros em pedidos de pizza”)
- **Qual resultado esperado?** (ex.: “+10% de ticket médio, checkout < 90s”)
- **Quem é o público primário?** (ex.: clientes mobile-first)
- **Qual o cenário atual?** (ex.: pedidos por telefone/WhatsApp → erros, sem status)

> **Exemplo de objetivo:** “Lançar um app web/mobile para pedidos de pizza com pagamento online e acompanhamento de
> status, reduzindo tempo de checkout e aumentando conversão.”

### 2.2 Stakeholders e Papéis

- **Cliente/Patrocinador:** decide escopo e orçamento.
- **Usuários-chave (Personas):** Cliente final, Atendente, Gestor, Entregador.
- **Time de Produto:** PO, SM, Devs, QA, Design.

### 2.3 Regras de Negócio (RB)

**RB são políticas do negócio** (independentes de tecnologia) que **devem** ser obedecidas pelo sistema.

- Ex.: “Pedidos de entrega exigem endereço válido (CEP + número).”
- Ex.: “Cupom não é cumulativo; ‘PIZZA10’ dá 10% sobre o subtotal.”
- Ex.: “Horário de funcionamento limita janelas de aceitação.”

> **Boa prática:** toda RB deve ter **condição**, **efeito** e **limite** bem definidos.  
> **Evite:** regras ambíguas do tipo “quando der, dar desconto”.

### 2.4 Requisitos Funcionais (RF) e Não Funcionais (RNF)

- **RF (o que o sistema faz):** catálogo, carrinho, checkout, pagamento, cupons, admin.
- **RNF (como deve ser):** desempenho, segurança, disponibilidade, usabilidade, acessibilidade, compatibilidade,
  observabilidade.

**Exemplos:**

- RF: “Como cliente, quero aplicar cupom para obter desconto.”
- RNF (Desempenho): “Até **100 pedidos/min** em pico; tempo de resposta **< 1s** nas páginas principais.”
- RNF (Segurança): “Aderência a **LGPD** e **OWASP Top 10**.”
- RNF (Disponibilidade): “**99,5%** no horário de funcionamento.”

### 2.5 Escopo e MVP

- **MVP:** versão mínima que entrega valor mensurável.
- **Use MoSCoW:** Must, Should, Could, Won’t (por agora).
- **Fora do MVP:** documente para evitar “escopo fantasma” (ex.: fidelidade avançada, multilojas).

### 2.6 Integrações e Dados

- Pagamentos (cartão + **PIX**), CEP/Mapas (zona de entrega), Mensageria (e-mail/WhatsApp).
- **Política de dados:** coleta mínima, consentimento, guarda e backup.

### 2.7 Restrições, Riscos e Hipóteses

- **Restrições:** orçamento, prazos, equipe, infraestrutura simples.
- **Riscos:** gateway instável, picos de tráfego, fraude em cupons.
- **Hipóteses** (para testar): “Cupom aumenta conversão em +2 p.p.”

### 2.8 KPIs e Métricas de Sucesso

- Tempo de checkout < 90s
- Conversão > 3,5%
- Ticket médio +10% (combos/cupons)
- NPS > 70

---

## 3) Do Briefing ao Backlog (Scrum) — Método de Conversão

1. **Identifique atores** (personas) e **objetivos**.
2. Converta cada necessidade em **User Story**:  
   `Como <persona>, quero <ação> para <benefício>.`
3. Escreva **critérios de aceite (Gherkin)** para cada história.
4. **Priorize** (valor × risco × esforço) e **liste RNF** que se aplicam a várias histórias.
5. Prepare **DoR** (está “pronta” para a Sprint?) e **DoD** (está “feita”?).

**Exemplo de critério de aceite (Gherkin):**

```gherkin
Given um carrinho com itens
When informo o cupom "PIZZA10" válido
Then vejo 10% de desconto no total e o cupom marcado como aplicado
```

---

## 4) Modelos e Tabelas (copie e use)

### 4.1 Roteiro de Entrevista (Perguntas Assertivas)

| Bloco                     | Perguntas-chaves                                                               |
|---------------------------|--------------------------------------------------------------------------------|
| Objetivo                  | Qual problema? Resultado esperado? KPIs?                                       |
| Usuários                  | Quem usa? Cenários críticos?                                                   |
| Processo atual            | Como funciona hoje? Onde dói?                                                  |
| Regras de negócio         | Quais políticas, limites e exceções?                                           |
| Requisitos funcionais     | O que precisa existir no MVP?                                                  |
| Requisitos não funcionais | Desempenho, segurança, disponibilidade, acessibilidade, compatibilidade, logs? |
| Integrações               | Pagamento, CEP/Mapa, mensageria, ERP etc.?                                     |
| Restrições & riscos       | Orçamento, prazos, equipe; riscos técnicos e de produto?                       |
| Cronograma                | Janela de lançamento, marcos?                                                  |
| Sucesso                   | KPIs, como será medido?                                                        |

### 4.2 Checklists

**Briefing Completo**

- [ ] Objetivo de negócio claro
- [ ] Personas e cenários críticos
- [ ] Regras de negócio (≥ 8)
- [ ] RF e RNF priorizados
- [ ] Integrações + fluxos de dados
- [ ] Restrições, riscos e hipóteses
- [ ] KPIs e forma de medição
- [ ] Cronograma (marcos) e janela de lançamento

**DoR (Definition of Ready)**

- [ ] História no formato **Como/Quero/Para**
- [ ] Critérios **Given/When/Then** claros
- [ ] Estimada (1/3/5 pts) e **prioridade** definida
- [ ] RNF aplicáveis referenciados

**DoD (Definition of Done)**

- [ ] Implementado e **testado** (inclua teste de mesa para regras)
- [ ] **Revisado** (pair/PR) e integrado
- [ ] **Demonstrável** na Review (sem “WIP”)

### 4.3 Regras de Negócio (exemplos claros)

| Código | Regra                    | Condição             | Efeito                                |
|--------|--------------------------|----------------------|---------------------------------------|
| RB-001 | Endereço obrigatório     | Checkout com entrega | Bloqueia finalização sem CEP + número |
| RB-002 | Zona e taxa              | CEP válido → Z1/Z2   | Soma taxa Z1=R$6, Z2=R$12             |
| RB-003 | Borda recheada           | Item com extra       | +R$8 por pizza                        |
| RB-004 | Cupom não cumulativo     | Cupom aplicado       | Rejeitar novo cupom                   |
| RB-005 | Horário de funcionamento | Fora do horário      | Exibir indisponibilidade              |
| RB-006 | Cancelamento             | Até 2 min pós-pagto  | Estorno automático                    |
| RB-007 | Pedido mínimo            | Total < R$30         | Bloquear entrega                      |
| RB-008 | Estoque                  | Ingrediente em falta | Desabilitar sabor                     |

### 4.4 RNF por Categoria (exemplos testáveis)

- **Desempenho:** resposta < 1s (p95); 100 pedidos/min em pico.
- **Segurança:** LGPD; OWASP Top 10; logs de auditoria em pagamento/cupons.
- **Disponibilidade:** 99,5% no horário de funcionamento.
- **Usabilidade/Acessibilidade:** WCAG AA; navegação por teclado; textos claros.
- **Compatibilidade:** mobile-first; navegadores modernos.
- **Observabilidade:** métricas de checkout, logs de erro, tracing básico.

---

## 5) Exemplo de Conversão para Código (didático)

**Pseudocódigo:**

```
function total(order):
  assert order.items.length > 0
  subtotal <- sum(item.price * item.qty)
  if order.hasStuffedCrust then subtotal <- subtotal + 8.00
  if order.delivery then subtotal <- subtotal + feeByZone(order.zone)
  if order.coupon == "PIZZA10" then subtotal <- subtotal * 0.90
  return round(subtotal, 2)
```

**JavaScript (nomes em inglês):**

```js
export function calcOrderTotal(order) {
  if (!order?.items?.length) return 0;
  let subtotal = order.items.reduce((acc, it) => acc + it.price * it.qty, 0);
  if (order.hasStuffedCrust) subtotal += 8;
  if (order.delivery) subtotal += (order.zone === 'Z1' ? 6 : 12);
  if (order.coupon === 'PIZZA10') subtotal *= 0.9;
  return Math.round(subtotal * 100) / 100;
}
```

---

## 6) Cronograma e Marcos (exemplo)

- Sprint 1: Catálogo + Carrinho
- Sprint 2: Checkout + Pagamento
- Sprint 3: Pedidos + Admin + Métricas
- Go-Live (soft launch): janela reduzida e suporte próximo

---

## 7) Glossário Rápido

- **Briefing:** entrevista/guia para levantar contexto, regras e requisitos.
- **RB:** regra de negócio (política/limite do negócio).
- **RF/RNF:** requisitos funcionais / não funcionais.
- **MVP:** menor versão do produto que entrega valor.
- **DoR/DoD:** Definition of Ready/Done (prontidão/conclusão).
- **Backlog:** lista priorizada de histórias/itens.
- **Critérios de aceite:** condições objetivas para validar uma história.
- **Gherkin:** sintaxe Given/When/Then para cenários de validação.

---

## 8) Arquivo Modelo
Use as tabelas e checklists desta página para conduzir o briefing real com seu cliente/usuário. Ajuste vocabulário e exemplos ao domínio específico (saúde, educação, varejo, financeiro etc.).

Essência: pergunte “por quê” e “como saberemos que deu certo?”. Converta respostas em requisitos mensuráveis e critérios de aceite.