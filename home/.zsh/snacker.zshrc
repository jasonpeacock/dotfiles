# vim:ft=sh

THIS_HOST=snacker

# add host-specific /bin
export PATH=$PATH:$HOME/.$THIS_HOST-bin

# Rust
export PATH=$PATH:$HOME/.cargo/bin

# Homebrew
export PATH=/usr/local/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

# Github description: Homebrew-snacker
export HOMEBREW_GITHUB_API_TOKEN=$(<$HOME/.certs/homebrew-snacker.github_api_token)

