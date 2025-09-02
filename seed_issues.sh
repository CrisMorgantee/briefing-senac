#!/usr/bin/env bash
# Usage: ./seed_issues.sh owner/repo
# Requires GitHub CLI: https://cli.github.com/
set -euo pipefail

if ! command -v gh >/dev/null 2>&1; then
  echo "GitHub CLI (gh) is required. Install from https://cli.github.com/"
  exit 1
fi

if [ $# -ne 1 ]; then
  echo "Usage: $0 owner/repo"
  exit 1
fi

REPO="$1"

create_issue () {
  local title="$1"
  local body="$2"
  local labels="${3:-feature}"
  local points="${4:-3}"
  gh issue create -R "$REPO" -t "$title" -b "$body\n\n**Story Points:** $points" -l "$labels"
}

read -r -d '' AC_LISTAR << 'MD'
As a Customer
I want to list pizza flavors
So that I can choose items for my order

Acceptance Criteria:
- Given I access the catalog, When the page loads, Then I see list of flavors with price and size.
- Given I search by ingredient, When I type "calabresa", Then I see matching pizzas.
MD

read -r -d '' AC_FILTRAR << 'MD'
As a Customer
I want to filter pizzas by category/ingredient
So that I can quickly find what I want

Acceptance Criteria:
- Given the catalog, When I select "Vegetarian", Then only vegetarian pizzas are displayed.
MD

read -r -d '' AC_CARRINHO << 'MD'
As a Customer
I want to add/remove items and extras to the cart
So that I can customize my order

Acceptance Criteria:
- Given the catalog, When I click "Add", Then the item appears in the cart with qty 1.
- Given a cart item, When I add stuffed crust, Then total increases by R$8.00.
MD

read -r -d '' AC_CUPOM << 'MD'
As a Customer
I want to apply a coupon
So that I get a discount

Acceptance Criteria:
- Given a cart with items, When I enter PIZZA10, Then I see 10% off and coupon flagged as applied.
- Given an invalid coupon, When I apply, Then I see a clear error.
MD

read -r -d '' AC_TAXA << 'MD'
As a Customer
I want to see fee/time by delivery zone
So that I can decide to proceed

Acceptance Criteria:
- Given my address, When the CEP is valid, Then I see zone Z1/Z2, fee and ETA.
MD

read -r -d '' AC_ENDERECO << 'MD'
As a Customer
I want to save my address
So that next orders are faster

Acceptance Criteria:
- Given I enter a valid CEP/number, Then the address can be saved and reused.
MD

read -r -d '' AC_PIX << 'MD'
As a Customer
I want to pay with PIX
So that I can finish quickly

Acceptance Criteria:
- Given checkout complete, When I choose PIX, Then I receive a QR code and after confirmation the order is "Received".
MD

read -r -d '' AC_STATUS << 'MD'
As a Customer
I want to track my order status
So that I know the progress

Acceptance Criteria:
- Given an order in "Em preparo", When the admin sets "Saiu para entrega", Then I see the status update in real time.
MD

read -r -d '' AC_CARDAPIO << 'MD'
As an Admin
I want to manage the menu
So that I keep prices and flavors updated

Acceptance Criteria:
- Given admin panel, When I create/edit/delete a flavor/size, Then changes appear in the catalog.
MD

read -r -d '' AC_TAXA_ZONA << 'MD'
As an Admin
I want to define fee by delivery zone
So that I control costs

Acceptance Criteria:
- Given admin panel, When I set Z1=6 and Z2=12, Then checkout uses these fees.
MD

read -r -d '' AC_CUPONS << 'MD'
As an Admin
I want to create coupons with rules
So that I run promotions safely

Acceptance Criteria:
- Given admin panel, When I create coupon PIZZA10 with date limit and per-user cap, Then validation and audit work.
MD

read -r -d '' AC_CANCELA << 'MD'
As an Attendant
I want to cancel orders under rules
So that I handle exceptions

Acceptance Criteria:
- Given order paid, When cancellation is within 2 minutes, Then refund is automatic; after that, manual review is required.
MD

create_issue "[Story] Listar sabores" "$AC_LISTAR" "feature,area:catalog" 3
create_issue "[Story] Filtrar pizzas" "$AC_FILTRAR" "feature,area:catalog" 2
create_issue "[Story] Carrinho - adicionar/remover/extra" "$AC_CARRINHO" "feature,area:cart" 5
create_issue "[Story] Aplicar cupom" "$AC_CUPOM" "feature,area:checkout" 3
create_issue "[Story] Taxa/tempo por zona" "$AC_TAXA" "feature,area:checkout" 3
create_issue "[Story] Salvar endereço" "$AC_ENDERECO" "feature,area:checkout" 3
create_issue "[Story] Pagamento PIX" "$AC_PIX" "feature,area:checkout" 5
create_issue "[Story] Acompanhar status do pedido" "$AC_STATUS" "feature,area:orders" 5
create_issue "[Story] Admin - cardápio" "$AC_CARDAPIO" "feature,area:admin" 3
create_issue "[Story] Admin - taxa por zona" "$AC_TAXA_ZONA" "feature,area:admin" 2
create_issue "[Story] Admin - cupons" "$AC_CUPONS" "feature,area:admin" 3
create_issue "[Story] Cancelar pedido" "$AC_CANCELA" "feature,area:orders" 2

echo "Done. Created 12 issues in $REPO"
