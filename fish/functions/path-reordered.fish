function path-reordered --description 'Echos the elements of /Users/kevin/.nix-profile/bin:/Users/kevin/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Applications/VMware Fusion.app/Contents/Public:/run/current-system/sw/bin:/nix/var/nix/profiles/default/bin, reordered such that custom paths precede standard system paths. This can be used to work around a fish 3.0.0 bug in which sub-shells fail to respect path ordering.'
	set -l sys_paths

  for p in $PATH
      if string match -q -r '^(/usr/|^/s?bin(/|$))|(Applications.*/)' $p
          set -a sys_paths $p
      else
          echo $p
      end
  end

  for p in $sys_paths; echo $p; end
end
