#!/usr/bin/env bash
# Usage:
#   ./seed_issues.sh                 # auto-detect repo from current directory
#   ./seed_issues.sh owner/repo      # or pass explicitly
#
# Requires: GitHub CLI (gh) authenticated with permission to create issues.
# What it does:
# - Detects repo (or uses arg), ensures Issues are enabled
# - Ensures labels exist (feature + area:*)
# - Seeds 12 user stories with acceptance criteria
# - Prints created issue URLs
set -euo pipefail
trap 'echo -e "\033[1;31m[seed] Failed at line $LINENO\033[0m"' ERR

log() { echo -e "\033[1;34m[seed]\033[0m $*"; }

need_cmd() { command -v "$1" >/dev/null 2>&1 || { echo "Missing command: $1"; exit 1; }; }

need_cmd gh

log "Checking gh auth..."
if ! gh auth status >/dev/null 2>&1; then
  echo "You must be authenticated. Run: gh auth login"
  exit 1
fi

if [ $# -ge 1 ]; then
  REPO="$1"
else
  log "Auto-detecting repository..."
  REPO="$(gh repo view --json nameWithOwner -q .nameWithOwner 2>/dev/null || true)"
  if [ -z "${REPO:-}" ]; then
    echo "Could not detect repository. Run inside a cloned repo or pass owner/repo."
    exit 1
  fi
fi

log "Using repository: $REPO"
if ! gh repo view "$REPO" >/dev/null 2>&1; then
  echo "Repository not reachable. Check the slug and your permissions."
  exit 1
fi

# Ensure Issues are enabled
log "Checking if Issues are enabled..."
HAS_ISSUES="$(gh repo view "$REPO" --json hasIssuesEnabled -q .hasIssuesEnabled 2>/dev/null || echo false)"
if [ "$HAS_ISSUES" != "true" ]; then
  log "Enabling Issues on $REPO ..."
  OWNER="${REPO%/*}"
  NAME="${REPO#*/}"
  gh api -X PATCH "repos/$OWNER/$NAME" -f has_issues=true >/dev/null
fi

# Ensure labels exist
ensure_label () {
  local name="$1"; shift
  local color="$1"; shift
  local desc="$1"; shift
  local names
  names="$(gh label list -R "$REPO" --json name -q '.[].name' 2>/dev/null || true)"
  if echo "$names" | grep -Fxq "$name"; then
    log "Label exists: $name"
  else
    log "Creating label: $name"
    gh label create "$name" -R "$REPO" --color "$color" --description "$desc" >/dev/null || true
  fi
}

log "Ensuring labels exist..."
ensure_label "feature" "0E8A16" "Feature work"
ensure_label "area:catalog" "1D76DB" "Catalog related"
ensure_label "area:cart" "1D76DB" "Cart related"
ensure_label "area:checkout" "1D76DB" "Checkout related"
ensure_label "area:orders" "1D76DB" "Orders related"
ensure_label "area:admin" "1D76DB" "Admin related"

create_issue () {
  local title="$1"
  local body="$2"
  local labels_csv="${3:-feature}"
  local points="${4:-3}"
  # Parse comma-separated labels and build repeated -f labels[] flags
  IFS=',' read -r -a label_array <<< "$labels_csv"
  local label_flags=()
  for lbl in "${label_array[@]}"; do
    lbl="${lbl## }"; lbl="${lbl%% }"
    [ -z "$lbl" ] && continue
    label_flags+=( -f "labels[]=$lbl" )
  done
  # Append story points to the body
  local full_body
  full_body="$body"$'\n\n'"**Story Points:** $points"
  # Use gh api to create issue (works across gh versions) and output html_url
  local owner name
  owner="${REPO%/*}"
  name="${REPO#*/}"
  gh api -X POST \
    -H "Accept: application/vnd.github+json" \
    "/repos/${owner}/${name}/issues" \
    -f title="$title" \
    -f body="$full_body" \
    "${label_flags[@]}" \
    --jq .html_url
}

log "Seeding issues..."

AC_LISTAR="$(cat <<'MD'
As a Customer
I want to list pizza flavors
So that I can choose items for my order

Acceptance Criteria:
- Given I access the catalog, When the page loads, Then I see list of flavors with price and size.
- Given I search by ingredient, When I type "calabresa", Then I see matching pizzas.
MD
)"
AC_FILTRAR="$(cat <<'MD'
As a Customer
I want to filter pizzas by category/ingredient
So that I can quickly find what I want

