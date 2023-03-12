function ^ --argument pattern
  set strings (string split '^' "$pattern")
  commandline -r (string replace "$strings[1]" "$strings[2]" "$history[1]") ; commandline -f repaint
end
