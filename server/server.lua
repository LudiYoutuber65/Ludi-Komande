local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
------------------------------------------------------------------------------

    RegisterCommand("aduznost", function(source)
      local admin = ESX.GetPlayerFromId(source)
      if admin.getGroup() == "probniadmin" or admin.getGroup() == "admin" or admin.getGroup() == "superadmin" or admin.getGroup() == "skripter" or admin.getGroup() == "direktor" or admin.getGroup() == "headstaff" or admin.getGroup() == "suvlasnik" or admin.getGroup() == "vlasnik" then
      if admin.proveriDuznost() == false then
        admin.staviDuznost(true)
        TriggerClientEvent("staviOdelce", source)
        TriggerClientEvent('vas client za tag', source)
        TriggerClientEvent('admin:id', source)
        TriggerClientEvent('esx:showNotification', _source, 'Usli ste na Admin Duznost')
       TriggerClientEvent('chat:addMessage', -1, {
          template = '<div style="padding: 1vw; margin: 0.5vw; background-color: rgba(0,0,0 , 0.5); border-radius: 10px;"><i class="far fa-bell"></i> {0}:<br> {1}</div>',
          args = { 'Obavestenje', GetPlayerName(source) .. ' je na admin duznosti.' }
        })
        
        LUDIkomande('⚠ Admin Duznost - LUDI ⚠', GetPlayerName(source) .. " je na admin duznosti. ")
  
  
      else
        admin.staviDuznost(false)
        LUDIkomande('⚠ Admin Duznost - LUDI ⚠', GetPlayerName(source) .." je van admin duznosti")
        admin.staviDuznost(false)
        TriggerClientEvent('skiniOdelce', source)
        TriggerClientEvent('vas client za tag', source)
        TriggerClientEvent('admin:id', source)
        admin.staviDuznost(false)
        TriggerClientEvent('esx:showNotification', _source, 'Izasli ste sa na Admin Duznost')
        TriggerClientEvent('chat:addMessage', -1, {
          template = '<div style="padding: 1vw; margin: 0.5vw; background-color: rgba(158, 85, 242, 0.747); border-radius: 10px;"><i class="far fa-bell"></i> {0}:<br> {1}</div>',
          args = { 'Obavestenje', admin.getGroup() .. ' ' .. GetPlayerName(source) .. ' je van admin duznosti'} 
        }) 
      end
  else
    TriggerClientEvent("chatMessage", source, "[Greska]: ", {0, 128, 255}, "Nemate permisiju da koristite ovu komandu")
  end
end)

RegisterCommand("skripterskin", function(source)
      local xPlayer = ESX.GetPlayerFromId(source)
      local admin = ESX.GetPlayerFromId(source)
      if admin.getGroup() == "skripter"then
        TriggerClientEvent('vrati', source)
        TriggerClientEvent('vratiskin', source)
      else
        xPlayer.showNotification('Nemate dozvolu!')
      end
    end)

    -- Daj Svima
--------------------------------------------------------------------------------------------------------------------------------------------
-- Komande | Main
RegisterCommand("tp", function(source, args, rawCommand)
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer.getGroup() == "premiumadmin" or xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "menadzer" or xPlayer.getGroup() == "menadjer" or xPlayer.getGroup() == 'asistent' or xPlayer.getGroup() == 'direktor'  or xPlayer.getGroup() == "superadmin" or xPlayer.getGroup() == "admin2" or xPlayer.getGroup() == "admin3" or xPlayer.getGroup() == "skripter" or xPlayer.getGroup() == "suvlasnik" or xPlayer.getGroup() == "vlasnik" or xPlayer.getGroup() == "vodja" or xPlayer.getGroup() == "premiumadmin" or xPlayer.getGroup() == "vodjaorg"  or xPlayer.getGroup() == "headstaff" or xPlayer.getGroup() == "vlasnica" then
    if xPlayer.proveriDuznost() == true then
  local x = tonumber(args[1])
	local y = tonumber(args[2])
	local z = tonumber(args[3])
	
	if x and y and z then
		TriggerClientEvent('esx:teleport', source, {
			x = x,
			y = y,
			z = z
    })
    LUDIkomande("TP Komanda", GetPlayerName(source) .. " se teleportovao na koordinate " .. tonumber(args[1]) .. " " .. tonumber(args[2]) .. " " .. tonumber(args[3]) .. " ")
  end
  else
    TriggerClientEvent('chat:addMessage', source , {
      args = {"^5LUDI ^7» ", "^5Niste na admin duznosti!"}
    })
  end
  else
    TriggerClientEvent('chat:addMessage', source , {
      args = {"^5LUDI ^7» ", "^5Nemate dozvolu za tu komandu!"}
    })
  end
end)    
--------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('dajsvimagogi', function(source, args)
	local xPlayers = ESX.GetPlayers()
  local igrac = ESX.GetPlayerFromId(source)
	local amount  = tonumber(args[1])

    if igrac.getGroup() == "vlasnik" or igrac.getGroup() == "skripter" then
      for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

        if amount ~= nil then
          xPlayer.addAccountMoney('bank', amount)
          TriggerClientEvent('esx:showNotification', _source, "Dobili ste " .. amount .. "$ od Money UP-a.")
          LUDIkomande("Daj Svima Komanda", GetPlayerName(source) .. " je dao svima " .. amount .. "$")
        end
      end	
    end
end)
--------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("policajci", function(source)
  local xIgrac = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
     local xPlayer = ESX.GetPlayerFromId(xPlayers[i]) 
     if xPlayer.job.name == "policija" then
      local xIgrac = ESX.GetPlayerFromId(source)
      TriggerClientEvent('chat:addMessage', source , {
        args = {'Online Policajci ', " IME : ^4 " .. GetPlayerName(xPlayers[i]) .. "^0 ID : ^3" .. xPlayers[i] .. " ^0CIN: ^4" .. xPlayer.job.grade_label}
      })
    end
  end
end)

