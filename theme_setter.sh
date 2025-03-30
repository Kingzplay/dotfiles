#!/bin/bash

GTK_CONF_FILES=("$HOME/.gtkrc-2.0" "$HOME/.config/gtk-3.0/settings.ini" "$HOME/.config/gtk-4.0/settings.ini")
POLYBAR_CONF_FILE="$HOME/.config/polybar/config.ini"
ERROR_CODE=0
GTK2_CONF_FILE="$HOME/.gtkrc-2.0"
GTK3_CONF_FILE="$HOME/.config/gtk-3.0/settings.ini"
DEFAULT_FONT='Sans 10'
DEFAULT_CURSOR='DMZ-Black'
WALLPAPER_FOLDER="$HOME/pics/wallpapers"
BSPWMRC="$HOME/.config/bspwm/bspwmrc"
ROFI_CONF="$HOME/.config/rofi/config.rasi"

# Make sure there are enough & valid arguments
if [ "$#" -le 0 ]; then
	echo "ERROR: Not enough arguments"
	exit 1
fi

# Function to check for errors
check () {
	cmd=$(eval $1)
	
} 
# Function to set the variable to the corresponding values
set_gtk_theme () {
	sed -i "s/gtk-theme-name.*/gtk-theme-name=\"$1\"/" $GTK_CONF_FILES
}
set_icon_theme () {
	sed -i "s/gtk-icon-theme-name.*/gtk-icon-theme-name=\"$1\"/" $GTK_CONF_FILES
}
set_font () {
	sed -i "s/gtk-font-name.*/gtk-font-name=\"$1\"/" $GTK_CONF_FILES
}
set_cursor_theme () {
	sed -i "s/gtk-cursor-theme-name.*/gtk-cursor-theme-name=\"$1\"/" $GTK_CONF_FILES
}
set_primary_color () {
	sed -i "s/primary =.*/primary = $1/" "$POLYBAR_CONF_FILE"
	sed -i "s/bspc config focused_border_color.*/bspc config focused_border_color		'$1'/" "$BSPWMRC"
	sed -i "s/accent:.*/accent:	$1;/" "$ROFI_CONF"
}
set_wallpaper () {
	sed -i "s,feh .*,feh --bg-fill $1," "$BSPWMRC"
}
set_global_theme_vars () {
	case $1 in
		'morning')
			set_gtk_theme "Yaru-sage-dark"
			set_icon_theme "Yaru-sage-dark"
			set_cursor_theme $DEFAULT_CURSOR
			set_primary_color '#657B69'
			set_font $DEFAULT_FONT
			set_wallpaper "$WALLPAPER_FOLDER/0001.jpg"
			;;
		'lighthouse')
			set_gtk_theme "Yaru-blue-dark"
			set_icon_theme "Yaru-blue-dark"
			set_cursor_theme $DEFAULT_CURSOR
			set_primary_color '#156CC6'
			set_font $DEFAULT_FONT 
			set_wallpaper "$WALLPAPER_FOLDER/0198.jpg"
			;;
		'waves')
			set_gtk_theme "Yaru-prussiangreen-dark"
			set_icon_theme "Yaru-prussiangreen-dark"
			set_cursor_theme $DEFAULT_CURSOR
			set_primary_color '#6CA5B9'
			set_font $DEFAULT_FONT 
			set_wallpaper "$WALLPAPER_FOLDER/0271.jpg"
			;;
		'field')
			set_gtk_theme "Yaru-prussiangreen-dark"
			set_icon_theme "Yaru-prussiangreen-dark"
			set_cursor_theme $DEFAULT_CURSOR
			set_primary_color '#6CA5B9'
			set_font $DEFAULT_FONT 
			set_wallpaper "$WALLPAPER_FOLDER/0020.jpg"
			;;
		'storm')
			set_gtk_theme "Yaru-purple-dark"
			set_icon_theme "Yaru-purple-dark"
			set_cursor_theme $DEFAULT_CURSOR
			set_primary_color '#8E8BD8'
			set_font $DEFAULT_FONT 
			set_wallpaper "$WALLPAPER_FOLDER/0219.jpg"
			;;
		'mountain')
			set_gtk_theme "Yaru-purple-dark"
			set_icon_theme "Yaru-purple-dark"
			set_cursor_theme $DEFAULT_CURSOR
			set_primary_color '#8E8BD8'
			set_font $DEFAULT_FONT 
			set_wallpaper "$WALLPAPER_FOLDER/0081.jpg"
			;;
		'snowy')
			set_gtk_theme "Yaru-purple-dark"
			set_icon_theme	"Yaru-purple-dark"
			set_cursor_theme $DEFAULT_CURSOR
			set_primary_color '#8E8BD8'
			set_font $DEFAULT_FONT
			set_wallpaper "$WALLPAPER_FOLDER/0034.jpg"
			;;
		'road')
			set_gtk_theme "Yaru-olive-dark"
			set_icon_theme "Yaru-olive-dark"
			set_cursor_theme $DEFAULT_CURSOR
			set_primary_color '#6CA5B9'
			set_font $DEFAULT_FONT 
			set_wallpaper "$WALLPAPER_FOLDER/0033.jpg"
			;;
		*)
			
			echo "ERROR: Theme \"$1\" is unknown"
			exit 1
			;;
	esac
}
parse_args () {		
	skip=0	
	for ((i = 1; i <= $#; i+=1)); do			
		case ${!i} in
			'--theme') 
				i=$(($i+1))
				set_global_theme_vars ${!i}
				;;
			'--cursor')
				i=$(($i+1))
				set_cursor_theme ${!i}
				;;
			'--color')
				i=$(($i+1))	
				set_cursor_color ${!i}
				;;
			'--wallpaper')
				i=$(($i+1))
				set_wallpaper ${!i}
				;;
			'--font')
				i=$(($i+1))
				set_font ${!i}
				;;
			'--icon')
				i=$(($i+1))
				set_icon_theme ${!i}
				;;
			'--gtk-theme')
				i=$(($i+1))
				set_gtk_theme ${!i}
				;;
			*)
				echo "ERROR: Invalid option \"${!i}\""
				exit 1
				;;
		esac
	done
}

parse_args "$@"

