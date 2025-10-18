---
type: "manual"
description: "initcc"
---

# CLAUDE.md Generation Specification

## Purpose
Define how to generate a concise `CLAUDE.md` file that serves as persistent project memory for Claude Code.  
This file helps Claude automatically understand the repository context in every session.

## Principles
- **Lean Memory**: Only capture essential project context (avoid unnecessary prose).  
- **Persistent Context**: Claude automatically loads this file in each conversation.  
- **Editable**: Developers can freely update or prune content as repo evolves.  
- **Human + AI Friendly**: Written for both maintainers and Claude agent.  

## Recommended Sections
1. **Overview** – Short description of the project, main purpose, technologies used.  
2. **Architecture** – High-level structure: key directories, modules, interactions.  
3. **Commands** – Setup, build, run, and test commands (minimal, reproducible).  
4. **Conventions** – Coding standards, naming rules, contribution guidelines.  
5. **Dependencies** – Core libraries, frameworks, services.  
6. **Notes / Memory** – Design decisions, caveats, or critical knowledge not obvious from code.  

## Workflow
1. **Scan Repository**  
   - Identify language, frameworks, dependencies.  
   - Map directory structure, key files, and scripts.  
   - Extract setup/build/test commands.  

2. **Draft CLAUDE.md**  
   - Populate each recommended section with concise bullet points or code blocks.  
   - Keep content short but informative (Claude context window friendly).  

3. **Refine**  
   - Remove duplication with README or docs.  
   - Verify reproducibility from clean environment.  
   - Ensure clarity and simplicity.  

4. **Finalize**  
   - Save `CLAUDE.md` at repo root.  
   - Update whenever repo structure, workflows, or dependencies change.  

## Output Format
The generated `CLAUDE.md` must follow this structure:

```markdown
# Project Overview
<text>

# Architecture
<key modules and interactions>

# Commands
<setup / build / test commands>

# Conventions
<coding rules, style guides>

# Dependencies
<main frameworks, libraries>

# Notes / Memory
<extra context, design decisions>
