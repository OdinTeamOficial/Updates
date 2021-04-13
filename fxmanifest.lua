fx_version 'bodacious'
game 'gta5'

ui_page "nui/index.html"

author 'Odin Team'

version '5.0'

client_scripts {
	"@vrp/lib/utils.lua",
	"config.lua",
	"client.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"config.lua",
	"checkversion.lua",
	"server.lua"
}

files {
	"nui/*.html",
	"nui/*.js",
	"nui/*.css",
	"nui/slick/*.css",
	"nui/slick/*.js",
	"nui/slick/*.scss",
	"nui/slick/*.less",
	"nui/slick/*.rb",
	"nui/slick/*.gif",
	"nui/images/*.png",
}