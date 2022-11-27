fx_version 'adamant'
game 'gta5'
description 'Wheel_fortune'
version '1.5'


server_scripts {
	"@vrp/lib/utils.lua",
	'checkversion.lua',
	'config.lua',
    'language.lua',
	'server.lua'
}

client_scripts {
	"@vrp/lib/utils.lua",
	'config.lua',
    'language.lua',
	'client.lua',
}

files {
	"images/prop_luckywheel_01a_d2.png",
	"images/prop_luckywheel_decal_dprop_luckywheel_decal_a.png"
}