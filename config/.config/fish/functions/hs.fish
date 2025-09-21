function hs
    if test (count $argv) -eq 0
        echo "Usage: hxrg <pattern>"
        return 1
    end

    set pattern $argv[1]

    # Search with ripgrep and select matches via fzf
    set matches (rg --line-number --color=never --smart-case $pattern | fzf --multi --ansi \
        --preview '
            set parts (string split ":" {1})
            set file $parts[1]
            set line $parts[2]

            if test -n "$line"
                set context 20
                set start (math "$line - $context")
                if test $start -lt 1
                    set start 1
                end
                set end (math "$line + $context")
                bat --style=numbers --color=always --highlight-line=$line --line-range=$start:$end "$file"
            end
        ')

    if test -z "$matches"
        return 0
    end

    # Build a list of file:line arguments
    set filelines
    for match in $matches
        set parts (string split ":" $match)
        set filelines $filelines "$parts[1]:$parts[2]"
    end

    # Open all matches in one Helix session with vertical splits
    hx --vsplit $filelines
end
