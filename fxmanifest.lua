fx_version "bodacious"
game "gta5"
author "OdinTeam"

version '1.0'

client_scripts {
	"@vrp/lib/utils.lua",
	"config/config.lua",
	"config/config_client.lua",
	"client/client_homes.lua",
	"client/client_doors.lua",

}

server_scripts {
	"@vrp/lib/utils.lua",
	"checkversion.lua"
	"config/config.lua",
	"config/config_server.lua",
	"server/server_homes.lua",
	"server/server_doors.lua",
}


ui_page('ui/ui.html')

files {
    'ui/ui.html',
    'ui/numField.css',
	'ui/numField.js',
	'ui/numField.mp3',
	'ui/numField.png'
}