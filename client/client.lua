ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--KOMANDE
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
  end)
  
  RegisterCommand("fixgui", function()
    ESX.UI.Menu.CloseAll()
  end)
  -- Goto
  
  RegisterNetEvent('Ludi_komande:gotoadmin')
  AddEventHandler('Ludi_komande:gotoadmin', function(x, y, z)
    SetEntityCoords(PlayerPedId(), x, y, z)
  end)

  -- Marker
  function StaviOdelo()
    local playerPed = PlayerPedId()

    TriggerEvent('skinchanger:getSkin', function(skin)
      TriggerEvent("skinchanger:loadClothes", skin, Config.male)
    end)
  end
  RegisterNetEvent("staviOdelce")
  AddEventHandler("staviOdelce", function()
      local playerPed = PlayerPedId()
      StaviOdelo()
  end)
  
  RegisterNetEvent("skiniOdelce")
  AddEventHandler("skiniOdelce", function()
      local playerPed = PlayerPedId()
      ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        TriggerEvent('skinchanger:loadSkin', skin)
        TriggerEvent('esx:restoreLoadout')
    end)
  end)


-- Ruke u vis
handsup = false

RegisterKeyMapping('handsup', 'Hands Up', 'keyboard', 'x')

RegisterCommand('handsup', function()
  local dict = "missminuteman_1ig_2"
  local igrac = PlayerPedId()
  RequestAnimDict(dict)
  while not HasAnimDictLoaded(dict) do
    Citizen.Wait(100)
  end
  
  if not IsEntityDead(igrac) and not handsup then
    TaskPlayAnim(igrac, dict, "handsup_enter", 8.0, 8.0, -1, 50, 0, false, false)
    handsup = true
  elseif handsup then
    ClearPedTasks(igrac)
    handsup = false
  end 
end, false)

--cucanje

RegisterKeyMapping('+cucanje', 'Cucanje', 'keyboard', 'LCONTROL')

CreateThread(function()
	RequestAnimSet("move_ped_crouched")
    while (not HasAnimSetLoaded("move_ped_crouched")) do Wait(100) end -- requestuj samo jednom animaciju a ne 100x puta...
end)

local cucnuo = false
RegisterCommand('+cucanje', function()
    local igraciliosobaxd = PlayerPedId()
    if not cucnuo and not IsPedFalling(igraciliosobaxd) and not IsEntityDead(igraciliosobaxd) and not IsPedUsingAnyScenario(igraciliosobaxd) and not IsEntityPlayingAnim(igraciliosobaxd,'random@mugging3', 'handsup_standing_base', 3) and DoesEntityExist(igraciliosobaxd) and not IsPedInAnyVehicle(igraciliosobaxd) and not IsPauseMenuActive() then
        cucnuo = true
        SetPedMovementClipset(igraciliosobaxd, "move_ped_crouched", 0.85)
    else
        cucnuo = false
        ResetPedMovementClipset(igraciliosobaxd, 0)
    end
end, false)

RegisterCommand('-cucanje', function()
	---prazno mora biti jebemu boga i registerkeymappingu
end, false)

---MOJ ID
RegisterCommand('mojid', function()
  Esx.ShowNotification("Vaš ID je:" .. GetPlayerServerId(PlayerId()))
end)

---MOJ ID
RegisterCommand('discord', function()
  Esx.ShowNotification("Naš discord server je:discord link")
end)

-------------------------------------------------------------------------
RegisterNetEvent("Ludi_core:delallveh")
AddEventHandler("Ludi_core:delallveh", function ()
    for vehicle in EnumerateVehicles() do
        if (not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1))) then 
            SetVehicleHasBeenOwnedByPlayer(vehicle, false) 
            SetEntityAsMissionEntity(vehicle, false, false) 
            DeleteVehicle(vehicle)
            if (DoesEntityExist(vehicle)) then 
                DeleteVehicle(vehicle) 
            end
        end
    end
end)

