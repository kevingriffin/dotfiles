# Defined in /tmp/fish.fHpVHd/github-s3-backup.fish @ line 2
function github-s3-backup
	git clone --bare git@github.com:iknow/"$argv[1]".git
  tar czf "$argv[1]".git.tar.gz "$argv[1]".git
  aws s3 cp "$argv[1]".git.tar.gz s3://backups-cerego/github/ --profile=iknow-prod
  aws s3 ls backups-cerego/github/ --profile=iknow-prod | grep "$argv[1]"
end
