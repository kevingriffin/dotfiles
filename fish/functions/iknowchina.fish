function iknowchina
	set backup (mktemp)
  cp config/database.yml $backup
  cp config/.database.yml.china config/database.yml
  set -lx IKNOW_CONFIGURATION_FILE config/site_configuration/china.yml
  eval "$argv"
  cp $backup config/database.yml
end
