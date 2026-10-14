#!/usr/bin/env bash
# Framework self-check for contributors. Run from the repo root.
# Exit 1 on any finding. ASCII-only output.
set -u
fail=0
ex=(--exclude-dir=.git --exclude-dir=specs --exclude-dir=plans --exclude=dev-check.sh --exclude=.gitignore)

# 1. No private identifiers from the vault this framework was extracted from.
# Stored as truncated sha256 of lowercase words, so the list itself leaks nothing.
# Add one: printf %s word | sha256sum | cut -c1-16
blocked=" db42328112177c2d e3de5082f0c7a173 e8c70cc341df88a7 4abde5473f394da2 8b64d09d9a7290a3 452b889d10df8698 964e3ca93015246b ed62c6fd9f1b9900 243c7b40e12b92b6 5efc60b80fa21baa 1cd74f74444cc669 319ec3e742d3a048 16e6a477fce65e0d 57a4911c9baba00a 4183b9f5ed14b64d 9bfdd9814a9c080b b26d28f46ceba151 5f4e86bfd6cb6224 48a1a7f843610d7f 956a4b2dd564c19f e4ee06d13f52021b 03641a565d43cd63 0d05845a31cfa013 a49ac37435f29fb7 c6b438b0c071b087 3bb05d17f29c431d a539e046d4d483b2 a3d2e957eb7fa81f ab47633591bec8bb d2dd1938143b6cd8 2ff63fbcb16c2491 b4015024eac75080 2d23938081168f93 5d40ff87fd13d3de b0c5fbfcb887122f 97da5be440bba77d 4f278cdddf52263f 7a0af3307e85dbed a668c54233772c7f "
priv=$(git ls-files -z | grep -zv '^scripts/dev-check.sh$' | xargs -0 grep -IhoE '[A-Za-z0-9_]+' 2>/dev/null \
  | tr 'A-Z' 'a-z' | sort -u | while read -r w; do
      d=$(printf %s "$w" | sha256sum | cut -c1-16)
      case "$blocked" in *" $d "*) echo "$w";; esac
    done)
if [ -n "$priv" ]; then
  echo "[x] private identifiers found: $priv"; fail=1
fi

# 2. /workspace (as a path token) is Grok Bot specific: allowed only inside adapters/grok-bot.
if grep -rnE '(^|[[:space:]`"(])/workspace' "${ex[@]}" --exclude-dir=grok-bot . ; then
  echo "[x] /workspace outside adapters/grok-bot"; fail=1
fi

# 3. AGENTS.md exists and stays under the audit limit.
if [ -f AGENTS.md ]; then
  n=$(wc -l < AGENTS.md)
  if [ "$n" -gt 200 ]; then echo "[x] AGENTS.md has $n lines (limit 200)"; fail=1; fi
else
  echo "[x] AGENTS.md missing"; fail=1
fi

# 4. Blocks under 1200 characters (CR stripped, so CRLF checkouts count the same).
for b in agents/_blocks/*.md; do
  [ -f "$b" ] || continue
  c=$(tr -d '\r' < "$b" | wc -m)
  if [ "$c" -gt 1200 ]; then echo "[x] $b has $c chars (limit 1200)"; fail=1; fi
done

# 5. Only whitelisted placeholders in blocks, skills and adapters.
if [ -d agents ]; then
  bad=$(grep -rhoE '\{\{[^}]*\}\}' agents/_blocks agents/_skills adapters 2>/dev/null | sort -u \
    | grep -vE '^\{\{(owner|chief|vault_path|lang|assistant|librarian|compiler)\}\}$' || true)
  if [ -n "$bad" ]; then echo "[x] unknown placeholders: $bad"; fail=1; fi
fi

# 6. No em dashes in framework text.
if LC_ALL=C grep -rn $'\xe2\x80\x94' "${ex[@]}" . ; then
  echo "[x] em dash found"; fail=1
fi

if [ "$fail" -eq 0 ]; then echo "[ok] dev-check passed"; fi
exit "$fail"