Acceptance Criteria:
- Given the catalog, When I select "Vegetarian", Then only vegetarian pizzas are displayed.
MD
)"
AC_CARRINHO="$(cat <<'MD'
As a Customer
I want to add/remove items and extras to the cart
So that I can customize my order

Acceptance Criteria:
- Given the catalog, When I click "Add", Then the item appears in the cart with qty 1.
- Given a cart item, When I add stuffed crust, Then total increases by R$8.00.
MD
)"
AC_CUPOM="$(cat <<'MD'
As a Customer
I want to apply a coupon
So that I get a discount

Acceptance Criteria:
- Given a cart with items, When I enter PIZZA10, Then I see 10% off and coupon flagged as applied.
- Given an invalid coupon, When I apply, Then I see a clear error.
MD
)"
AC_TAXA="$(cat <<'MD'
As a Customer
I want to see fee/time by delivery zone
So that I can decide to proceed

Acceptance Criteria:
- Given my address, When the CEP is valid, Then I see zone Z1/Z2, fee and ETA.
MD
)"
AC_ENDERECO="$(cat <<'MD'
As a Customer
I want to save my address
So that next orders are faster

Acceptance Criteria:
- Given I enter a valid CEP/number, Then the address can be saved and reused.
MD
)"
AC_PIX="$(cat <<'MD'
As a Customer
I want to pay with PIX
So that I can finish quickly

Acceptance Criteria:
- Given checkout complete, When I choose PIX, Then I receive a QR code and after confirmation the order is "Received".
MD
)"
AC_STATUS="$(cat <<'MD'
As a Customer
I want to track my order status
So that I know the progress

Acceptance Criteria:
- Given an order in "Em preparo", When the admin sets "Saiu para entrega", Then I see the status update in real time.
MD
)"
AC_CARDAPIO="$(cat <<'MD'
As an Admin
I want to manage the menu
So that I keep prices and flavors updated

Acceptance Criteria:
- Given admin panel, When I create/edit/delete a flavor/size, Then changes appear in the catalog.
MD
)"
AC_TAXA_ZONA="$(cat <<'MD'
As an Admin
I want to define fee by delivery zone
So that I control costs

Acceptance Criteria:
- Given admin panel, When I set Z1=6 and Z2=12, Then checkout uses these fees.
MD
)"
AC_CUPONS="$(cat <<'MD'
As an Admin
I want to create coupons with rules
So that I run promotions safely

Acceptance Criteria:
- Given admin panel, When I create coupon PIZZA10 with date limit and per-user cap, Then validation and audit work.
MD
)"
AC_CANCELA="$(cat <<'MD'
As an Attendant
I want to cancel orders under rules
So that I handle exceptions

Acceptance Criteria:
- Given order paid, When cancellation is within 2 minutes, Then refund is automatic; after that, manual review is required.
MD
)"

urls=()
urls+=("$(create_issue "[Story] Listar sabores" "$AC_LISTAR" "feature,area:catalog" 3)")
urls+=("$(create_issue "[Story] Filtrar pizzas" "$AC_FILTRAR" "feature,area:catalog" 2)")
urls+=("$(create_issue "[Story] Carrinho - adicionar/remover/extra" "$AC_CARRINHO" "feature,area:cart" 5)")
urls+=("$(create_issue "[Story] Aplicar cupom" "$AC_CUPOM" "feature,area:checkout" 3)")
urls+=("$(create_issue "[Story] Taxa/tempo por zona" "$AC_TAXA" "feature,area:checkout" 3)")
urls+=("$(create_issue "[Story] Salvar endereço" "$AC_ENDERECO" "feature,area:checkout" 3)")
urls+=("$(create_issue "[Story] Pagamento PIX" "$AC_PIX" "feature,area:checkout" 5)")
urls+=("$(create_issue "[Story] Acompanhar status do pedido" "$AC_STATUS" "feature,area:orders" 5)")
urls+=("$(create_issue "[Story] Admin - cardápio" "$AC_CARDAPIO" "feature,area:admin" 3)")
urls+=("$(create_issue "[Story] Admin - taxa por zona" "$AC_TAXA_ZONA" "feature,area:admin" 2)")
urls+=("$(create_issue "[Story] Admin - cupons" "$AC_CUPONS" "feature,area:admin" 3)")
urls+=("$(create_issue "[Story] Cancelar pedido" "$AC_CANCELA" "feature,area:orders" 2)")

log "Created issues:"
for u in "${urls[@]}"; do echo " - $u"; done
log "Done."