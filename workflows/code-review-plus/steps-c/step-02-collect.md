---
name: 'step-02-collect'
description: 'Collect the list of files to review based on the selected review source'

nextStepFile: '~/.claude/workflows/code-review-plus/steps-c/step-03-review.md'
---

# Step 2: Collect Files to Review

## STEP GOAL:

Collect the list of files to review based on the review source selected in step-01 (story, git diff, or manual).

## MANDATORY EXECUTION RULES (READ FIRST):

### Universal Rules:

- CRITICAL: Read the complete step file before taking any action
- YOU MUST ALWAYS SPEAK OUTPUT in {communication_language}

### Role Reinforcement:

- You are a code review agent collecting the review target file list
- Checklist is already loaded from step-01 — it remains ACTIVE and BINDING
- You collect files only — no review happens in this step

### Step-Specific Rules:

- Focus ONLY on collecting the file list based on the selected source
- FORBIDDEN to start reviewing files in this step
- FORBIDDEN to proceed with an empty file list
- This is an auto-proceed step after file collection

## MANDATORY SEQUENCE

**CRITICAL:** Follow this sequence exactly. Do not skip, reorder, or improvise.

### 1. Collect Files Based on Source

**IF review_source == "story":**
- Read the story file completely (path stored from step-01)
- Extract file paths from the File List section of the story
- These are the files to review
- Note: story_file path is retained for potential status updates

**IF review_source == "diff":**
- Ask user for the diff range (e.g., branch name, commit range)
- Default suggestion: `git diff --name-only HEAD~1` or `git diff --name-only main...HEAD`
- Run the git diff command to collect all changed file paths
- Filter out deleted files (they cannot be reviewed)

**IF review_source == "manual":**
- Ask user to provide the file paths to review
- Accept comma-separated list, space-separated, or one path per line
- HALT and wait for user input before proceeding

### 2. Validate File List

- Verify at least 1 file exists in the collected list
- Remove duplicates if any
- Verify each file path is accessible (use Glob or Read to confirm existence)

**If no files found or all files invalid:**

HALT — "review file. review file path."

### 3. Communicate and Auto-Proceed

"**review target file {{file_count}} collect complete**

{{file_list_numbered}}

**parallel review start...**"

#### Menu Handling Logic:

- After file list is validated, immediately load, read entire file, then execute {nextStepFile}

#### EXECUTION RULES:

- This is an auto-proceed step after file collection completes
- For "manual" source: wait for user input, then auto-proceed
- For "story" and "diff" sources: auto-proceed immediately after collection
- HALT only if no valid files are found

## CRITICAL STEP COMPLETION NOTE

ONLY WHEN at least 1 valid file is collected will you proceed to step-03-review.

---

## SYSTEM SUCCESS/FAILURE METRICS

### SUCCESS:

- File list collected based on selected review source
- At least 1 valid file confirmed
- File list communicated to user
- Auto-proceeded to step-03

### FAILURE:

- Proceeding with an empty file list
- Starting file review in this step
- Not validating file existence
- Skipping user input for manual source

**Master Rule:** Must have files to review before proceeding. An empty file list is SYSTEM FAILURE.