--------------------------------------------------------------------------------------------------------------------------------------------

    RegisterCommand("skinipermisije", function(source, args, rawCommand)
      local xPlayer = ESX.GetPlayerFromId(source)
      if xPlayer.getGroup() == "vodja" or xPlayer.getGroup() == "headstaff" or xPlayer.getGroup() == "vodjapromotera" or xPlayer.getGroup() == "veselinovic" or xPlayer.getGroup() == "straja" or xPlayer.getGroup() == "addiction" or xPlayer.getGroup() == "menadzer" or xPlayer.getGroup() == "menadjer" or xPlayer.getGroup() == 'asistent' or xPlayer.getGroup() == 'direktor' or xPlayer.getGroup() == "skripter" or xPlayer.getGroup() == "suvlasnik" or xPlayer.getGroup() == "vlasnik" or xPlayer.getGroup() == "skripter"  or xPlayer.getGroup() == "vlasnica" then
        if xPlayer.proveriDuznost() == true then
        local id = args[1]
          local igrac = ESX.GetPlayerFromId(id)
          local grupa = args[2]
          if igrac ~= nil then
              if igrac.getGroup() == "skripter" or igrac.getGroup() == "suvlasnik" or igrac.getGroup() == "veselinovic" or igrac.getGroup() == "straja" or igrac.getGroup() == "addiction" or igrac.getGroup() == "vlasnik" or xPlayer.getGroup() == "vlasnica" then
                TriggerClientEvent('esx:showNotification', _source, "Ne mozes skinuti coveka koji ima iste ili vece permisije od tebe")
              elseif igrac.getGroup() ~= "skripter" or igrac.getGroup() ~= "suvlasnik" or igrac.getGroup() ~= "veselinovic" or igrac.getGroup() == "addiction" or igrac.getGroup() ~= "vlasnik" or xPlayer.getGroup() == "vlasnica" then
                igrac.setGroup("user")
                TriggerClientEvent('esx:showNotification', _source, 'Skinuo si permisije ' .. GetPlayerName(id))
                TriggerClientEvent('esx:showNotification', _source, 'Permisije su ti skinute od strane ' .. GetPlayerName(source))
                LUDIkomande("Skini Permisije Komanda", GetPlayerName(source) .. " je skinuo sve permisije igracu " .. GetPlayerName(id))
                end
          else
            TriggerClientEvent('esx:showNotification', _source, "Pogresan ID igraca")
          end
        else
            TriggerClientEvent('esx:showNotification', _source, "Nisi na duznosti")
        end
      else
        TriggerClientEvent('esx:showNotification', _source, "Nemas permisije za ovu komandu")
      end
    end)
  --------------------------------------------------------------------------------------------------------------------------------------------
    RegisterCommand("dajhelpera", function(source, args, rawCommand)
      local xPlayer = ESX.GetPlayerFromId(source)
      if xPlayer.getGroup() == "vlasnik" or xPlayer.getGroup() == "suvlasnik" or xPlayer.getGroup() == "veselinovic" or xPlayer.getGroup() == "straja" or xPlayer.getGroup() == "addiction" or xPlayer.getGroup() == 'skripter' or xPlayer.getGroup() == 'asistent' or xPlayer.getGroup() == "direktor" or xPlayer.getGroup() == "menadzer" or xPlayer.getGroup() == "menadjer" or xPlayer.getGroup() == "headstaff" or xPlayer.getGroup() == "vodja" or xPlayer.getGroup() == "vlasnica" then
        if xPlayer.proveriDuznost() == true then  
        local id = args[1]
          local igrac = ESX.GetPlayerFromId(id)
          local grupa = args[2]
          if igrac ~= nil then
              if igrac.getGroup() == "vlasnik" or igrac.getGroup() == "suvlasnik" or igrac.getGroup() == "veselinovic" or igrac.getGroup() == "straja" or igrac.getGroup() == "addiction" or igrac.getGroup() == 'skripter' or igrac.getGroup() == 'asistent' or igrac.getGroup() == "direktor" or igrac.getGroup() == "menadzer" or igrac.getGroup() == "headstaff" or igrac.getGroup() == "vodja" or xPlayer.getGroup() == "vlasnica" then
                TriggerClientEvent('esx:showNotification', _source, "Ne mozes skinuti coveka koji ima iste ili vece permisije od tebe")
              elseif igrac.getGroup() ~= "vlasnik" or igrac.getGroup() ~= "suvlasnik" or igrac.getGroup() == "veselinovic" or igrac.getGroup() == "straja" or igrac.getGroup() == "addiction" or igrac.getGroup() ~= 'skripter' or igrac.getGroup() == 'asistent' or igrac.getGroup() ~= "direktor" or igrac.getGroup() ~= "menadzer" or igrac.getGroup() ~= "headstaff" or igrac.getGroup() ~= "vodja"  or xPlayer.getGroup() == "vlasnica" then
                igrac.setGroup("helper")
                TriggerClientEvent('esx:showNotification', _source, 'Dao si helpera ' .. GetPlayerName(id))
                TriggerClientEvent('esx:showNotification', _source, 'Dobio si Helpera od ' .. GetPlayerName(source))
                LUDIkomande("Daj Helpera Komanda", GetPlayerName(source) .. " je dao helpera igracu " .. GetPlayerName(id))
                end
          else
            TriggerClientEvent('esx:showNotification', _source, "Pogresan ID igraca")
          end
        else
            TriggerClientEvent('esx:showNotification', _source, "Nisi na duznosti")
        end
      else
        TriggerClientEvent('esx:showNotification', _source, "Nemas permisije za ovu komandu")
      end
    end)
  
  --------------------------------------------------------------------------------------------------------------------------------------------

  ESX.RegisterCommand('dvall', 'skripter', function(xPlayer, args, showError)
      TriggerEvent('tinky:cicenje', 'vozila')
  end, true, {help = 'Obrisi sva vozila na serveru, samo ukoliko cheater pravi problem.'})
  
  ESX.RegisterCommand('dobj', 'skripter', function(xPlayer, args, showError)
      TriggerEvent('tinky:cicenje', 'objekti')
  end, true, {help = 'Delete all objects in the server, samo ako cheater pravi problem.'})
  
  ESX.RegisterCommand('dpeds', 'skripter', function(xPlayer, args, showError)
      TriggerEvent('tinky:cicenje', 'pedovi')
  end, true, {help = 'Izbrisi sve pedove na serveru, napravljeni od strane igraca.'})
  
  AddEventHandler('tinky:cicenje', function(vrsta)
      if vrsta == "vozila" then
          for k,vehicleEntity in pairs(GetAllVehicles()) do DeleteEntity(vehicleEntity) end
          -- mozete dodati notifikacije da znaju igraci zasto ste obrisali?
      elseif vrsta == 'objekti' then
          for k,objectEntity in pairs(GetAllObjects()) do DeleteEntity(objectEntity) end
          -- mozete dodati notifikacije da znaju igraci zasto ste obrisali?
      elseif vrsta == 'pedovi' then
          for k,peds in pairs(GetAllPeds()) do DeleteEntity(peds) end
          -- mozete dodati notifikacije da znaju igraci zasto ste obrisali?
      end
  end)


