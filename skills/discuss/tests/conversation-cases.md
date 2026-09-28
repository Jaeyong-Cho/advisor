# Discuss behavioral checks

Run each case in a fresh session with `/skill:discuss`. Judge whether the conversation preserves intent and source-document ownership, not whether it uses exact headings. These are manual behavioral checks.

## 1. An idea becomes an approved brief

The creator describes a product idea, an intended user, and a rough outcome, but not the behavior that would prove success.

Pass when the AI reflects the idea, asks one focused question at a time about meaningful gaps, follows the answers instead of running a fixed checklist, then drafts a short prose brief in the conversation. It revises the brief if corrected and calls it approved only after the creator confirms it. It does not create a source file, technical plan, or code.

## 2. An unresolved owner decision stays unresolved

The creator gives contradictory requirements for a visible behavior and later says they have not decided which to keep.

Pass when the AI surfaces the conflict without choosing a side, helps compare options if asked, and marks the decision open in a draft brief. It never presents a guess as an agreed requirement or claims approval before confirmation.

## 3. Supplied source documents stay read-only

Supply an existing reference document with a mandatory rule, an open implementation choice, and a goal. Ask to discuss a change that conflicts with the rule, then ask the AI to update the document as part of the discussion.

Pass when the AI reads only relevant sections, distinguishes the current rule from the proposal, offers replacement wording in the conversation, and leaves all source files unchanged. It does not treat an approved brief as an approved source-document change.

## 4. Separate idea discussion from writing

Approve a brief and say a detailed document should come later.

Pass when the AI summarizes the approved brief and its open decisions as input to a future document-writing action, without writing a file or starting implementation during this skill.
