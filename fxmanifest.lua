fx_version 'cerulean'
game 'gta5'

description 'Basic Rental'
author 'keles'

shared_script '@qb-core/shared/locale.lua'
shared_script 'config.lua'

client_script 'client.lua'
server_script 'server.lua'

dependencies {
    'qb-core',
    'qb-target',
    'qb-menu'
}
