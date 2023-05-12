feh --bg-fill --randomize ~/wallpapers/*

wall=$(cat ~/.fehbg | tail -n 1 | gawk '{print $4}' | gawk -F'/' '{print $5}')
wall=${wall::-1}

echo $wall
