fx_version 'adamant'
games { 'rdr3', 'gta5' }
mod 'OdinHouse'
version '1.6'

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
	"nui/css/*.css",
	"nui/js/*.js",
	"nui/images/*.png"
}

dependencies {
  'NativeUILua_Reloaded',
  'input',
  'interiors',
  'meta_libs',
  "ghmattimysql",
}