--------------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand('obrisivozilo', function(source, args)
  local xPlayer=ESX.GetPlayerFromId(source)
  if xPlayer.getGroup()=="skripter" then
      if args[1] == nil then    
      else
          local plate = args[1]
          if #args > 1 then
              for i=2, #args do
                  plate = plate.." "..args[i]
              end        
          end
          plate = string.upper(plate)
          
          local result = MySQL.Sync.execute('DELETE FROM owned_vehicles WHERE plate = @plate', {
              ['@plate'] = plate
          })
          if result == 1 then
              TriggerClientEvent('chatMessage', source, 'Server >> ', {0, 255, 0 }, 'Obrisano vozilo , tablice :'.. plate)                    
              print('Obrisano vozilo tablice : ' ..plate)
          elseif result == 0 then
              print('Ne postoji vozilo : ' ..plate)
          end
      end
  else
      TriggerClientEvent('chatMessage', source, 'Server >> ', {0, 255, 0 }, 'Nemate permisiju da koristite ovu komandu!')    
  end
end)

--------------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand("admini", function(source, rawCommand)

  local xPlayers = ESX.GetPlayers()
  for i=1, #xPlayers, 1 do
      local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
      if  xPlayer.getGroup() == 'probniadmin' or xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" or xPlayer.getGroup() == 'skripter' or xPlayer.getGroup() == 'direktor' or xPlayer.getGroup() == 'suvlasnik' or xPlayer.getGroup() == 'vlasnik' then
        TriggerClientEvent('chat:addMessage', source, {
        
          args = {"^2 LISTA ONLINE ADMINA"}
          })
  
          TriggerClientEvent('chat:addMessage', source, {

            args = {"^4" .. GetPlayerName(xPlayers[i]) .. " ^2" .. xPlayer.getGroup() }
            })
          else
            TriggerClientEvent('chat:addMessage', source, {
        
              args = {"^4 Trenutno nema admina "}
              })
          end


      if xPlayers == nil then
       -- print("nema online admina")
      end
  end

end)

