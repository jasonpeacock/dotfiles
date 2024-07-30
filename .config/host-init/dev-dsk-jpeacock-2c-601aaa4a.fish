# Load common Amazon settings.
source $HOME/.config/host-init/amazon.fish

# Host specific settings, do this second so we
# can override Amazon settings if needed.
set -gx HOST_NICKNAME "cloud"

set -gx BRAZIL_PLATFORM_OVERRIDE "AL2_x86_64"

# Fix Git/SSH interference from Nix (do we need to use the Nix
# flavor of SSH?).
#set -gx LD_PRELOAD /lib/x86_64-linux-gnu/libnss_sss.so.2