local entityEnumerator = {
    __gc = function(enum)
      if enum.destructor and enum.handle then
        enum.destructor(enum.handle)
      end
      enum.destructor = nil
      enum.handle = nil
    end
  }
  
  local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
      local iter, id = initFunc()
      if not id or id == 0 then
        disposeFunc(iter)
        return
      end
      
      local enum = {handle = iter, destructor = disposeFunc}
      setmetatable(enum, entityEnumerator)
      
      local next = true
      repeat
        coroutine.yield(id)
        next, id = moveFunc(iter)
      until not next
      
      enum.destructor, enum.handle = nil, nil
      disposeFunc(iter)
    end)
  end
  
  function EnumerateObjects()
    return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
  end
  
  function EnumeratePeds()
    return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
  end
  
  function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
  end
  
  function EnumeratePickups()
    return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
  end

------------------------------------------------------------------------
--LETENJE
Citizen.CreateThread(function() while ESX == nil do TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) Citizen.Wait(0) end end)

config = {
    controls = {
        -- [[Controls, list can be found here : https://docs.fivem.net/game-references/controls/]]
        openKey = 288121, -- [[F2]]
        goUp = 85, -- [[Q]]
        goDown = 48, -- [[Z]]
        turnLeft = 34, -- [[A]]
        turnRight = 35, -- [[D]]
        goForward = 32,  -- [[W]]
        goBackward = 33, -- [[S]]
        changeSpeed = 21, -- [[L-Shift]]
    },

    speeds = {
        -- [[If you wish to change the speeds or labels there are associated with then here is the place.]]
        { label = "Very Slow", speed = 0},
        { label = "Slow", speed = 0.5},
        { label = "Normal", speed = 2},
        { label = "Fast", speed = 4},
        { label = "Very Fast", speed = 6},
        { label = "Extremely Fast", speed = 10},
        { label = "Extremely Fast v2.0", speed = 20},
        { label = "Max Speed", speed = 25}
    },

    offsets = {
        y = 0.5, -- [[How much distance you move forward and backward while the respective button is pressed]]
        z = 0.2, -- [[How much distance you move upward and downward while the respective button is pressed]]
        h = 3, -- [[How much you rotate. ]]
    },

    -- [[Background colour of the buttons. (It may be the standard black on first opening, just re-opening.)]]
    bgR = 0, -- [[Red]]
    bgG = 0, -- [[Green]]
    bgB = 0, -- [[Blue]]
    bgA = 80, -- [[Alpha]]
}

--==--==--==--
-- End Of Config
--==--==--==--

function ButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

function Button(ControlButton)
    N_0xe83a3e3557a56640(ControlButton)
end

function setupScaleform(scaleform)

    local scaleform = RequestScaleformMovie(scaleform)

    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(1)
    end

    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(4)
    Button(GetControlInstructionalButton(2, config.controls.goUp, true))
    ButtonMessage("Gore")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(3)
    Button(GetControlInstructionalButton(2, config.controls.goDown, true))
    ButtonMessage("Dole")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(2)
    Button(GetControlInstructionalButton(1, config.controls.turnRight, true))
    Button(GetControlInstructionalButton(1, config.controls.turnLeft, true))
    ButtonMessage("Levo/Desno")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(1)
    Button(GetControlInstructionalButton(1, config.controls.goBackward, true))
    Button(GetControlInstructionalButton(1, config.controls.goForward, true))
    ButtonMessage("Napred/Nazad")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(0)
    Button(GetControlInstructionalButton(2, config.controls.changeSpeed, true))
    ButtonMessage("Brzina ("..config.speeds[index].label..")")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(config.bgR)
    PushScaleformMovieFunctionParameterInt(config.bgG)
    PushScaleformMovieFunctionParameterInt(config.bgB)
    PushScaleformMovieFunctionParameterInt(config.bgA)
    PopScaleformMovieFunctionVoid()

    return scaleform
end

function DisableControls()
    DisableControlAction(0, 30, true)
    DisableControlAction(0, 31, true)
    DisableControlAction(0, 33, true)
    DisableControlAction(0, 34, true)
    DisableControlAction(0, 35, true)
    DisableControlAction(0, 266, true)
    DisableControlAction(0, 267, true)
    DisableControlAction(0, 268, true)
    DisableControlAction(0, 269, true)
    DisableControlAction(0, 44, true)
    DisableControlAction(0, 20, true)
    DisableControlAction(0, 74, true)
end



noclipActive = false -- [[Wouldn't touch this.]]

index = 1 -- [[Used to determine the index of the speeds table.]]

Citizen.CreateThread(function()

    buttons = setupScaleform("instructional_buttons")

    currentSpeed = config.speeds[index].speed

    while true do
        Citizen.Wait(1)

        if IsControlJustPressed(0, 1000) then
            noclipActive = not noclipActive

            if IsPedInAnyVehicle(PlayerPedId(), false) then
                noclipEntity = GetVehiclePedIsIn(PlayerPedId(), false)
            else
                noclipEntity = PlayerPedId()
            end

            SetEntityCollision(noclipEntity, not noclipActive, not noclipActive)
            FreezeEntityPosition(noclipEntity, noclipActive)
            SetEntityInvincible(noclipEntity, noclipActive)
            SetVehicleRadioEnabled(noclipEntity, not noclipActive) -- [[Stop radio from appearing when going upwards.]]
        end

        if noclipActive then
            DrawScaleformMovieFullscreen(buttons)

            local yoff = 0.0
            local zoff = 0.0

            if IsControlJustPressed(1, config.controls.changeSpeed) then
                if index ~= 8 then
                    index = index+1
                    currentSpeed = config.speeds[index].speed
                else
                    currentSpeed = config.speeds[1].speed
                    index = 1
                end
                setupScaleform("instructional_buttons")
            end
				

			if IsDisabledControlPressed(0, config.controls.goForward) then
                yoff = config.offsets.y
			end
			
            if IsDisabledControlPressed(0, config.controls.goBackward) then
                yoff = -config.offsets.y
			end
			
            if IsDisabledControlPressed(0, config.controls.turnLeft) then
                SetEntityHeading(noclipEntity, GetEntityHeading(noclipEntity)+config.offsets.h)
			end
			
            if IsDisabledControlPressed(0, config.controls.turnRight) then
                SetEntityHeading(noclipEntity, GetEntityHeading(noclipEntity)-config.offsets.h)
			end
			
            if IsDisabledControlPressed(0, config.controls.goUp) then
                zoff = config.offsets.z
			end
			
            if IsDisabledControlPressed(0, config.controls.goDown) then
                zoff = -config.offsets.z
			end
			
            local newPos = GetOffsetFromEntityInWorldCoords(noclipEntity, 0.0, yoff * (currentSpeed + 0.3), zoff * (currentSpeed + 0.3))
            local heading = GetEntityHeading(noclipEntity)
            SetEntityVelocity(noclipEntity, 0.0, 0.0, 0.0)
            SetEntityRotation(noclipEntity, 0.0, 0.0, 0.0, 0, false)
            SetEntityHeading(noclipEntity, heading)
            SetEntityCoordsNoOffset(noclipEntity, newPos.x, newPos.y, newPos.z, noclipActive, noclipActive, noclipActive)
        end
    end
end)

-- LAZIC OD 0 (NIJE TESKO, ALI SAMO DA SE ZNA xD) --



RegisterNetEvent("noclip:klijent")
AddEventHandler("noclip:klijent", function()
    noclipActive = not noclipActive

    if IsPedInAnyVehicle(PlayerPedId(), false) then
        noclipEntity = GetVehiclePedIsIn(PlayerPedId(), false)
    else
        noclipEntity = PlayerPedId()
    end

    SetEntityCollision(noclipEntity, not noclipActive, not noclipActive)
    FreezeEntityPosition(noclipEntity, noclipActive)
    SetEntityInvincible(noclipEntity, noclipActive)
    SetVehicleRadioEnabled(noclipEntity, not noclipActive) -- [[Stop radio from appearing when going upwards.]]

    if not noclipActive then
        SetEntityInvincible(PlayerPedId(), false)
        SetPlayerInvincible(PlayerId(), false)
    end

end)



RegisterCommand("tpm", function(source)
    TeleportToWaypoint()
  end)
  
  TeleportToWaypoint = function()
    ESX.TriggerServerCallback("esx_marker:fetchUserRank", function(playerRank)
        if playerRank == "probniadmin" or playerRank == "admin" or playerRank == "superadmin" or playerRank == "skripter" or playerRank == "direktor" or playerRank == "suvlasnik" or playerRank == "vlasnik" then
            local WaypointHandle = GetFirstBlipInfoId(8)
  
            if DoesBlipExist(WaypointHandle) then
                local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)
  
                for height = 1, 1000 do
                    SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
  
                    local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)
  
                    if foundGround then
                        SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
  
                        break
                    end
  
                    Citizen.Wait(5)
                end
                Esx.ShowNotification("Teleportirani ste do lokacije!")
            else
              Esx.ShowNotification("Moras prvo oznaciti na GPS-u marker!")
            end
        else
          Esx.ShowNotification("Nemas dozvolu za tu komandu!")
        end
    end)
  end
  
  RegisterNetEvent("esx_admin:killPlayer")
  AddEventHandler("esx_admin:killPlayer", function()
    SetEntityHealth(PlayerPedId(), 0)
  end)

-----------------------------------------------------------------------------------------------------
local carry = {
	InProgress = false,
	targetSrc = -1,
	type = "",
	personCarrying = {
		animDict = "missfinale_c2mcs_1",
		anim = "fin_c2_mcs_1_camman",
		flag = 49,
	},
	personCarried = {
		animDict = "nm",
		anim = "firemans_carry",
		attachX = 0.27,
		attachY = 0.15,
		attachZ = 0.63,
		flag = 33,
	}
}

local function drawNativeNotification(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

local function GetClosestPlayer(radius)
    local players = GetActivePlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    for _,playerId in ipairs(players) do
        local targetPed = GetPlayerPed(playerId)
        if targetPed ~= playerPed then
            local targetCoords = GetEntityCoords(targetPed)
            local distance = #(targetCoords-playerCoords)
            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = playerId
                closestDistance = distance
            end
        end
    end
	if closestDistance ~= -1 and closestDistance <= radius then
		return closestPlayer
	else
		return nil
	end
end

local function ensureAnimDict(animDict)
    if not HasAnimDictLoaded(animDict) then
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Wait(0)
        end        
    end
    return animDict
end

RegisterCommand("nosi",function(source, args)
	if not carry.InProgress then
		local closestPlayer = GetClosestPlayer(3)
		if closestPlayer then
			local targetSrc = GetPlayerServerId(closestPlayer)
			if targetSrc ~= -1 then
				carry.InProgress = true
				carry.targetSrc = targetSrc
				TriggerServerEvent("CarryPeople:sync",targetSrc)
				ensureAnimDict(carry.personCarrying.animDict)
				carry.type = "carrying"
			else
				drawNativeNotification("~r~Nemate koga da nosite!")
			end
		else
			drawNativeNotification("~r~Nemate koga da nosite!")
		end
	else
		carry.InProgress = false
		ClearPedSecondaryTask(PlayerPedId())
		DetachEntity(PlayerPedId(), true, false)
		TriggerServerEvent("CarryPeople:stop",carry.targetSrc)
		carry.targetSrc = 0
	end
end,false)

RegisterNetEvent("CarryPeople:syncTarget")
AddEventHandler("CarryPeople:syncTarget", function(targetSrc)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(targetSrc))
	carry.InProgress = true
	ensureAnimDict(carry.personCarried.animDict)
	AttachEntityToEntity(PlayerPedId(), targetPed, 0, carry.personCarried.attachX, carry.personCarried.attachY, carry.personCarried.attachZ, 0.5, 0.5, 180, false, false, false, false, 2, false)
	carry.type = "beingcarried"
end)

RegisterNetEvent("CarryPeople:cl_stop")
AddEventHandler("CarryPeople:cl_stop", function()
	carry.InProgress = false
	ClearPedSecondaryTask(PlayerPedId())
	DetachEntity(PlayerPedId(), true, false)
end)

Citizen.CreateThread(function()
	while true do
		if carry.InProgress then
			if carry.type == "beingcarried" then
				if not IsEntityPlayingAnim(PlayerPedId(), carry.personCarried.animDict, carry.personCarried.anim, 3) then
					TaskPlayAnim(PlayerPedId(), carry.personCarried.animDict, carry.personCarried.anim, 8.0, -8.0, 100000, carry.personCarried.flag, 0, false, false, false)
				end
			elseif carry.type == "carrying" then
				if not IsEntityPlayingAnim(PlayerPedId(), carry.personCarrying.animDict, carry.personCarrying.anim, 3) then
					TaskPlayAnim(PlayerPedId(), carry.personCarrying.animDict, carry.personCarrying.anim, 8.0, -8.0, 100000, carry.personCarrying.flag, 0, false, false, false)
				end
			end
		end
		Wait(0)
	end
end)
-------------------------------------------------------------------------------------------------------

-- Admin ID

local idovi = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local idovi = false

local disPlayerNames = 25

-- RegisterCommand("id", function()
RegisterNetEvent("admin:id")
AddEventHandler("admin:id", function()
  ESX.TriggerServerCallback("esx_marker:fetchUserRank", function(playerRank)
    if playerRank == "helper" or playerRank == "logoviadmin" or playerRank == "admin" or playerRank == "admin2" or playerRank == "admin3" or playerRank == "superadmin" or
  playerRank == "roleplayadmin" or playerRank == "premiumadmin" or playerRank == "vodjapromotera" or playerRank == "vodjaorg" or playerRank == "headstaff" or 
  playerRank == "menadzer" or playerRank == "menadjer" or playerRank == "addiction" or playerRank == "veselinovic" or playerRank == "straja" or playerRank == "direktor" or playerRank == "asistent" or playerRank == "skripter" or playerRank == "suvlasnik" or playerRank == "vlasnik" or xPlayer.getGroup() == "vlasnica" then


        if not idovi then
          Esx.ShowNotification("Ukljucili ste ID-eve!")
          idovi = true
        else
          idovi = false
          Esx.ShowNotification("Iskljucili ste ID-eve!")
        end
      else
        Esx.ShowNotification("Nemate dozvolu!")
      end
  end)
end)
playerDistances = {}

Citizen.CreateThread(function()
    Wait(100)
    while true do
    Citizen.Wait(0)
      if not idovi then
        Citizen.Wait(2000)
      else
        for _, player in ipairs(GetActivePlayers()) do
          local ped = GetPlayerPed(player)
          if GetPlayerPed(player) ~= PlayerPedId() then
            if playerDistances[player] ~= nil and playerDistances[player] < disPlayerNames then
              x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(player), true))
              if not NetworkIsPlayerTalking(player) then
                DrawText3D(x2, y2, z2+0.94, '~b~' .. GetPlayerServerId(player) .. ' ~c~| ~w~' .. GetPlayerName(player))
              else
                DrawText3D(x2, y2, z2+0.94, '~g~' .. GetPlayerServerId(player) .. ' ~c~| ~w~' .. GetPlayerName(player))
              end
            end
          end
        end
      end
    end
end)


Citizen.CreateThread(function()
    while true do
        for _, player in ipairs(GetActivePlayers()) do
            if GetPlayerPed(player) ~= PlayerPedId() then
                x1, y1, z1 = table.unpack(GetEntityCoords(PlayerPedId(), true))
                x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(player), true))
                distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))
                playerDistances[player] = distance
            end
        end
        Citizen.Wait(1000)
    end
