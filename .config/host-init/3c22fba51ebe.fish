# Load common Amazon settings.
source $HOME/.config/host-init/amazon.fish

# Host specific settings, do this second so we
# can override Amazon settings if needed.
set -gx HOST_NICKNAME "laptop"

set -gx BRAZIL_PLATFORM_OVERRIDE "AL2012"
