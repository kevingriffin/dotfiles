# Defined in /var/folders/x6/hkd3nz01715gfp9c56vbhhrc0000gn/T//fish.MSsN23/cloudflarekey.fish @ line 2
function cloudflarekey
	op get item "Cloudflare" | jq '.details.sections[] | select(.title == "API Keys").fields[] | select(.t == "Global").v' | sed 's/"//g'
end
