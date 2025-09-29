fx_version 'cerulean'
game 'gta5'

dependency 'menuv'

shared_scripts {
    '@reroll_libs/init.lua',
}

reroll_lib {
    "callback",
    "notifier"
}

client_scripts {
    '@menuv/menuv.lua',
    'client/client.lua'
}

