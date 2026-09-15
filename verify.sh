#!/bin/bash
# Verifies index.html + style.css against the CLAUDE.md constraints. Exit 1 on any failure.
set -u
cd "$(dirname "$0")"
fail=0; ok(){ printf '  ok    %s\n' "$1"; }; bad(){ printf '  FAIL  %s\n' "$1"; fail=1; }

echo "verify.sh — $(date -u +%Y-%m-%dT%H:%M:%SZ)"

# 1. required files
for f in index.html style.css .nojekyll CLAUDE.md content_brief.md headshot.webp headshot.jpg; do
  [ -f "$f" ] && ok "exists: $f" || bad "missing: $f"
done

# 2. constraints: no JS, no webfonts, no inline styles, relative stylesheet
grep -qiE '<script(?! type="application/ld\+json")' index.html 2>/dev/null && bad "script tag present" || true
if grep -iE '<script' index.html | grep -viq 'application/ld+json'; then bad "non-JSON-LD <script> found"; else ok "no JavaScript (only JSON-LD)"; fi
grep -qiE 'fonts\.googleapis|fonts\.gstatic|@font-face|@import' index.html style.css && bad "webfont/import found" || ok "no webfont downloads"
grep -qiE 'style="' index.html && bad "inline style= attribute found" || ok "no inline styles"
grep -q 'href="style.css"' index.html && ok "stylesheet linked relatively" || bad "stylesheet link must be href=\"style.css\""
grep -qiE 'https?://[^"]*\.(js)"' index.html && bad "external script URL" || ok "no external script URLs"

# 3. placeholders
if grep -nE 'TODO|FIXME|lorem|Lorem|\[NEEDS INPUT|\{\{|xxx' index.html style.css; then bad "placeholder text found"; else ok "no placeholder strings"; fi

# 4. headings: exactly one h1, order never skips a level
h1=$(grep -o '<h1' index.html | wc -l | tr -d ' '); [ "$h1" = "1" ] && ok "exactly one h1" || bad "h1 count = $h1"
prev=0; order_ok=1
while read -r lvl; do
  if [ "$lvl" -gt $((prev+1)) ] && [ "$prev" -ne 0 ]; then order_ok=0; fi; prev=$lvl
done < <(grep -oE '<h[1-6]' index.html | tr -dc '0-9\n')
[ "$order_ok" = 1 ] && ok "heading order never skips a level" || bad "heading order skips a level"

# 5. images: every <img> has alt, every local asset exists
while read -r src; do [ -f "$src" ] && ok "asset exists: $src" || bad "asset missing: $src"; done < <(grep -oE '(src|srcset)="[^"h][^"]*"' index.html | sed -E 's/^[a-z]+="//; s/"$//')
imgs=$(grep -o '<img' index.html | wc -l | tr -d ' '); alts=$(grep -oE '<img[^>]*alt="[^"]+"' index.html | wc -l | tr -d ' ')
[ "$imgs" = "$alts" ] && ok "all $imgs <img> have alt text" || bad "img=$imgs alt=$alts"

# 6. internal anchors resolve
while read -r id; do grep -q "id=\"$id\"" index.html && ok "anchor #$id resolves" || bad "anchor #$id has no target"; done < <(grep -oE 'href="#[^"]+"' index.html | sed 's/href="#//; s/"//' | sort -u)

# 7. head/meta
t=$(sed -n 's/.*<title>\(.*\)<\/title>.*/\1/p' index.html | sed 's/&amp;/\&/g'); [ ${#t} -le 60 ] && ok "title ${#t} chars (≤60)" || bad "title ${#t} chars (>60)"
d=$(grep -o 'name="description" content="[^"]*"' index.html | sed 's/.*content="//; s/"$//'); [ ${#d} -ge 120 ] && [ ${#d} -le 160 ] && ok "meta description ${#d} chars (120–160)" || bad "meta description ${#d} chars"
grep -q 'rel="canonical"' index.html && ok "canonical link" || bad "no canonical link"
for p in og:type og:title og:description og:url og:image; do grep -q "property=\"$p\"" index.html && ok "meta $p" || bad "missing $p"; done
sed -n '/application\/ld+json/,/<\/script>/p' index.html | sed '1d;$d' | jq -e '.["@type"]=="Person" and .name and .url' >/dev/null 2>&1 && ok "JSON-LD Person parses" || bad "JSON-LD invalid"

# 8. page weight
total=0; for f in index.html style.css headshot.webp; do s=$(wc -c < "$f"); total=$((total+s)); done
[ "$total" -lt 512000 ] && ok "page weight ${total} bytes (<500 KB)" || bad "page weight ${total} bytes"

# 9. serve and fetch
python3 -m http.server 8765 --bind 127.0.0.1 >/dev/null 2>&1 & pid=$!; sleep 1
for path in / /style.css /headshot.webp /headshot.jpg; do
  code=$(curl -s -o /tmp/verify_body -w '%{http_code}' "http://127.0.0.1:8765$path"); size=$(wc -c < /tmp/verify_body)
  [ "$code" = "200" ] && [ "$size" -gt 0 ] && ok "GET $path → 200, ${size} bytes" || bad "GET $path → $code, ${size} bytes"
done
kill $pid 2>/dev/null; wait $pid 2>/dev/null

# 10. html5 validity (if available)
if command -v tidy >/dev/null && tidy --version 2>/dev/null | grep -qE 'version 5'; then
  tidy -q -e index.html 2>&1 | grep -E 'Error' && bad "tidy errors" || ok "tidy (HTML5): no errors"
else
  python3 -c "import html.parser,sys; p=html.parser.HTMLParser(); p.feed(open('index.html').read()); p.close()" && ok "html.parser: parses (install tidy-html5 for full validation)" || bad "html.parser failed"
fi

[ $fail = 0 ] && echo "ALL CHECKS PASSED" || { echo "FAILURES PRESENT"; exit 1; }
