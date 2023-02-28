fx_version 'adamant'
games { 'rdr3', 'gta5' }
mod 'OdinHouse'
version '1.4'

ui_page "nui/index.html"

client_scripts {
  "@vrp/lib/utils.lua",
  '@NativeUILua_Reloaded/src/NativeUIReloaded.lua',
  'config.lua',
  'houses.lua', 
  'labels.lua', 
  'src/utils.lua',  
  'src/client/framework/framework_functions.lua',
  'src/client/menus/menus.lua',
  'src/client/menus/menus_native.lua',
  'src/client/menus/menus_esx.lua',
  'src/client/functions.lua',
  'src/client/main.lua',
  'inventory/property.lua',
  'src/client/commands.lua'
}

server_scripts {
  "@vrp/lib/utils.lua",
  '@mysql-async/lib/MySQL.lua',
  'src/server/vrp.lua',
  'config.lua',
  'checkversion.lua',
  'houses.lua',  
  'labels.lua', 
  'src/utils.lua',
  'src/server/server.lua',
  'src/server/framework/framework_functions.lua',
  'src/server/functions.lua',
  'inventory/propertyserver.lua',
  'src/server/main.lua'
  
}

files {
  "nui/index.html",
	"nui/css/bootstrap.min.css",
	"nui/css/jquery-ui.css",
	"nui/css/style.css",
	"nui/js/jquery-2.2.4.min.js",
	"nui/js/jquery-ui.min.js",
	"nui/js/ui.js",
	"nui/images/*.png"
}

dependencies {
  'NativeUILua_Reloaded',
  'input',
  'interiors',
  'meta_libs',
  "GHMattiMySQL",
}
