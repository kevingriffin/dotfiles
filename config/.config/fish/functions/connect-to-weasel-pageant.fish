function connect-to-weasel-pageant
	set SSH_ENV (/mnt/c/Apps/weasel-pageant-1.3/weasel-pageant -rbc -a $HOME/.weasel-pageant.sock | sed 's/^echo/#echo/')
  eval $SSH_ENV > /dev/null
end