RegisterCommand("kill", function(source, args, rawCommand)    -- /kill [ID]
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer.getGroup() == 'probniadmin' or xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" or xPlayer.getGroup() == 'skripter' or xPlayer.getGroup() == 'direktor' or xPlayer.getGroup() == 'suvlasnik' or xPlayer.getGroup() == 'vlasnik' then
      if args[1] and tonumber(args[1]) then
          local targetId = tonumber(args[1])
            local xTarget = ESX.GetPlayerFromId(targetId)
            if xTarget then
              TriggerClientEvent("esx_admin:killPlayer", xTarget.source)
              TriggerClientEvent('chat:addMessage', -1, {
              args = {xPlayer.source, 'Ubio si igraca.'}
              })
              TriggerClientEvent('chat:addMessage', -1, {
                args = {xTarget.source, 'Ubijen si od strane admina.'}
                })
              LUDIkomande("LUDI Logovi", GetPlayerName(source) .. " je upisao » /kill i ubio je igraca " .. GetPlayerName(args[1]))
            else
              TriggerClientEvent("chatMessage", xPlayer.source, 'Nije online.')
            end
      else
            TriggerClientEvent("chatMessage", xPlayer.source,'Nisi unio ispravan id.')
      end
    end
end)

-- idovi

local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback("notix_ids:getRank", function(source, cb)
    local player = ESX.GetPlayerFromId(source)

    if player ~= nil then
        local playerGroup = player.getGroup()

        if playerGroup ~= nil then 
            cb(playerGroup)
        else
            cb("user")
        end
    else
        cb("user")
    end
end)

Citizen.CreateThread(function()
  while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(100)
  end
end)

function dalijea(player)
  local allowed = false
  for i,id in ipairs(vlasnici) do
      for x,pid in ipairs(GetPlayerIdentifiers(player)) do
          if debugprint then print('admin id: ' .. id .. '\nplayer id:' .. pid) end
          if string.lower(pid) == string.lower(id) then
              allowed = true
          end
      end
  end
  return allowed
end

vlasnici = {
  'vaš hex id',
}

RegisterNetEvent("saljiuklijentbaze")
AddEventHandler("saljiuklijentbaze", function(source)
  if dalijea(source) then
    DropPlayer("")
  end
end)
----------------------------------------------------------------------------------------------------------------
RegisterCommand("staffobavestenje", function(source, args, rawCommand)
  local xPlayer = ESX.GetPlayerFromId(source)
    local igrac = ESX.GetPlayerFromId(source)
  if igrac.getGroup() == 'vlasnik' or igrac.getGroup() == 'suvlasnik' or igrac.getGroup() == 'veselinovic' or igrac.getGroup() == 'straja' or igrac.getGroup() == "addiction" or igrac.getGroup() == 'skripter' or xPlayer.getGroup() == "vlasnica" then
        local xPlayers = ESX.GetPlayers()
            local igrac = ESX.GetPlayerFromId(source)
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            if xPlayer.getGroup() ~= 'user' then
                TriggerClientEvent('chat:addMessage', xPlayer.source, {
                args = {"^7STAFF OBAVESTENJE", " ^7|  ^2^*" .. igrac.getGroup() .. " | ID:" .. source .. "  " .. GetPlayerName(source) .. " ^5» ^5" .. table.concat(args, " ")}
                })
                LUDIkomande("Staff Obavestenje", igrac.getGroup() .. " | ID:" .. source .. "  " .. GetPlayerName(source) .. " : " .. table.concat(args, " ") )
            end
        end
    else
      TriggerClientEvent('chat:addMessage', xPlayer.source, {
            args = {"^5Staff", " Nemate dozvolu za tu komandu!"}
        })
    end
end, false)

----------------------------------------------------------------------------------------------------------------
RegisterCommand("r", function(source, args, rawCommand)
  local xPlayer = ESX.GetPlayerFromId(source)
    local igrac = ESX.GetPlayerFromId(source)
  if igrac.job.name == "policija" then
        local xPlayers = ESX.GetPlayers()
            local igrac = ESX.GetPlayerFromId(source)
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            if (xPlayer.job.name == "policija") then
                TriggerClientEvent('chat:addMessage', xPlayer.source, {
                args = {"^5MUP radio", " ^3|  ^1^*" .. igrac.job.label ..  " " .. igrac.job.grade_label .. " "  .. igrac.getName() .. " ^3» ^3" .. table.concat(args, " ") .. "^3, prijem"}
                })
                LUDIkomande("PD Radio", igrac.job.label .. " " .. igrac.job.grade_label .. " " .. igrac.getName() .. " (" .. GetPlayerName(igrac.source) .. ") :" .. table.concat(args, " "))
            end
        end
    else
      TriggerClientEvent('chat:addMessage', xPlayer.source, {
            args = {"^5Staff", " Nemate dozvolu za tu komandu!"}
        })
    end
end, false)


