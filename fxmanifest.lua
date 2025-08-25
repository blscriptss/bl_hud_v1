fx_version 'cerulean'
game 'gta5'

author 'BL SCRIPTS'
description 'BL HUD V1'
version '1.0.0'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js',
    'html/icons/*.svg',
    'stream/squaremap.ytd',
    'stream/minimap.gfx'
}

client_scripts {
    'minimap.lua',
    'config/config.lua',
    'client/client.lua'
}

server_scripts {
    'server/server.lua'
}


dependency 'bl_lib'

client_scripts {
    '@bl_lib/lib.lua'
}
