#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PI_AGENT_DIR="${PI_AGENT_DIR:-$HOME/.pi/agent}"
PI_MODEL="${PI_MODEL:-openai-codex/gpt-5.6-luna}"
case "$PI_MODEL" in
  */*) ;;
  *) PI_MODEL="openai-codex/$PI_MODEL" ;;
esac

command -v pi >/dev/null || { echo "pi not found" >&2; exit 1; }
command -v node >/dev/null || { echo "node not found" >&2; exit 1; }
mkdir -p "$PI_AGENT_DIR"

configure_settings() {
  local settings="$PI_AGENT_DIR/settings.json" tmp
  [ -f "$settings" ] || printf '{}\n' > "$settings"
  tmp="$(mktemp "$PI_AGENT_DIR/settings.json.XXXXXX")"
  node - "$settings" "$tmp" <<'NODE'
const fs = require('fs');
const [input, output] = process.argv.slice(2);
const settings = JSON.parse(fs.readFileSync(input, 'utf8'));
settings.tuiMode = 'regular';
settings.fullscreenScrollbar = 'auto';
if (!settings.terminal || typeof settings.terminal !== 'object' || Array.isArray(settings.terminal)) settings.terminal = {};
settings.terminal.trueColor = true;
fs.writeFileSync(output, JSON.stringify(settings, null, 2) + '\n');
NODE
  mv "$tmp" "$settings"
}

configure_context_window() {
  local model_ref="$1" models tmp provider model
  case "$model_ref" in
    */*) provider="${model_ref%%/*}"; model="${model_ref#*/}" ;;
    *) echo "Invalid Pi model reference: $model_ref" >&2; return 2 ;;
  esac
  models="$PI_AGENT_DIR/models.json"
  [ -f "$models" ] || printf '{}\n' > "$models"
  tmp="$(mktemp "$PI_AGENT_DIR/models.json.XXXXXX")"
  node - "$models" "$tmp" "$provider" "$model" <<'NODE'
const fs = require('fs');
const [input, output, providerName, modelId] = process.argv.slice(2);
const models = JSON.parse(fs.readFileSync(input, 'utf8'));
if (!models.providers || typeof models.providers !== 'object' || Array.isArray(models.providers)) models.providers = {};
const provider = models.providers[providerName] ||= {};
if (!provider.modelOverrides || typeof provider.modelOverrides !== 'object' || Array.isArray(provider.modelOverrides)) provider.modelOverrides = {};
provider.modelOverrides[modelId] = {...(provider.modelOverrides[modelId] || {}), contextWindow: 1000000};
fs.writeFileSync(output, JSON.stringify(models, null, 2) + '\n');
NODE
  mv "$tmp" "$models"
}

configure_settings
for model in \
  "$PI_MODEL" \
  openai-codex/gpt-5.6-sol \
  openai-codex/gpt-5.6-terra \
  openai-codex/gpt-5.6-luna \
  openai-codex/gpt-6-astra
do
  configure_context_window "$model"
done
cp "$REPO_DIR/config/open-tui.json" "$PI_AGENT_DIR/open-tui.json"

packages=(
  "npm:pi-open-tui"
  "npm:@narumitw/pi-usage"
  "npm:@juicesharp/rpiv-todo"
  "npm:pi-must-have-extension"
  "npm:pi-vimmode"
  "npm:@juicesharp/rpiv-ask-user-question"
  "npm:pi-notify"
)
for package in "${packages[@]}"; do
  pi install "$package"
done

echo "Pi advisor runtime installed: $PI_MODEL"
echo "Run ./bin/install-pi-subagent separately to install advisor subagents."