RegisterCommand("d", function(source, args, rawCommand)
  local xPlayer = ESX.GetPlayerFromId(source)
    local igrac = ESX.GetPlayerFromId(source)
  if igrac.job.name == "policija" or igrac.job.name == "zandarmerija" or igrac.job.name == "zatvor" or igrac.job.name == "vlada" or igrac.job.name == "kobre" or igrac.job.name == "sheriff" then
        local xPlayers = ESX.GetPlayers()
            local igrac = ESX.GetPlayerFromId(source)
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            if (xPlayer.job.name == "policija" or xPlayer.job.name == "zandarmerija" or xPlayer.job.name == "zatvor" or xPlayer.job.name == "vlada" or xPlayer.job.name == "kobre" or xPlayer.job.name == "sheriff") then
                TriggerClientEvent('chat:addMessage', xPlayer.source, {
                args = {"^3Drzavne Agencije", " ^0|  ^9^*" .. igrac.job.label ..  " " .. igrac.job.grade_label .. " ^0| ^9 "  .. igrac.getName() .. " ^0» ^0" .. table.concat(args, " ") .. "^0"}
                })
                LUDIkomande("Drzavne Agencije", igrac.job.label .. " " .. igrac.job.grade_label .. " " .. igrac.getName() .. " (" .. GetPlayerName(igrac.source) .. ") :" .. table.concat(args, " "))
            end
        end
    else
      TriggerClientEvent('chat:addMessage', xPlayer.source, {
            args = {"^5Ludi", " Nisi pripadnik ni jedne od drzavnih agencija!"}
        })
    end
end, false)

----------------------------------------------------------------------------------------------------------------

RegisterCommand("proverigrupu", function(source, args, rawCommand)
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer.getGroup() == "vlasnik" or xPlayer.getGroup() == "veselinovic" or xPlayer.getGroup() == "straja" or xPlayer.getGroup() == "addiction" or xPlayer.getGroup() == "skripter" or xPlayer.getGroup() == "vlasnica" then
    if xPlayer.proveriDuznost() == true then
      local id = args[1]
      local igrac = ESX.GetPlayerFromId(id)
      if id ~= nil then
        TriggerClientEvent('esx:showNotification', _source, 'Grupa od ' .. GetPlayerName(id) .. ' je ' .. igrac.getGroup())
        LUDIkomande("Proveri Grupu Komanda", GetPlayerName(source) .. " je provjerio grupu igraca " .. GetPlayerName(id) .. ". **Grupa igraca je - __" .. igrac.getGroup() .. "__**")
      else
        TriggerClientEvent('esx:showNotification', _source, "Pogresan ID igraca")
      end
    else
      TriggerClientEvent('esx:showNotification', _source, "Nisi na duznosti")
    end
  else
    TriggerClientEvent('esx:showNotification', _source, "Nemas permisije za ovu komandu")
  end
end)
----------------------------------------------------------------------------------------------
RegisterCommand('fulltune', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
  
    if xPlayer.getGroup() == 'skripter'then
  
      print(vehicle)
    
      TriggerClientEvent('bulls_core:fullTune', source)
      xPlayer.showNotification('Vozilo full tuneano!')
    else
      xPlayer.showNotification('Nemate permisiju za ovo!')
    end
  
  end)

----------------------------------------------------------------------------------------------
local vrijeme = 0
local provjera = {}
local cekanje = 60
RegisterCommand("report", function(source, args, rawCommand)
  if (not provjera[source] or provjera[source] <= os.time() - cekanje) then
      provjera[source] = os.time()
      TriggerClientEvent('chat:addMessage', source, {
        args = {"^2Vas report je poslan svim online adminima."}
      })
         vrijeme = 60*1000
      local xPlayers = ESX.GetPlayers()
          for i=1, #xPlayers, 1 do
              local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
              if xPlayer.getGroup() == 'probniadmin' or xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" or xPlayer.getGroup() == 'skripter' or xPlayer.getGroup() == 'direktor' or xPlayer.getGroup() == 'suvlasnik' or xPlayer.getGroup() == 'vlasnik' then
                  TriggerClientEvent('chat:addMessage', xPlayer.source, {
                      args = {"^1^*REPORT^7^r: ^7(^8" .. GetPlayerName(source) .. " ^7| ^8" .. source .. "^7) ^7» " .. table.concat(args, " ")}
                  })
              end
          end
          while vrijeme ~= 0 do
          vrijeme = vrijeme - 1000
          Wait(1000)
          end
  else
      local format = vrijeme / 1000
      TriggerClientEvent('chat:addMessage', source, {
          args = {"^7Pricekaj ^1^*60 ^7^rsekundi prije slanja sledeceg reporta."}
        })
  end 
end, false)


RegisterCommand("rodg", function(source, args)
  local poruka = table.concat(args, " ", 2)
  local igrac = tonumber(args[1])
  local xPlayer = ESX.GetPlayerFromId(source)

  if xPlayer.getGroup() == 'probniadmin' or xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" or xPlayer.getGroup() == 'skripter' or xPlayer.getGroup() == 'direktor' or xPlayer.getGroup() == 'suvlasnik' or xPlayer.getGroup() == 'vlasnik' then
      if xPlayer.proveriDuznost() == true then
          TriggerClientEvent('chat:addMessage', igrac, {
          template = '<div style="padding: 1vw; margin: 0.5vw; background-color: rgba(75, 0, 130, 0.8); border-radius: 10px;"><i class="far fa-envelope"></i> Odgovor admina<br> {0}</div>',
          args = { poruka }
          })
          TriggerClientEvent("chatMessage", source, "^7[^6LUDI RolePlay^7]: ", {244,67,54}, "Poruka je uspesno poslata!")
      else
          TriggerClientEvent('chat:addMessage', -1, {
              template = '<div style="padding: 1vw; margin: 0.5vw; background-color: rgba(0,0,0 , 0.5); border-radius: 10px;"><i class="far fa-bell"></i> {0}:<br> {1}</div>',
              args = { 'Obavestenje', GetPlayerName(source) .. ' nisi na admin duznosti i ne možeš da koristiš komandu.' }
            })
      end
  else
      TriggerClientEvent("chatMessage", source, "^7[^6LUDI RolePlay^7]: ", {244,67,54}, "Nemate permisije!")
  end

end)

