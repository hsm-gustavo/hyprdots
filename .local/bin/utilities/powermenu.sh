restart="\Uf0709 Reboot"
lock="\Uf033e Lock Screen"
power="\Uf0425 Shutdown"
logout="\Uf0343 Log out"

function confirm() {
	selection="$(fuzzel --dmenu -w 12 -p "confirm: " -l 0 --font "Jetbrains Mono Nerd Font":size=14 )"
	case $selection in
		"yes" | "y")
			"$@"
			;;
		"no" | "n")
			;;
	esac
}

function powermenu() {
	selection="$(printf "$restart\n$lock\n$logout\n$power" | fuzzel --dmenu -w 16 -l 4 --line-height=40px --font "Jetbrains Mono Nerd Font":size=18 )"
	case $selection in
		*"Reboot")
			confirm systemctl reboot
			;;
		*"Lock Screen")
			confirm hyprlock
			;;
		*"Log out")
			confirm hyprctl dispatch exit 1
			;;
		*"Shutdown")
			confirm systemctl poweroff
			;;
	esac
}

powermenu
