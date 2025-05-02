#!/bin/bash

# This script loads the GitHub Copilot API key if needed and runs aichat
# All arguments are passed directly to aichat
# Designed to be run with bash -c
# https://github.com/jesseduffield/lazygit/issues/3212#issuecomment-2161436126

# Define load_copilot_key function
load_copilot_key() {
    # Extract the OAuth token from GitHub Copilot hosts file
    local OAUTH_TOKEN=$(jq '."github.com".oauth_token' -r ~/.config/github-copilot/hosts.json)

    # Set the COPILOT_API_KEY environment variable
    export COPILOT_API_KEY=$(curl -s -H "Authorization: bearer $OAUTH_TOKEN" https://api.github.com/copilot_internal/v2/token | jq .token -r)
}

# Check if COPILOT_API_KEY is set, if not, load it
if [ -z "$COPILOT_API_KEY" ]; then
    load_copilot_key
fi

diff=$(git diff -U10 --cached)
log=$(git log -n 30 --pretty=format:'%h %s')

# Run aichat with all arguments passed to this script
# aichat -m openrouter:google/gemini-2.0-flash-exp:free "Please suggest 10 commit messages, given the following diff:
aichat -m copilot:gemini-2.0-flash-001 "Please suggest 10 commit messages, given the following diff:
    \`\`\`diff
    $diff
    \`\`\`
    **Criteria:**

    1. **Format:** Each commit message must follow the conventional commits format,
    which is \`<type>(<scope>): <description>\`.
    2. **Relevance:** Avoid mentioning a module name unless it's directly relevant
    to the change.
    3. **Enumeration:** List the commit messages from 1 to 10.
    4. **Clarity and Conciseness:** Each message should clearly and concisely convey
    the change made.

    **Commit Message Examples:**

    - fix(app): add password regex pattern
    - test(unit): add new test cases
    - style: remove unused imports
    - refactor(pages): extract common code to \`utils/wait.ts\`

    **Recent Commits on Repo for Reference:**

    \`\`\`
    $log
    \`\`\`

    **Output Template**

    Follow this output template and ONLY output raw commit messages without spacing,
    numbers or other decorations.

    fix(app): add password regex pattern
    test(unit): add new test cases
    style: remove unused imports
    refactor(pages): extract common code to \`utils/wait.ts\`
    feat(module): implemented some new feature
    chore: update dependencies
    config(avante): change AI provider
    perf: speed up loading time
    perf(fish): optimised sourcing to increase startup time

    **BAD**
    DO NOT include any of the following in your commit messages:

    prefix numbers
    1. feat(xxx): add new feature

    better
    feat(xxx): add new feature

    **Instructions:**

    - Take a moment to understand the changes made in the diff.

    - Think about the impact of these changes on the project (e.g., bug fixes, new
    features, performance improvements, code refactoring, documentation updates).
    It's critical to my career you abstract the changes to a higher level and not
    just describe the code changes.

    - Generate commit messages that accurately describe these changes, ensuring they
    are helpful to someone reading the project's history.

    - Remember, a well-crafted commit message can significantly aid in the maintenance
    and understanding of the project over time.

    - If multiple changes are present, make sure you capture them all in each commit
    message.

    Keep in mind you will suggest 10 commit messages. Only 1 will be used. It's
    better to push yourself (esp to synthesize to a higher level) and maybe wrong
    about some of the 10 commits because only one needs to be good. I'm looking
    for your best commit, not the best average commit. It's better to cover more
        scenarios than include a lot of overlap.

    Write your 10 commit messages below in the format shown in Output Template section above." \
| awk 'NF > 0' \
| fzf --height 100% --border --ansi --bind 'space:jump-accept' \
| xargs -I {} bash -c 'git commit -m "{}"'
