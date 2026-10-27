---
name: thai-coined-terms
description: ศัพท์บัญญัติ and ทับศัพท์ per สำนักงานราชบัณฑิตยสภา (ORST, Royal Society of Thailand). Use when translating an English technical term into Thai, choosing between a coined Thai term and a transliteration, checking the official Thai spelling of a loanword or proper name, or reviewing Thai text for ORST conformance.
---

# Thai coined terms (ORST)

ORST is the authority. Your memory of Thai terms is a guess until the live database confirms it; popular coinages attributed to ORST (ละมุนภัณฑ์, กระด้างภัณฑ์, แท่งหรรษา) are fakes ORST has publicly rejected.

Pair with the `thai-natural` skill when writing full Thai prose: this skill picks the term, `thai-natural` writes the sentence around it.

## Steps

1. **Look up every term live.** Run the bundled script once per term (English or Thai input both work):

   ```bash
   ~/.claude/skills/thai-coined-terms/scripts/orst-lookup.sh coined "machine learning"
   ~/.claude/skills/thai-coined-terms/scripts/orst-lookup.sh dict "เกม"
   ```

   `coined` queries the ศัพท์บัญญัติ database (coined-word.orst.go.th). `dict` queries พจนานุกรม ฉบับราชบัณฑิตยสถาน พ.ศ. ๒๕๕๔ (dictionary.orst.go.th) for ordinary spelling. On `ไม่พบคำศัพท์`, retry with variants (hyphen/space, singular, British spelling, the head noun alone) before concluding. Done when each term has a result or a recorded not-found after variants.

2. **Read the entry by domain and sense.** Results are grouped by subject (คอมพิวเตอร์และเทคโนโลยีสารสนเทศ, นิติศาสตร์, …). Pick the domain matching the user's text, never the first row. Numbered senses (๑. ๒.) are different meanings. A comma lists accepted alternatives, usually coined form then transliteration (`ส่วนชุดคำสั่ง, ซอฟต์แวร์`); both are correct. A leading hyphen (`-ดิจิทัล`) marks a form used inside compounds.

3. **Choose the form.** When both coined and transliterated forms are listed, either is correct. Default to the one that fits the register: transliteration for everyday IT writing (ซอฟต์แวร์, คอมพิวเตอร์), the coined form for formal or government text when it is in real use. Mention the alternative once.

4. **Fall back when not found.** No entry means ORST has not coined a term in that database. Then:
   - Check `dict` for an established loanword spelling (established dictionary forms override productive rules).
   - Otherwise transliterate per [references/transliteration.md](references/transliteration.md), or point the user to https://transliteration.orst.go.th/ (15 languages; JS app, not scriptable).
   - Never invent a coined Thai term and present it as ORST's.

5. **Report with a verification level.** For each term give: Thai form(s), domain used, and one of
   - `ORST coined-word DB` / `ORST dictionary 2554` — found live today
   - `ORST rule` — derived from transliteration rules, no entry exists
   - `unverified` — script failed or nothing official found; say so plainly

## Reference

- Live-checked snapshot of common terms, plus known spelling errors and false-positive traps: [references/terms.md](references/terms.md). Use it to sanity-check, not to replace step 1.
- Transliteration rules, worked examples, and source documents: [references/transliteration.md](references/transliteration.md).
- No public API or bulk dataset is documented; the script calls the same endpoint the website's search form uses. If it breaks, the site changed: open https://coined-word.orst.go.th/ in a browser and inspect the form.
- No retrieved instrument obliges every government document to use coined terms over transliterations. Do not claim one exists.
- Name history: ราชบัณฑิตยสถาน became สำนักงานราชบัณฑิตยสภา, and สภาราชบัณฑิต became ราชบัณฑิตยสภา, effective 14 Feb 2015 (พ.ร.บ.ราชบัณฑิตยสภา พ.ศ. ๒๕๕๘). The 2554 dictionary keeps its old name.
