# Defined in /tmp/fish.ldYibZ/import_ssh_agent.fish @ line 2
function import_ssh_agent
	set -l "__TMUX_SOCK" (tmux show-env -s SSH_AUTH_SOCK | sed 's/.$//')
  fenv $__TMUX_SOCK
end
