#!/usr/bin/env python3
"""Validate the required structure and concise prose of an experiment report."""

import re
import sys
from pathlib import Path

SECTIONS = {
    "introduction": (3, 5),
    "background": (4, 8),
    "methodology": (2, 4),
    "results": (2, 4),
    "discussion": (3, 6),
    "conclusion": (1, 3),
}
HEADING = re.compile(r"^##\s+(?:\d+\.\s+)?(.+?)\s*$")
SENTENCES = re.compile(r"(?<=[.!?])\s+")


def words(value):
    return [word for word in value.split() if word]


def paragraphs(value):
    return [paragraph.strip() for paragraph in value.strip().split("\n\n") if paragraph.strip()]


def parse(text):
    title = next((line[2:].strip() for line in text.splitlines() if line.startswith("# ") and not line.startswith("## ")), None)
    sections, name, lines = {}, None, []
    for line in text.splitlines():
        match = HEADING.match(line)
        if match:
            if name is not None:
                sections[name] = "\n".join(lines).strip()
            name, lines = match.group(1).lower(), []
        elif name is not None:
            lines.append(line)
    if name is not None:
        sections[name] = "\n".join(lines).strip()
    return title, sections


def lint(text):
    errors = []
    title, sections = parse(text)
    if not title:
        errors.append("missing '# Title' heading")
    elif len(words(title)) >= 15:
        errors.append("title must contain fewer than 15 words")
    required = ["abstract", *SECTIONS]
    missing = [name for name in required if name not in sections]
    if missing:
        return errors + ["report missing required section(s): " + ", ".join(missing)]
    groups = paragraphs(sections["abstract"])
    if len(groups) != 1:
        errors.append(f"abstract: must be exactly one paragraph, found {len(groups)}")
    for name, (minimum, maximum) in SECTIONS.items():
        groups = paragraphs(sections[name])
        if not minimum <= len(groups) <= maximum:
            errors.append(f"{name}: expected {minimum}-{maximum} paragraphs, found {len(groups)}")
        for number, group in enumerate(groups, 1):
            sentences = [sentence for sentence in SENTENCES.split(group) if sentence]
            if not 3 <= len(sentences) <= 8:
                errors.append(f"{name} paragraph {number}: expected 3-8 sentences, found {len(sentences)}")
            for sentence_number, sentence in enumerate(sentences, 1):
                if len(words(sentence)) > 20:
                    errors.append(f"{name} paragraph {number} sentence {sentence_number}: exceeds 20 words")
    return errors


def main():
    if len(sys.argv) != 2:
        sys.exit("Usage: lint_report.py <report.md>")
    errors = lint(Path(sys.argv[1]).read_text(encoding="utf-8"))
    if errors:
        print("\n".join(errors))
        sys.exit(1)
    print("OK")


if __name__ == "__main__":
    main()
