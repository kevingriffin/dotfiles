function rc
  if type -q bundle
    bundle exec pry -r ./config/environment
  else
    pry -r ./config/environment
  end
end
