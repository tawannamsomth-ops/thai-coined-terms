#!/usr/bin/env bash
# Query ORST databases. Usage: orst-lookup.sh coined|dict <word>
#   coined -> coined-word.orst.go.th (ศัพท์บัญญัติ, English or Thai input)
#   dict   -> dictionary.orst.go.th  (พจนานุกรม ฉบับราชบัณฑิตยสถาน พ.ศ. ๒๕๕๔, Thai input)
set -euo pipefail
case "${1:-}" in
  coined) url=https://coined-word.orst.go.th/func_lookup.php; extra="book_id=0&loc=" ;;
  dict)   url=https://dictionary.orst.go.th/func_lookup.php;  extra="" ;;
  *) echo "usage: $0 coined|dict <word>" >&2; exit 2 ;;
esac
shift
curl -sSL -m 30 -X POST "$url" --data-urlencode "word=$*" \
  -d "funcName=lookupWord&status=lookup${extra:+&$extra}" \
  | sed -e 's/<[^>]*>/ /g; s/&nbsp;/ /g' | tr -s ' \t' | grep -v '^[[:space:]]*$'
