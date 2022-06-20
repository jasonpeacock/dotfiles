# Environment settings specific for Amazon.

fish_add_path $HOME/.toolbox/bin

set -gx APPEND_CR_URL 1         # auto-add CR links to git commits
set -gx BRAZIL_COLORS 1         # show colors in the output
set -gx BRAZIL_WORKSPACE_DEFAULT_LAYOUT short # Use short workspace layout in Brazil
set -gx MAKE_OUTPUT_LEVEL QUIET # reduce noise during builds

# Aliases
alias bb "SKIP_DOCUMENTATION=1 brazil-build"
alias bre "brazil-runtime-exec"
alias bbte "brazil-build-tool-exec"
alias ki '/usr/bin/kinit -f'