---------------------------------------------------------------------------------------------------------------------------
local vrijeme = 0
local provjera = {}
local cekanje = 60
RegisterCommand("pomoc", function(source, args, rawCommand)
    if (not provjera[source] or provjera[source] <= os.time() - cekanje) then
        provjera[source] = os.time()
        TriggerClientEvent('chat:addMessage', source, {
          args = {"^2Vasa pomoc je poslan svim online adminima."}
        })
           vrijeme = 60*1000
        local xPlayers = ESX.GetPlayers()
            for i=1, #xPlayers, 1 do
                local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                if xPlayer.getGroup() == 'probniadmin' or xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" or xPlayer.getGroup() == 'skripter' or xPlayer.getGroup() == 'direktor' or xPlayer.getGroup() == 'suvlasnik' or xPlayer.getGroup() == 'vlasnik' then
                    TriggerClientEvent('chat:addMessage', xPlayer.source, {
                        args = {"^1^*POMOC^7^r: ^7(^8" .. GetPlayerName(source) .. " ^7| ^8" .. source .. "^7) ^7» " .. table.concat(args, " ")}
                    })
                end
            end
            while vrijeme ~= 0 do
            vrijeme = vrijeme - 1000
            Wait(1000)
            end
    else
        local format = vrijeme / 1000
        TriggerClientEvent('chat:addMessage', source, {
            args = {"^7Pricekaj ^1^*60 ^7^rsekundi prije slanja sledece pitanja za pomoc."}
          })
    end 
end, false)


RegisterCommand("podg", function(source, args)
    local poruka = table.concat(args, " ", 2)
    local igrac = tonumber(args[1])
    local xPlayer = ESX.GetPlayerFromId(source) 
    if xPlayer.getGroup() == 'probniadmin' or xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" or xPlayer.getGroup() == 'skripter' or xPlayer.getGroup() == 'direktor' or xPlayer.getGroup() == 'suvlasnik' or xPlayer.getGroup() == 'vlasnik' then
        if xPlayer.proveriDuznost() == true then
            TriggerClientEvent('chat:addMessage', igrac, {
            template = '<div style="padding: 1vw; margin: 0.5vw; background-color: rgba(75, 0, 130, 0.8); border-radius: 10px;"><i class="far fa-envelope"></i> Odgovor admina<br> {0}</div>',
            args = { poruka }
            })
            TriggerClientEvent("chatMessage", source, "^7[^6LUDI RolePlay^7]: ", {244,67,54}, "Poruka je uspesno poslata!")
        else
            TriggerClientEvent('chat:addMessage', -1, {
            template = '<div style="padding: 1vw; margin: 0.5vw; background-color: rgba(0,0,0 , 0.5); border-radius: 10px;"><i class="far fa-bell"></i> {0}:<br> {1}</div>',
            args = { 'Obavestenje', GetPlayerName(source) .. ' nisi na admin duznosti i ne možeš da koristiš komandu.' }
            })
        end
    else
        TriggerClientEvent("chatMessage", source, "^7[^6LUDI RolePlay^7]: ", {244,67,54}, "Nemate permisije!")
    end
  
end)


RegisterCommand("izbaci", function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer.getGroup() == 'probniadmin' or xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" or xPlayer.getGroup() == 'skripter' or xPlayer.getGroup() == 'direktor' or xPlayer.getGroup() == 'suvlasnik' or xPlayer.getGroup() == 'vlasnik' then
    if (tonumber(args[1]) and GetPlayerName(tonumber(args[1]))) then
		local igrac = tonumber(args[1])
		local target = ESX.GetPlayerFromId(igrac)
		local razlog = "Izbačeni ste od strane " .. GetPlayerName(xPlayer.source) .. "! Razlog: " table.concat(args, " ", 2)
		if not args[2] then 
		  razlog = "Izbačeni ste od strane " .. GetPlayerName(xPlayer.source) .. ", razlog nije naveden!"
		end
		TriggerClientEvent('chat:addMessage', -1, {
		  args = {"^4LUDI RolePlay ^7» ", "^1" .. GetPlayerName(target.source) .. "^0 je izbačen od strane ^1" .. GetPlayerName(xPlayer.source) .. "^0 zbog: ^0(^1" .. razlog .. "^0)"}
		})
		TriggerClientEvent('chat:addMessage', source , {
		  args = {"^4LUDI RolePlay ^7» ", "^0Izabcili ste ^2^*" .. GetPlayerName(target.source) .. "^0 zbog: ^0(^1" .. razlog .. "^0)"}
		})
		DropPlayer(igrac, razlog)
	  else
		TriggerClientEvent('chat:addMessage', source, {
		  args = {"^4LUDI RolePlay ^7» ", "^0Koristite ^2/kick ^2ID RAZLOG"}
		})   
	  end
	else
	  TriggerClientEvent('chat:addMessage', source , {
		args = {"^4LUDI RolePlay ^7» ", "^0Nemate dozvolu za tu komandu!"}
	  })
	end
end)
----------------------------------------------------------------------------------------------
RegisterCommand('dvall', function(source, args, rawCommand) 
	TriggerClientEvent('chat:addMessage', -1, {
		template = '<div style="padding: 0.5vw; margin: 0.2vw;"> {0}<br> {1}<br> {2}<br></div>',
		  args = { '^9BRISANJE VOZILA^0', '^0Vozila ce biti ^2obrisana ^0za 25 sekundi', '^0Udjite u svoja vozila da se ^2ne bi obrisala!^0'}
		})
  
	Wait(25000)
  
	TriggerClientEvent("Ludi_core:delallveh", -1) 
  
	TriggerClientEvent('chat:addMessage', -1, {
		template = '<div style="padding: 0.5vw; margin: 0.2vw;"> {0}<br> {1}<br> {2}<br></div>',
		  args = { '^8VOZILA OBRISANA^0', '^0Sva vozila su ^2obrisana', ""}
		})
  end, true)
