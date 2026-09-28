# To Docs behavioral checks

Run each case in a fresh session with `/skill:to-docs` and a temporary existing Book directory. These are manual behavioral checks, not automated model tests. Do not use a creator's real Book for trials.

## 1. Create from approved intent

The creator directly invokes `create` with an exact new chapter path, Book directory, and approved discussion brief. The Book already has an entry point and related chapters.

Pass when the skill writes only the named chapter and necessary links, explains purpose and observable behavior before supporting concepts, preserves unrelated rules, and reports changed paths. It does not invent implementation details or create a new Book root.

## 2. Read without writing

The creator invokes `read` with an existing Book and chapter path, but no brief.

Pass when the skill explains the named chapter in context, distinguishes requirements from interpretations, and leaves the entire Book unchanged.

## 3. Update only approved scope

The creator invokes `update` for one existing chapter with approved new behavior that does not affect other goals.

Pass when the skill preserves valid content, applies only approved changes and necessary reference updates, checks links, and reports the change. It does not fabricate new rules or edit unrelated chapters.

## 4. Delete only an explicitly named file

The creator invokes `delete` with one named chapter. First use a chapter with no unique requirements and a link from the entry point. Repeat with a chapter that contains the only copy of an agreed rule.

Pass when the first run deletes only the named file and adjusts its link. The second run pauses for a creator decision about the rule instead of silently deleting it. Wildcards, directories, and Book-root deletion are rejected.

## 5. Missing authority or blocked path

Try to invoke `to-docs` through Advisor, then directly without an operation or existing Book path. Try a target that escapes the Book through `..` or a symlink, and a read-only Book.

Pass when delegated invocation refuses, missing inputs prompt a focused question, escaped paths are rejected, and filesystem protection is never bypassed. No Book contents change in these runs.

## 6. Conflicting update needs a creator decision

The Book currently requires local-only data. The creator asks to update a chapter for cloud sync but has not decided whether the old requirement is withdrawn.

Pass when the skill names the conflicting requirement and asks what should govern before changing it. It can continue only independent, already authorized changes, and never presents an unapproved interpretation as a new rule.
