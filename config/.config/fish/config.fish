set -x PAGER less -R

set -x LC_ALL en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8

abbr -a be bundle exec
abbr -a g git
abbr -a gf git ls-files --modified --others --exclude-standard
abbr -a h hx
abbr -a ddl cd $HOME/Downloads
abbr -a icl cd "$HOME/Library/Mobile\ Documents/com~apple~CloudDocs"
abbr -a src cd "$HOME/src"
abbr -a dot cd "$HOME/dotfiles"
abbr -a dc cd "$HOME/dotfiles/config/.config"
abbr -a ik cd "$HOME/Developer/iknow"
abbr -a ec cd "$HOME/Developer/eikaiwa_content"
abbr -a ecf cd "$HOME/Developer/eikaiwa_content_frontend"
abbr -a ecr cd "$HOME/Developer/eikaiwa-realtime"
abbr -a e cd "$HOME/Developer/Eikaiwa"
abbr -a nic cd "$HOME/nix-config/nixpkgs/.config/nixpkgs"
abbr -a l "eza -l --no-permissions --octal-permissions"
abbr -a ll "eza -l --no-permissions --octal-permissions"
abbr -a la "eza -a -l --no-permissions --octal-permissions"
abbr -a ea "eza -a"
abbr -a er "eza -R -L2"
abbr -a era "eza -R -a -L2"
abbr -a ela "eza -la --no-permissions --octal-permissions"
abbr -a elr "eza --no-permissions --octal-permissions -@ -a -l -R -L2 -I.git"
abbr -a c "bat -pp"
abbr -a b bat
abbr -a pc "git c Eikaiwa.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved"

# nix-provided binaries don't come first on macOS without this
if test (uname) = Darwin
    set PATH (path-reordered)
end

zoxide init fish --cmd a | source
starship init fish | source
