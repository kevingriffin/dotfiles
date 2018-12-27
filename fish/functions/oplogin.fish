function oplogin
	set -x -g OP_SESSION_my (op signin --output=raw)
end
