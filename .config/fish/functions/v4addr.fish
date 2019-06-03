# Defined in - @ line 0
function v4addr --description 'alias v4addr curl http://v4.ipv6-test.com/api/myip.php'
	curl http://v4.ipv6-test.com/api/myip.php $argv;
end