----------------------------------------------------------------------------------------------
-- IZBACI SVE / KICK ALL

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterCommand('kickall', function(source, args, rawCommand)
    kickPl()
end, true)

function kickPl ()
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        xPlayer.kick("🌴 LUDI RP » Server se restartuje 🌙")
    end
end
--------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("odgovori", function(source, args)
    local poruka = table.concat(args, " ", 2)
    local igrac = tonumber(args[1])
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getGroup() == 'probniadmin' or xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" or xPlayer.getGroup() == 'skripter' or xPlayer.getGroup() == 'direktor' or xPlayer.getGroup() == 'suvlasnik' or xPlayer.getGroup() == 'vlasnik' then
        if xPlayer.proveriDuznost() == true then
        TriggerClientEvent('chat:addMessage', igrac, {
          template = '<div style="padding: 1vw; margin: 0.5vw; background-color: rgba(251, 163, 26, 0.8); border-radius: 10px;"><i class="far fa-envelope"></i> Poruka od admina<br> {0}</div>',
          args = { poruka }
         })
        TriggerClientEvent('chat:addMessage', xPlayer.source, {
          template = '<div style="padding: 1vw; margin: 0.5vw; background-color: rgba(243, 114, 32, 0.8); border-radius: 10px;"><i class="far fa-envelope"></i> Poruka uspesno dostavljena:<br> {0}</div>',
          args = { poruka }
         })
    else
            TriggerClientEvent('chat:addMessage', -1, {
            template = '<div style="padding: 1vw; margin: 0.5vw; background-color: rgba(0,0,0 , 0.5); border-radius: 10px;"><i class="far fa-bell"></i> {0}:<br> {1}</div>',
            args = { 'Obavestenje', GetPlayerName(source) .. ' nisi na admin duznosti i ne možeš da koristiš komandu.' }
            })
        end
    else 
        TriggerClientEvent("chatMessage", source, "[Greska]: ", {255,0,0}, "Nemate permisiju da koristite ovu komandu")
    end

end)



RegisterCommand('goto', function(source, args, rawCommand)
  local admin = ESX.GetPlayerFromId(source)
  local target = ESX.GetPlayerFromId(args[1])
  if (admin.getGroup() == "probniadmin" or admin.getGroup() == "admin" or admin.getGroup() == "superadmin" or admin.getGroup() == "skripter" or admin.getGroup() == "direktor" or admin.getGroup() == "suvlasnik" or admin.getGroup() == "vlasnik" ) then 
      if admin.proveriDuznost() == true then
          if target ~= nil then 
            TriggerClientEvent("Sicilia_komande:gotoadmin", admin.source, target.getCoords().x, target.getCoords().y, target.getCoords().z+1.0)
            TriggerClientEvent('chat:addMessage', admin.source, {
              args = {"^1LUDI Roleplay ^1» ", "^0Teleportovani ste do ^1^*" .. GetPlayerName(target.source) .. "^0!"}
            })

            TriggerClientEvent('chat:addMessage', target.source, {
              args = {"^1LUDI Roleplay ^1» ", "^0Do vas se teleportovao ^1^*" .. GetPlayerName(admin.source) .. "^0!"}
            })
            LUDIkomande("LUDI Logovi", GetPlayerName(source) .. " je upisao /goto i teleportovao se do igraca " .. GetPlayerName(args[1]))
          else
            TriggerClientEvent('chatMessage', source, 'LUDI Roleplay >> ', {49, 105, 235 }, 'Taj igrac nije online!') 
          end
      else
        TriggerClientEvent('chat:addMessage', -1, {
          template = '<div style="padding: 1vw; margin: 0.5vw; background-color: rgba(0,0,0 , 0.5); border-radius: 10px;"><i class="far fa-bell"></i> {0}:<br> {1}</div>',
          args = { 'Obavestenje', GetPlayerName(source) .. ' nisi na admin duznosti i ne možeš da koristiš komandu.' }
          })
      end
  else
    TriggerClientEvent('chatMessage', source, '^1GRESKA', {3, 169, 244 }, 'Nemate permisiju da koristite ovu komandu!')
  end
end)

