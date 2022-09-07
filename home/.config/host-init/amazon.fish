# Environment settings specific for Amazon.

fish_add_path $HOME/.toolbox/bin

set -gx APPEND_CR_URL 1 # auto-add CR links to git commits
set -gx BRAZIL_COLORS 1 # show colors in the output
set -gx BRAZIL_WORKSPACE_DEFAULT_LAYOUT short # Use short workspace layout in Brazil
set -gx MAKE_OUTPUT_LEVEL QUIET # reduce noise during builds

# Kuiper
set -gx AWS_PROFILE kuiper-readonly # Need to set a default for the Git CodeCommit helper
set -gx AWS_CONTAINER_CREDENTIALS_FULL_URI http://127.0.0.1:9911 # for Docker builds
set -gx DEV_ACCOUNT 594035389188 # for CDK builds

# Aliases
alias bb "SKIP_DOCUMENTATION=1 brazil-build"
alias bre brazil-runtime-exec
alias bbte brazil-build-tool-exec
alias ki '/usr/bin/kinit -f'
