function iknowjapan
	set backup (mktemp)
  cp config/database.yml $backup
  cp config/.database.yml.japan config/database.yml
  set -lx IKNOW_CONFIGURATION_FILE config/site_configuration/japan.yml
  eval "$argv"
  cp $backup config/database.yml
end
