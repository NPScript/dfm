#!/bin/sh

# Uncomment this if you don't have 'add' or 'dfm_screen' installed
# screen="$(pwd)/dfm_screen"
# add="$(pwd)/add"
screen="dfm_screen"
add="add"

old_stty=$(stty -g)

tput civis
stty -echo

run_command() {
	tput cnorm
	stty sane
	clear

	printf "execute> "
	read message
	$message
	read message

	tput civis
}

setvariables() {
	if [ "$(pwd)" = "/" ]; then
		# Display something beautiful if your current path is '/'
		parent=$(df -h | grep /$ | awk '{ print $1 ":\n  used:  " $5 " (" $3 ")\n  size:  " $2 }')
	else
		parent=$(ls -w 1 ..)
	fi

	current=$(ls -w 1 .)
	sel=$(echo "$current" | sed "${nsel}q;d")

	if [ $nsel -ge $(tput lines) ]; then
		current=$(echo "$current" | sed "1,$($add ${nsel} -$(tput lines) 1)d")
	fi

	if [ -d "$sel" ]; then
		child=$(ls -w 1 "$sel")
	else
		# Configure your file preview here
		case "$(file $sel)" in
			(*"text"*) child=$(cat "$sel" | head -n $(tput lines));;
			(*) child=$(file "$sel");
		esac
	fi
	current=$(echo "$current" | sed "s/^$(echo $sel | sed 's/\[/\\[/g')$/[ & ]/g")
}

nsel=1
setvariables

while (true); do
	output=$($screen "$(pwd)" "$parent" "$current" "$child")

	# Here you can configure your shortcuts
	# the variable $sel contains the selected item
	# to use it in your shortcut
	case $output in
		q) break;;
		j) [ $nsel -lt $(ls -w 1 | wc -l) ] && nsel=$($add $nsel 1);;
		k) [ $nsel -gt 1 ] && nsel=$($add $nsel -1);;
		h) nsel=1; cd ..;;
		l) nsel=1; cd "$sel";;
		o) xdg-open "$sel";tput civis;;
		!) run_command;;
		R) nsel=1; cd /;;
		H) nsel=1; cd ~;;
		s) tput cnorm; stty "$old_stty"; clear; $SHELL; tput civis;;
	esac

	setvariables
done

# Cleaning up the mess of the curses session.
# The dfm_screen cannot call endwin
# else the whole screen would flicker
stty "$old_stty"
tput cnorm
clear

echo "Exit Dumb File Manager"
