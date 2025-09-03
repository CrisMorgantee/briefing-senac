# Briefing — Pizzaria Deliziosa (Modelo de Referência)

> Documento de referência para você montar e validar o seu briefing. Contém os pontos essenciais de alinhamento de negócio e produto para o MVP.

---

## 1) Contexto & Objetivo
- **Objetivo de negócio:** Lançar uma plataforma web/mobile para **pedidos de pizza** com entrega ou retirada, **pagamento online** e **rastreamento de status**.
- **Proposta de valor:** Reduzir tempo de checkout, diminuir erros de pedido e elevar ticket médio via combos/cupons.

## 2) Público-Alvo & Personas
- **Cliente final (João, 28)** — faz 3–4 pedidos/mês, mobile-first, sensível a promoções.
- **Atendente** — monitora fila, trata exceções (cancelamento, troca).
- **Gestor** — acompanha vendas, tempo de preparo, satisfação.
- **Entregador (opcional)** — recebe rota e confirma entrega.

## 3) Processo Atual & Dores
Pedidos por telefone/WhatsApp → **erros** (sabores/endereço/troco), **fila** em pico, **sem status** do pedido e **checkout lento**.

## 4) Escopo do MVP
- **Catálogo** (sabores, tamanhos, adicionais), **Carrinho**, **Checkout** (endereço + pagamento), **Pedidos** (status ao vivo), **Cupons**, **Admin** básico (cardápio, preços, horários, taxas por zona).
- **Fora do MVP:** programa de fidelidade avançado, multilojas, multi-idioma completo.

## 5) Regras de Negócio (exemplos)
1. Finalizar pedido **apenas com endereço válido** (CEP + número).  
2. **Área de entrega** por zona (Z1/Z2) com **taxas distintas**.  
3. **Horário de funcionamento**: aceitar pedidos somente no intervalo configurado.  
4. **Tamanho** (P/M/G) altera **preço** e **tempo de forno**.  
5. **Adicional** de **borda recheada** soma **R$ 8,00** por pizza.  
6. **Cupons não cumulativos**; “PIZZA10” aplica **10%** sobre o **subtotal**.  
7. **Tempo estimado** = preparo + fila + entrega (exibir ao cliente por zona).  
8. **Pagamento online** captura imediata; **PIX** com confirmação automática.  
9. **Estoque crítico**: falta de ingrediente → sabor fica indisponível.  
10. **Pedido mínimo** para entrega: **R$ 30,00**.  
11. **Retirada no balcão** sem taxa; exigir **código de retirada**.  
12. **Cancelamento**: até **2 min** após pagamento é automático; depois, via atendente.

## 6) Requisitos Funcionais (MVP)
- **Catálogo:** listar sabores/tamanhos/adicionais; busca por ingrediente.  
- **Carrinho:** adicionar/remover itens, alterar quantidades, observações.  
- **Endereço:** CEP auto-preenchido; múltiplos endereços salvos.  
- **Pagamento:** cartão (gateway) e **PIX** (QR + confirmação); pagar na retirada.  
- **Pedidos:** status `Recebido → Em preparo → Saiu para entrega → Entregue`.  
- **Cupons:** validação, cálculo e auditoria de uso.  
- **Admin:** gerenciar cardápio, preços, horários, cupons, taxas por zona; fila de pedidos.  
- **Notificações (opcional):** e-mail/WhatsApp em mudança de status.

## 7) Requisitos Não Funcionais
- **Desempenho:** resposta **< 1s** (páginas principais); pico **100 pedidos/min**.  
- **Segurança:** LGPD; **OWASP Top 10**; logs de auditoria (pagamentos/cupons).  
- **Disponibilidade:** **99,5%** no horário de funcionamento; **backup diário**.  
- **Usabilidade/Acessibilidade:** mobile-first, contraste **AA**, navegação por teclado.  
- **Compatibilidade:** navegadores modernos; responsivo.  
- **Observabilidade:** métricas de checkout e erros.

## 8) Integrações
- **Pagamentos:** gateway (cartão) + **PIX**.  
- **Endereço/Mapa:** API de CEP/Geocoding para zona de entrega.  
- **Mensageria:** e-mail/WhatsApp (opcional) para notificações.

## 9) Restrições
- Equipe reduzida; infra simples (um deploy).  
- Orçamento enxuto; sem multilojas no MVP.

## 10) KPIs (indicadores de sucesso)
- **Checkout (p95)** **< 90s**.  
- **Conversão** **≥ 3,5%**.  
- **Ticket médio** **+10%** (combos/cupons).  
- **NPS** **> 70**.

## 11) Riscos & Mitigações
- **Gateway instável** → fallback para **PIX**/retirada.  
- **Pico de tráfego** → cache de catálogo e fila simples no checkout.  
- **Fraude em cupons** → limite por usuário/data, auditoria e antifraude básico.

## 12) Cronograma (exemplo)
- **Sprint 1 (2 sem.)** — Catálogo + Carrinho  
- **Sprint 2 (2 sem.)** — Checkout + Pagamentos  
- **Sprint 3 (2 sem.)** — Pedidos + Admin + Métricas  
- **Go-Live** (soft launch) com janela reduzida

---

> **Observação:** Este briefing modelo é focado no **MVP**. Demandas fora do escopo devem ser registradas para fases futuras.