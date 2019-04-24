function __ssh_agent_start -d "start a new ssh agent"

  if not test -z $PKCS11_WHITELIST
    set __ssh_agent_invokation "ssh-agent -c -P '$PKCS11_WHITELIST'"
  else
    set __ssh_agent_invokation "ssh-agent -c"
  end

  eval $__ssh_agent_invokation | sed 's/^echo/#echo/' > $SSH_ENV
  chmod 600 $SSH_ENV
  source $SSH_ENV > /dev/null
end
