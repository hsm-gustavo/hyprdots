clock=$(date +%Y-%m-%d-%I-%M-%S)

dir="$(xdg-user-dir PICTURES)/Screenshots"
file="Screenshot_${clock}.png"

[ ! -d "$dir" ] && mkdir -p "$dir"

notify_user() {
	notify-send \
		-a Clipboard \
		-i "$icon_path/$colorscheme/clipboard.svg" \
		-u low \
		-r 699 "Clipboard" "Screenshot saved on clipboard"

	xdg-open "$dir/$file"

	if [ -e "$dir/$file" ]; then
		notify-send -a Screenshot -u low -i "$dir/$file" "Screenshot Saved"
	else
		notify-send -a Screenshot -u low "Screenshot Deleted"
	fi
}

screen () {
	cd "$dir" || exit
	grim "$file"
	wl-copy < "$file"
	notify_user
}

area() {
	cd "$dir" || exit
	grim -g "$(slurp)" "$file"
	wl-copy < "$file"
	notify_user
}

selected(){
	cd "$dir" || exit
	window="$(hyprctl clients -j | jq -r ".[] | select(.workspace.id | IN($(hyprctl -j monitors | jq 'map(.activeWorkspace.id) | join(",")' | tr -d \")))" | jq -r ".at,.size" | jq -s "add" | jq '_nwise(4)' | jq -r '"\(.[0]),\(.[1]) \(.[2])x\(.[3])"'| slurp)"
	grim -g "$window" "$file"
	wl-copy < "$file"
	notify_user
}

menu() {
	selection="$(printf "󰄀  Screen\n󰹑  Area\n  Window" | fuzzel --dmenu -w 7 -l 3 "Screenshot: ")"
	case $selection in
		*"Screen")
			sleep 0.5
			screen
			;;
		*"Area")
			sleep 0.5
			area
			;;
		*"Window")
			sleep 0.5
			selected
			;;
	esac
}

docs() {
	echo "
Usage: screenshot [option]
  --help	-	Prints this message
Options:
  --screen|-s	-	Takes a screenshot of the screen
  --area|-a	-	Takes a screenshot of the selected area
  --window|-w	-	Takes a screenshot of the selected window
	"
}

case $1 in
--screen | -s)
	screen
	;;
--area | -a)
	area
	;;
--menu | -m)
	menu
	;;
--window | -w)
	selected
	;;
--help | *)
	docs
	;;
esac
