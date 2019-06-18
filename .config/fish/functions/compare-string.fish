function compare-string
	diff (echo "$argv[1]" | psub) (echo "$argv[2]" | psub)
end
