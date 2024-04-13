fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'sokey.pro (sokey)'
description 'Tackle script for FiveM'
version '1.0.0'

client_scripts {
    'client/*.lua',
}

server_scripts {
    'server/*.lua',
}

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua',
    '@es_extended/imports.lua',
}
