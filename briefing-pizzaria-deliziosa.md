# Briefing — Pizzaria Deliziosa (Modelo de Referência)

## 1) Contexto & Objetivo
**Objetivo do produto:** Plataforma web/mobile para pedidos de pizza com entrega ou retirada, pagamento online e rastreamento do pedido.
**Proposta de valor:** reduzir tempo médio de pedido, diminuir erros de comunicação e aumentar ticket médio via combos/cupons.

## 2) Público-Alvo & Personas
- **Cliente final (João, 28):** realiza 3–4 pedidos/mês, busca praticidade e cupons.
- **Atendente:** monitora fila, resolve exceções.
- **Gestor:** acompanha vendas, tempo de preparo e satisfação.
- **Entregador (opcional):** recebe rota e registra comprovação de entrega.

## 3) Processo Atual & Dores
Pedidos por telefone/WhatsApp → erros de sabor/endereço/troco, fila em picos, nenhuma visibilidade de status, checkout demorado.

## 4) Escopo do MVP
Catálogo (sabores/tamanhos/adicionais), Carrinho, Checkout (endereço + pagamento), Pedidos (status), Cupons, Admin básico (cardápio, horários, preços, cupons, taxa por zona).
**Fora do MVP:** fidelidade, multilojas, multi-idioma completo.

## 5) Regras de Negócio
1. Pedido só é finalizado com **endereço válido** (CEP + número).
2. **Área de entrega** por zona (Z1/Z2) com taxas diferentes.
3. **Horário de funcionamento:** aceitar pedidos apenas no intervalo configurado.
4. **Tamanho** (P/M/G) altera preço e tempo de forno.
5. **Adicionais:** borda recheada soma R$ 8,00 por pizza.
6. **Cupons** não cumulativos; “PIZZA10” aplica 10% ao subtotal.
7. **Tempo estimado** = preparo + fila + entrega por zona (exibir ao cliente).
8. **Pagamento online** captura imediata; **PIX** com confirmação automática.
9. **Estoque crítico:** falta de ingrediente torna sabor indisponível.
10. **Pedido mínimo** para entrega (ex.: R$ 30,00).
11. **Retirada no balcão** sem taxa; exigir **código de retirada**.
12. **Cancelamento:** até 2 min após pagamento é automático; depois, via atendente.

## 6) Requisitos Funcionais
- **Catálogo:** listar sabores, tamanhos, combos, busca por ingredientes.
- **Carrinho:** alterar quantidades, adicionais, observações.
- **Endereço:** CEP auto-preenchido, múltiplos endereços salvos.
- **Pagamento:** cartão (gateway) e **PIX** (QR + confirmação), pagar na retirada.
- **Pedidos:** status Recebido → Em preparo → Saiu para entrega → Entregue.
- **Cupons:** validação, cálculo e auditoria de uso.
- **Admin:** cardápio, preços, horários, cupons, taxa por zona, fila de pedidos.
- **Notificações:** e-mail/WhatsApp ao mudar status (opcional).

## 7) Requisitos Não Funcionais
- **Performance:** resposta < 1s; pico de **100 pedidos/min** em promoções.
- **Segurança:** OWASP Top 10, LGPD (consentimento/privacidade).
- **Disponibilidade:** 99,5% no horário de funcionamento; **backup diário**.
- **Usabilidade & Acessibilidade:** contraste AA, navegação por teclado.
- **Compatibilidade:** responsivo (mobile-first), navegadores modernos.
- **Observabilidade:** logs de auditoria (pagamentos e cupons).

## 8) Integrações
Pagamentos (gateway + PIX), CEP/Mapa (validação e zona), Mensageria (WhatsApp/SMTP).

## 9) Restrições
Orçamento enxuto; equipe pequena (turma); infra simples; sem multilojas no MVP.

## 10) KPIs
Checkout < 90s; conversão > 3,5%; ticket médio +10%; NPS > 70.

## 11) Riscos & Mitigações
Gateway instável → fallback PIX/retirada; pico de tráfego → fila simples e cache de catálogo; fraude em cupons → limites por usuário/data e antifraude básico.

## 12) Cronograma
- **Sprint 1 (2 sem.)**: Catálogo + Carrinho
- **Sprint 2 (2 sem.)**: Checkout + Pagamentos
- **Sprint 3 (2 sem.)**: Pedidos + Admin + Métricas
- **Go-Live** (soft launch)

## 13) Backlog Inicial (amostra de 12 histórias)
1. Como cliente, quero **listar sabores** para montar meu pedido.
2. Como cliente, quero **filtrar pizzas** por categoria/ingrediente.
3. Como cliente, quero **adicionar/remover** pizzas e adicionais no **carrinho**.
4. Como cliente, quero **aplicar cupom** para obter desconto.
5. Como cliente, quero **calcular taxa/tempo** por zona antes de pagar.
6. Como cliente, quero **salvar endereço** para agilizar futuros pedidos.
7. Como cliente, quero **pagar com PIX** para finalizar rapidamente.
8. Como cliente, quero **acompanhar status** do pedido em tempo real.
9. Como admin, quero **gerenciar cardápio** (sabores, tamanhos, preços).
10. Como admin, quero **definir taxa por zona** (Z1/Z2).
11. Como admin, quero **criar cupons** com validade/limite por usuário.
12. Como atendente, quero **cancelar pedido** sob regras específicas.