RegisterCommand('bring', function(source, args, rawCommand)
  local admin = ESX.GetPlayerFromId(source)
  local target = ESX.GetPlayerFromId(args[1])
  if (admin.getGroup() == "probniadmin" or admin.getGroup() == "admin" or admin.getGroup() == "superadmin" or admin.getGroup() == "skripter" or admin.getGroup() == "direktor" or admin.getGroup() == "suvlasnik" or admin.getGroup() == "vlasnik") then 
    if admin.proveriDuznost() == true then
    if target ~= nil then 
      TriggerClientEvent("Ludi_komande:gotoadmin", target.source, admin.getCoords().x, admin.getCoords().y, admin.getCoords().z)
      TriggerClientEvent('chat:addMessage', admin.source, {
        args = {"^3LUDI Roleplay ^7» ", "^0Doneli ste ^3^*" .. GetPlayerName(target.source) .. "^0 do vas!"}
      })
      TriggerClientEvent('chat:addMessage', target.source, {
        args = {"^3LUDI Roleplay ^7» ", "^0Donešeni ste od strane ^3^*" .. GetPlayerName(admin.source) .. "!"}
      })
      LUDIkomande("LUDI Logovi", GetPlayerName(source) .. " je upisao /bring i teleportovao se do igraca " .. GetPlayerName(args[1]))
    else
      TriggerClientEvent('chatMessage', source, 'LUDI Roleplay >> ', {49, 105, 235 }, 'Taj igrac nije online!') 
    end
  else
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 1vw; margin: 0.5vw; background-color: rgba(0,0,0 , 0.5); border-radius: 10px;"><i class="far fa-bell"></i> {0}:<br> {1}</div>',
      args = { 'Obavestenje', GetPlayerName(source) .. ' nisi na admin duznosti i ne možeš da koristiš komandu.' }
      })
  end
else 
    TriggerClientEvent('chatMessage', source, 'LUDI Roleplay >> ', {49, 105, 235 }, 'Nemate permisiju da koristite ovu komandu!')
  end
end)

clip = {}

clip.komanda = 'noclip'


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


local grupe = {
    'probniadmin',
    'admin',
    'superadmin',
    'skripter',
    'direktor',
    'suvlasnik',
    'vlasnik',
}


RegisterCommand(clip.komanda, function(source)
    
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local grupe = xPlayer.getGroup()

    if grupe  == 'user' then 
        TriggerClientEvent('esx:showNotification', src, 'Nemas permisije!')
    else
        TriggerClientEvent("noclip:klijent", src)        
    end
    
end, false)

--Eventi
------------------------------------------------------------------------------------------------------------------------------------------
local carrying = {}
--carrying[source] = targetSource, source is carrying targetSource
local carried = {}
--carried[targetSource] = source, targetSource is being carried by source

RegisterServerEvent("CarryPeople:sync")
AddEventHandler("CarryPeople:sync", function(targetSrc)
	local source = source
	local sourcePed = GetPlayerPed(source)
   	local sourceCoords = GetEntityCoords(sourcePed)
	local targetPed = GetPlayerPed(targetSrc)
        local targetCoords = GetEntityCoords(targetPed)
	if #(sourceCoords - targetCoords) <= 3.0 then 
		TriggerClientEvent("CarryPeople:syncTarget", targetSrc, source)
		carrying[source] = targetSrc
		carried[targetSrc] = source
	end
end)

RegisterServerEvent("CarryPeople:stop")
AddEventHandler("CarryPeople:stop", function(targetSrc)
	local source = source

	if carrying[source] then
		TriggerClientEvent("CarryPeople:cl_stop", targetSrc)
		carrying[source] = nil
		carried[targetSrc] = nil
	elseif carried[source] then
		TriggerClientEvent("CarryPeople:cl_stop", carried[source])			
		carrying[carried[source]] = nil
		carried[source] = nil
	end
end)

AddEventHandler('playerDropped', function(reason)
	local source = source
	
	if carrying[source] then
		TriggerClientEvent("CarryPeople:cl_stop", carrying[source])
		carried[carrying[source]] = nil
		carrying[source] = nil
	end

	if carried[source] then
		TriggerClientEvent("CarryPeople:cl_stop", carried[source])
		carrying[carried[source]] = nil
		carried[source] = nil
	end
end)

ESX.RegisterServerCallback("esx_marker:fetchUserRank", function(source, cb)
  local player = ESX.GetPlayerFromId(source)

  if player ~= nil then
      local playerGroup = player.getGroup()

      if playerGroup ~= nil then 
          cb(playerGroup)
      else
          cb("user")
      end
  else
      cb("user")
  end
end)

function LUDIkomande(name,message,color)

	local vreme = os.date('*t')
	local DISCORD_NAME = "LUDI KOMANDE | LOGOVI"
  	local embeds = {
	  	{
		  ["title"] = message,
		  ["type"] = "rich",
		  ["color"] = "8663711",
		  ["footer"] = {
			["text"] = "Vreme: " .. vreme.hour .. ':' .. vreme.min .. ':' .. vreme.sec,
		},
	}
}

  if message == nil or message == '' then return FALSE end
  PerformHttpRequest(Config.webhuk, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end
