-- Commande hack
RegisterCommand("hack", function()
    -- Création des modèles et chargement des animations
    local scannerModel = GetHashKey("ch_prop_fingerprint_scanner_01d")
    local phoneModel = GetHashKey("ch_prop_ch_phone_ing_01a")
    local usbModel = GetHashKey("ch_prop_ch_usb_drive01x")
    local dict = "anim_heist@hs3f@ig1_hack_keypad@male@"
    local playerId = PlayerPedId()
    local playerPos = GetEntityCoords(playerId)
    RequestModel(scannerModel)
    RequestModel(phoneModel)
    RequestModel(usbModel)

    -- Chargement de l'animation du keypad
    RequestAnimDict(dict)
    repeat
        Wait(0)
    until HasModelLoaded(scannerModel) and HasAnimDictLoaded(dict)

    -- Spawn des props et configuration de la scène
    local spawnPos = vector3(-1130.50, -1604.65, 4.52) -- À adapter 
    local scanner = CreateObject(scannerModel, spawnPos, true, false, false)
    SetEntityHeading(scanner, 33.26) -- À adapter

    repeat
        Wait(0)
    until HasModelLoaded(phoneModel) and HasModelLoaded(usbModel)

    -- Création des props sur le joueur
    local phone = CreateObject(phoneModel, playerPos, true, false, false)
    local usb = CreateObject(usbModel, playerPos, true, false, false)

    local scene = NetworkCreateSynchronisedScene(GetEntityCoords(scanner), GetEntityRotation(scanner), 2, true, false,
        1.0, 0.0, 1.0)

    -- Ajout des props à la scène 
    NetworkAddPedToSynchronisedScene(playerId, scene, dict, "action_var_01", 8.0, 8.0, 0, 0, 1000.0, 0)
    NetworkAddEntityToSynchronisedScene(usb, scene, dict, "action_var_01_ch_prop_ch_usb_drive01x", 8.0, 8.0, 0)
    NetworkAddEntityToSynchronisedScene(phone, scene, dict, "action_var_01_prop_phone_ing", 8.0, 8.0, 0)

    -- Démarrage de la première partie de la scène 
    NetworkStartSynchronisedScene(scene)

    Wait(0)
    local localScene = NetworkGetLocalSceneFromNetworkId(scene)
    repeat
        Wait(0)
    until GetSynchronizedScenePhase(localScene) > 0.99

    -- Démarrage de la deuxième partie de la scène
    scene = NetworkCreateSynchronisedScene(GetEntityCoords(scanner), GetEntityRotation(scanner), 2, true, false, 1.0,
        0.0, 1.0)
    NetworkAddPedToSynchronisedScene(playerId, scene, dict, "hack_loop_var_01", 8.0, 8.0, 0, 0, 1000.0, 0)
    NetworkAddEntityToSynchronisedScene(usb, scene, dict, "hack_loop_var_01_ch_prop_ch_usb_drive01x", 8.0, 8.0, 0)
    NetworkAddEntityToSynchronisedScene(phone, scene, dict, "hack_loop_var_01_prop_phone_ing", 8.0, 8.0, 0)

    NetworkStartSynchronisedScene(scene)

    Wait(5000) -- Simulation du sur les animations loop

    scene = NetworkCreateSynchronisedScene(GetEntityCoords(scanner), GetEntityRotation(scanner), 2, false, false, 1.0,
        0.0, 1.0)

    -- Animation de sortie après succès
    NetworkAddPedToSynchronisedScene(playerId, scene, dict, "success_react_exit_var_01", 8.0, 8.0, 0, 0, 1000.0, 0)
    NetworkAddEntityToSynchronisedScene(usb, scene, dict, "success_react_exit_var_01_ch_prop_ch_usb_drive01x", 8.0, 8.0,
        0)
    NetworkAddEntityToSynchronisedScene(phone, scene, dict, "success_react_exit_var_01_prop_phone_ing", 8.0, 8.0, 0)

    NetworkStartSynchronisedScene(scene)

    Wait(0)
    localScene = NetworkGetLocalSceneFromNetworkId(scene)
    repeat
        Wait(0)
    until not IsSynchronizedSceneRunning(localScene)
    -- Nettoyage des objets
    DeleteObject(phone)
    DeleteObject(usb)
    DeleteObject(scanner)
end)

