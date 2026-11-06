#!/usr/bin/env bash
# claude-seats: one command for the whole setup (tmux, bun, node, Claude Code, the room server, the `seats` command,
# the tmux config). Safe to run twice: everything checks before it installs, nothing you have is overwritten.
set -euo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
MULTIPLAYER_REPO="${MULTIPLAYER_REPO:-https://github.com/mattypark/claude-multiplayer.git}"
MULTIPLAYER_DIR="${MULTIPLAYER_DIR:-$HOME/claude-multiplayer}"
BIN_DIR="${BIN_DIR:-$HOME/.local/bin}"

say() { printf '\033[1m%s\033[0m\n' "$*"; }
have() { command -v "$1" >/dev/null 2>&1; }

if [[ "$(uname)" != "Darwin" ]]; then
  echo "This script is for macOS. On Linux: install tmux, bun, node, Claude Code, then run the steps in README.md by hand."
  exit 1
fi

say "1/6 Homebrew"
if ! have brew; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"
fi

say "2/6 tmux, bun, node"
for pkg in tmux bun node; do
  if have "$pkg"; then echo "  $pkg: already here"; else brew install "$pkg"; fi
done

say "3/6 Claude Code"
if have claude; then
  echo "  claude: $(claude --version 2>/dev/null | head -1)"
else
  npm install -g @anthropic-ai/claude-code
fi

say "4/6 the room server (claude-multiplayer)"
if [[ -d "$MULTIPLAYER_DIR/.git" ]]; then
  echo "  $MULTIPLAYER_DIR: already cloned"
else
  git clone "$MULTIPLAYER_REPO" "$MULTIPLAYER_DIR"
fi
(cd "$MULTIPLAYER_DIR" && bun install >/dev/null)
if claude mcp list 2>/dev/null | grep -q '^claude-multiplayer'; then
  echo "  MCP server: already registered"
else
  claude mcp add --scope user --transport stdio claude-multiplayer -- bun "$MULTIPLAYER_DIR/server.ts"
fi

say "5/6 the seats command"
mkdir -p "$BIN_DIR"
ln -sfn "$HERE/bin/seats" "$BIN_DIR/seats"
chmod +x "$HERE/bin/seats" "$HERE/scripts/"*.sh
case ":$PATH:" in
  *":$BIN_DIR:"*) ;;
  *) echo "  add this to your shell profile: export PATH=\"$BIN_DIR:\$PATH\"" ;;
esac

say "6/6 tmux config"
if [[ -f "$HOME/.tmux.conf" ]]; then
  echo "  you already have ~/.tmux.conf; the one here is tmux/claude.tmux.conf if you want pieces of it"
else
  cp "$HERE/tmux/claude.tmux.conf" "$HOME/.tmux.conf"
  echo "  installed ~/.tmux.conf (prefix ⌥j, mouse on, 50k scrollback)"
fi

cat <<EOF

Done. Next:
  1. Dictation: install Wispr Flow (wisprflow.ai) or any dictation app.
  2. In your project:   seats up .
  3. In one seat, paste prompts/00-yap-to-six.md followed by your transcript.

Claude Code needs to be signed in once (run \`claude\` by itself the first time).
EOF
