function td --argument path
  mkdir -p (dirname $path) && touch $path
end