-- Commande chain
RegisterCommand("chain", function()
    -- Création des modèles et chargement des animations
    local chainModel = GetHashKey("h4_prop_h4_chain_lock_01a")
    local cutterModel = GetHashKey("m23_2_prop_m32_bolt_cutter_01a")
    local dict = "anim@scripted@heist@ig4_bolt_cutters@male@"
    local playerId = PlayerPedId()
    local playerPos = GetEntityCoords(playerId)
    RequestModel(chainModel)

    -- Chargement de l'animation
    RequestAnimDict(dict)

    repeat
        Wait(0)
    until HasModelLoaded(chainModel) and HasAnimDictLoaded(dict)

    -- Spawn des props et configuration de la scène
    local spawnPos = vector3(-1129.62, -1588.75, 4.52) -- À adapter
    local chain = CreateObject(chainModel, spawnPos, true, false, false)
    SetEntityHeading(chain, 215.76) -- À adapter

    -- Création de la scène synchronisée 
    local scene = NetworkCreateSynchronisedScene(GetEntityCoords(chain), GetEntityRotation(chain), 2, false, false, 1.0,
        0.0, 1.0)

    RequestModel(cutterModel)
    repeat
        Wait(0)
    until HasModelLoaded(cutterModel)

    -- Création de la pince coupante sur le joueur
    local cutter = CreateObject(cutterModel, GetEntityCoords(playerId), true, false, false)

    -- Ajout du joueur et des props à la scène synchronisée
    NetworkAddPedToSynchronisedScene(playerId, scene, dict, "action_male", 8.0, 8.0, 0, 0, 1000.0, 0)
    NetworkAddEntityToSynchronisedScene(cutter, scene, dict, "action_cutter", 8.0, 8.0, 0)
    NetworkAddEntityToSynchronisedScene(chain, scene, dict, "action_chain", 8.0, 8.0, 0)

    -- Démarrage de la scène synchronisée
    NetworkStartSynchronisedScene(scene)
    Wait(0)
    local localScene = NetworkGetLocalSceneFromNetworkId(scene)

    repeat
        Wait(0)
    until not IsSynchronizedSceneRunning(localScene)

    -- Nettoyage des objets 
    DeleteObject(chain)
    DeleteObject(cutter)
end)

-- anime placard 
-- anim@scripted@heist@ig9_control_tower@male@ : enter

RegisterCommand("box", function() -- declare commande

    -- chargement prop + dict animation 
    local boxModel = GetHashKey("h4_prop_h4_elecbox_01a")
    local playerId = PlayerPedId()
    local playerPos = GetEntityCoords(playerId)
    local dict = "anim@scripted@heist@ig9_control_tower@male@"
    RequestModel(boxModel)
    RequestAnimDict(dict)
    repeat
        Wait(0)
    until HasModelLoaded(boxModel) and HasAnimDictLoaded(dict)

    
    local spawnPos = vector3(-1127.31, -1602.83, 3.4) -- À adapter
    local box = CreateObject(boxModel, spawnPos, true, false, false)
    SetEntityHeading(box, 33.26) -- À adapter

    local scene =
        NetworkCreateSynchronisedScene(GetEntityCoords(box), GetEntityRotation(box), 2, true, -- Hold last frame
        false, -- Do not loop
        1.0, 0.0, 1.0)

    NetworkAddPedToSynchronisedScene(playerId, scene, dict, "enter", 8.0, 8.0, 0, 0, 1000.0, 0)
    NetworkAddEntityToSynchronisedScene(box, scene, dict, "enter_electric_box", 8.0, 8.0, 0)

    NetworkStartSynchronisedScene(scene)

    Wait(0)
    local localScene = NetworkGetLocalSceneFromNetworkId(scene)
    repeat
        Wait(0)
    until GetSynchronizedScenePhase(localScene) > 0.99

    scene = NetworkCreateSynchronisedScene( 
    GetEntityCoords(box), 
    GetEntityRotation(box), 
    2, 
    true, -- Hold last frame
    false, -- Do not loop
    1.0, 
    0.0,
    1.0 
    )
    NetworkAddPedToSynchronisedScene(playerId, scene, dict, "loop", 8.0, 8.0, 0, 0, 1000.0, 0)
    NetworkAddEntityToSynchronisedScene(box, scene, dict, "loop_electric_box", 8.0, 8.0, 0)

    NetworkStartSynchronisedScene(scene)

    Wait(5000) 

    scene = NetworkCreateSynchronisedScene(GetEntityCoords(box), GetEntityRotation(box), 2, false, false, 1.0, 0.0, 1.0)

    NetworkAddPedToSynchronisedScene(playerId, scene, dict, "exit", 8.0, 8.0, 0, 0, 1000.0, 0)
    NetworkAddEntityToSynchronisedScene(box, scene, dict, "exit_electric_box", 8.0, 8.0, 0)


    NetworkStartSynchronisedScene(scene)

    Wait(0)
    localScene = NetworkGetLocalSceneFromNetworkId(scene)
    repeat
        Wait(0)
    until not IsSynchronizedSceneRunning(localScene)
    -- Clean up
    DeleteObject(box)

end)