end)

function DrawText3D(x,y,z, text) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*5
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 0.22*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

-- IDGUN -- 

-- (Re)set locals at start
local infoOn = false    -- Disables the info on restart.
local coordsText = ""   -- Removes any text the coords had stored.
local headingText = ""  -- Removes any text the heading had stored.
local modelText = ""    -- Removes any text the model had stored.

-- Thread that makes everything happen.
Citizen.CreateThread(function()                             -- Create the thread.
    while true do                                           -- Loop it infinitely.
        local pause = 250                                   -- If infos are off, set loop to every 250ms. Eats less resources.
        if infoOn then                                      -- If the info is on then...
            pause = 5                                       -- Only loop every 5ms (equivalent of 200fps).
            local player = GetPlayerPed(-1)                 -- Get the player.
            if IsPlayerFreeAiming(PlayerId()) then          -- If the player is free-aiming (update texts)...
                local entity = getEntity(PlayerId())        -- Get what the player is aiming at. This isn't actually the function, that's below the thread.
                local coords = GetEntityCoords(entity)      -- Get the coordinates of the object.
                local heading = GetEntityHeading(entity)    -- Get the heading of the object.
                local model = GetEntityModel(entity)        -- Get the hash of the object.
                coordsText = coords                         -- Set the coordsText local.
                headingText = heading                       -- Set the headingText local.
                modelText = model                           -- Set the modelText local.
            end                                             -- End (player is not freeaiming: stop updating texts).
            DrawInfos("Coordinates: " .. coordsText .. "\nHeading: " .. headingText .. "\nHash: " .. modelText)     -- Draw the text on screen
        end                                                 -- Info is off, don't need to do anything.
        Citizen.Wait(pause)                                 -- Now wait the specified time.
    end                                                     -- End (stop looping).
end)                                                        -- Endind the entire thread here.

