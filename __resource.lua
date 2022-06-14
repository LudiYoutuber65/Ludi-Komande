resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Ludi početne komande'

version '1.0.1'

server_script {
'@es_extended/locale.lua',
'server/server.lua',
'config.lua'
}

client_script {
'@es_extended/locale.lua',
'client/client.lua',
'config.lua'
}
