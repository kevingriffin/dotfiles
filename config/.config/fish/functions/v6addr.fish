# Defined in - @ line 0
function v6addr --description 'alias v6addr curl "http://v6.ipv6-test.com/api/myip.php"'
	curl "http://v6.ipv6-test.com/api/myip.php" $argv;
end