-- Function to get the object the player is actually aiming at.
function getEntity(player)                                          -- Create this function.
    local result, entity = GetEntityPlayerIsFreeAimingAt(player)    -- This time get the entity the player is aiming at.
    return entity                                                   -- Returns what the player is aiming at.
end                                                                 -- Ends the function.

-- Function to draw the text.
function DrawInfos(text)
    SetTextColour(255, 255, 255, 255)   -- Color
    SetTextFont(1)                      -- Font
    SetTextScale(0.4, 0.4)              -- Scale
    SetTextWrap(0.0, 1.0)               -- Wrap the text
    SetTextCentre(false)                -- Align to center(?)
    SetTextDropshadow(0, 0, 0, 0, 255)  -- Shadow. Distance, R, G, B, Alpha.
    SetTextEdge(50, 0, 0, 0, 255)       -- Edge. Width, R, G, B, Alpha.
    SetTextOutline()                    -- Necessary to give it an outline.
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(0.015, 0.71)               -- Position
end

-- Creating the function to toggle the info.
ToggleInfos = function()                -- "ToggleInfos" is a function
    infoOn = not infoOn                 -- Switch them around
end                                     -- Ending the function here.

-- Creating the command.
RegisterCommand("idgun", function()     -- Listen for this command.
    ToggleInfos()                       -- Heard it! Let's toggle the function above.
end)   

   -- Lokacija

   local coordsVisible = false

   function DrawGenericText(text)
     SetTextColour(186, 186, 186, 255)
     SetTextFont(7)
     SetTextScale(0.378, 0.378)
     SetTextWrap(0.0, 1.0)
     SetTextCentre(false)
     SetTextDropshadow(0, 0, 0, 0, 255)
     SetTextEdge(1, 0, 0, 0, 205)
     SetTextEntry("STRING")
     AddTextComponentString(text)
     DrawText(0.40, 0.20)
   end
   
   Citizen.CreateThread(function()
       while true do 
       local sleepThread = 250
       
       if coordsVisible then
         sleepThread = 5
   
         local playerPed = PlayerPedId()
         local playerX, playerY, playerZ = table.unpack(GetEntityCoords(playerPed))
         local playerH = GetEntityHeading(playerPed)
   
         DrawGenericText(("~b~X~w~: %s ~b~Y~w~: %s ~b~Z~w~: %s ~b~H~w~: %s"):format(FormatCoord(playerX), FormatCoord(playerY), FormatCoord(playerZ), FormatCoord(playerH)))
       end
   
       Citizen.Wait(sleepThread)
     end
   end)
   
   FormatCoord = function(coord)
     if coord == nil then
       return "unknown"
     end
   
     return tonumber(string.format("%.2f", coord))
   end
   
   ToggleCoords = function()
     coordsVisible = not coordsVisible
   end
   
   RegisterCommand("lokacija", function(target)
       ToggleCoords()
   end)

   UnosTastatura = function(TextEntry, ExampleText, MaxStringLength)
    AddTextEntry("FMMC_KEY_TIP1", TextEntry .. ":")
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        DisableAllControlActions(0)
        if IsDisabledControlPressed(0, 322) then return "" end
        Wait(0)
    end
    if (GetOnscreenKeyboardResult()) then
      print(GetOnscreenKeyboardResult())
      return GetOnscreenKeyboardResult()
    end
end