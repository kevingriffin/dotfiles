# Defined in /var/folders/61/007mjl_j1qj7bk_zn1j0gj4c0000gn/T//fish.bYkW62/delta-string.fish @ line 2
function delta-string
	delta --word-diff-regex="." (echo "$argv[1]" | psub) (echo "$argv[2]"| psub)
end
