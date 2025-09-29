-- animation hack
RegisterCommand("hack", function() -- declare commande
    -- creation des model et anim
    local scannerModel = GetHashKey("ch_prop_fingerprint_scanner_01d")
    local phoneModel = GetHashKey("ch_prop_ch_phone_ing_01a")
    local usbModel = GetHashKey("ch_prop_ch_usb_drive01x")
    RequestModel(scannerModel)
    RequestModel(phoneModel)
    RequestModel(usbModel)

    -- chargement anim keypad
    RequestAnimDict("anim_heist@hs3f@ig1_hack_keypad@male@")
    repeat
        Wait(0)
    until HasModelLoaded(scannerModel) and HasAnimDictLoaded("anim_heist@hs3f@ig1_hack_keypad@male@")

    -- spawn des prop et set de la scene
    local spawnPos = vector3(-1130.50, -1604.65, 4.52) -- TODO : changer spawnPos par celui du prop par target
    local scanner = CreateObject(scannerModel, spawnPos, true, false, false)
    SetEntityHeading(scanner, 33.26)

    repeat
        Wait(0)
    until HasModelLoaded(phoneModel) and HasModelLoaded(usbModel)

    -- creation des props sur le perso
    local phone = CreateObject(phoneModel, GetEntityCoords(PlayerPedId()), true, false, false)
    local usb = CreateObject(usbModel, GetEntityCoords(PlayerPedId()), true, false, false)

    local scene = NetworkCreateSynchronisedScene(GetEntityCoords(scanner), GetEntityRotation(scanner), -- ^
    2, -- Rotation Order
    true, -- Hold last frame
    false, -- Do not loop
    1.0, -- p9
    0.0, -- Starting phase (0.0 meaning we play it from the beginning)
    1.0 -- animSpeed
    )
    local dict = "anim_heist@hs3f@ig1_hack_keypad@male@" -- For readability

    -- ajout des prop a la scene syncro
    NetworkAddPedToSynchronisedScene(PlayerPedId(), scene, dict, "action_var_01", 8.0, 8.0, 0, 0, 1000.0, 0)
    NetworkAddEntityToSynchronisedScene(usb, scene, dict, "action_var_01_ch_prop_ch_usb_drive01x", 8.0, 8.0, 0)
    NetworkAddEntityToSynchronisedScene(phone, scene, dict, "action_var_01_prop_phone_ing", 8.0, 8.0, 0)

    -- Lancement de la scene syncro Part1
    NetworkStartSynchronisedScene(scene)

    Wait(0)
    local localScene = NetworkGetLocalSceneFromNetworkId(scene)
    repeat
        Wait(0)
    until GetSynchronizedScenePhase(localScene) > 0.99

    -- Lancement de la scene part 2

    scene = NetworkCreateSynchronisedScene(GetEntityCoords(scanner), GetEntityRotation(scanner), 2, -- Rotation Order
    true, -- Hold last frame
    false, -- Do not loop
    1.0, -- p9
    0.0, -- Starting phase (0.0 meaning we play it from the beginning)
    1.0 -- animSpeed
    )
    NetworkAddPedToSynchronisedScene(PlayerPedId(), scene, dict, "hack_loop_var_01", 8.0, 8.0, 0, 0, 1000.0, 0)
    NetworkAddEntityToSynchronisedScene(usb, scene, dict, "hack_loop_var_01_ch_prop_ch_usb_drive01x", 8.0, 8.0, 0)
    NetworkAddEntityToSynchronisedScene(phone, scene, dict, "hack_loop_var_01_prop_phone_ing", 8.0, 8.0, 0)

    NetworkStartSynchronisedScene(scene)

    Wait(5000) -- Simulated "hacking" part

    scene = NetworkCreateSynchronisedScene(GetEntityCoords(scanner), GetEntityRotation(scanner), 2, false, false, 1.0,
        0.0, 1.0)

    -- success_react_exit_var_01 
    NetworkAddPedToSynchronisedScene(PlayerPedId(), scene, dict, "success_react_exit_var_01", 8.0, 8.0, 0, 0, 1000.0, 0)
    NetworkAddEntityToSynchronisedScene(usb, scene, dict, "success_react_exit_var_01_ch_prop_ch_usb_drive01x", 8.0, 8.0,
        0)
    NetworkAddEntityToSynchronisedScene(phone, scene, dict, "success_react_exit_var_01_prop_phone_ing", 8.0, 8.0, 0)

    NetworkStartSynchronisedScene(scene)

    Wait(0)
    localScene = NetworkGetLocalSceneFromNetworkId(scene)
    repeat
        Wait(0)
    until not IsSynchronizedSceneRunning(localScene)
    -- Clean up
    DeleteObject(phone)
    DeleteObject(usb)
    DeleteObject(scanner)
end)

-- anime pince

-- anim@scripted@heist@ig4_bolt_cutters@male@ : action_male
-- m23_2_prop_m32_bolt_cutter_01a
-- m23_2_prop_m32_chainlock_01a
RegisterCommand("chain", function() -- declare commande
    local chainModel = GetHashKey("m23_2_prop_m32_chainlock_01a")
    RequestModel(chainModel)
    RequestAnimDict("anim@scripted@heist@ig4_bolt_cutters@male@")
    repeat
        Wait(0)
    until HasModelLoaded(chainModel) and HasAnimDictLoaded("anim@scripted@heist@ig4_bolt_cutters@male@")

    -- Spawn it a bit in the air just to avoid clipping with anything
    local spawnPos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.8, 0.15)
    local chain = CreateObject(chainModel, spawnPos, true, false, false)
    SetEntityHeading(chain, GetEntityHeading(PlayerPedId()))

    -- creation scene

    local scene = NetworkCreateSynchronisedScene(GetEntityCoords(chain), -- FiveM unwraps this to X, Y, Z
    GetEntityRotation(chain), -- ^
    2, -- Rotation Order
    false, -- Hold last frame
    false, -- Do not loop
    1.0, -- p9
    0.0, -- Starting phase (0.0 meaning we play it from the beginning)
    1.0 -- animSpeed
    )

    local cutterModel = GetHashKey("m23_2_prop_m32_bolt_cutter_01a")
    RequestModel(cutterModel)
    repeat
        Wait(0)
    until HasModelLoaded(cutterModel)

    -- Just create these inside the player because they will be immediately attached to the scene.
    local cutter = CreateObject(cutterModel, GetEntityCoords(PlayerPedId()), true, false, false)

    local dict = "anim@scripted@heist@ig4_bolt_cutters@male@"
    local dict2 = "anim@scripted@heist@ig9_control_tower@male@"
    -- missheistdockssetup1ig_5@enter : workers_talking_enter_dockworker1
    NetworkAddPedToSynchronisedScene(PlayerPedId(), scene, dict, "action_rgate", 8.0, 8.0, 0, 0, 1000.0, 0)
    NetworkAddEntityToSynchronisedScene(cutter, scene, dict, "action_male", 8.0, 8.0, 0)

    NetworkStartSynchronisedScene(scene)

    Wait(0)
    local localScene = NetworkGetLocalSceneFromNetworkId(scene)
    repeat
        Wait(0)
    until GetSynchronizedScenePhase(localScene) > 0.

    scene = NetworkCreateSynchronisedScene( -- Repeated code...
    GetEntityCoords(scanner), -- FiveM unwraps this to X, Y, Z
    GetEntityRotation(scanner), -- ^
    2, -- Rotation Order
    true, -- Hold last frame
    false, -- Do not loop
    1.0, -- p9
    0.0, -- Starting phase (0.0 meaning we play it from the beginning)
    1.0 -- animSpeed
    )
    NetworkAddPedToSynchronisedScene(PlayerPedId(), scene, dict2, "loop", 8.0, 8.0, 0, 0, 1000.0, 0)

    NetworkStartSynchronisedScene(scene)

    Wait(5000) -- Simulated "hacking" part

    scene = NetworkCreateSynchronisedScene(GetEntityCoords(scanner), GetEntityRotation(scanner), 2, false, false, 1.0,
        0.0, 1.0)

    -- success_react_exit_var_01 
    NetworkAddPedToSynchronisedScene(PlayerPedId(), scene, dict2, "exit", 8.0, 8.0, 0, 0, 1000.0, 0)

    NetworkStartSynchronisedScene(scene)

    Wait(0)
    localScene = NetworkGetLocalSceneFromNetworkId(scene)
    repeat
        Wait(0)
    until not IsSynchronizedSceneRunning(localScene)
    -- Clean up
    -- DeleteObject(chain)
    -- DeleteObject(cutter)
end)

-- anime placard 
-- anim@scripted@heist@ig9_control_tower@male@ : enter

RegisterCommand("box", function() -- declare commande

    -- chargement du prop + dict animation 
    local boxModel = GetHashKey("m24_1_prop_m41_electricbox_01a")
    RequestModel(boxModel)
    RequestAnimDict("anim@scripted@heist@ig9_control_tower@male@")
    repeat
        Wait(0)
    until HasModelLoaded(boxModel) and HasAnimDictLoaded("anim@scripted@heist@ig9_control_tower@male@")

    -- Spawn it a bit in the air just to avoid clipping with anything
    local spawnPos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.3, 0.01)
    local box = CreateObject(boxModel, spawnPos, true, false, false)
    SetEntityHeading(box, GetEntityHeading(PlayerPedId()))

    local scene = NetworkCreateSynchronisedScene(GetEntityCoords(box), -- FiveM unwraps this to X, Y, Z
    GetEntityRotation(box), -- ^
    2, -- Rotation Order
    true, -- Hold last frame
    false, -- Do not loop
    1.0, -- p9
    0.0, -- Starting phase (0.0 meaning we play it from the beginning)
    1.0 -- animSpeed
    )

    local dict = "anim@scripted@heist@ig9_control_tower@male@" -- For readability
    NetworkAddPedToSynchronisedScene(PlayerPedId(), scene, dict, "enter", 8.0, 8.0, 0, 0, 1000.0, 0)

    NetworkStartSynchronisedScene(scene)

    Wait(0)
    local localScene = NetworkGetLocalSceneFromNetworkId(scene)
    repeat
        Wait(0)
    until GetSynchronizedScenePhase(localScene) > 0.99

    scene = NetworkCreateSynchronisedScene( -- Repeated code...
    GetEntityCoords(box), -- FiveM unwraps this to X, Y, Z
    GetEntityRotation(box), -- ^
    2, -- Rotation Order
    true, -- Hold last frame
    false, -- Do not loop
    1.0, -- p9
    0.0, -- Starting phase (0.0 meaning we play it from the beginning)
    1.0 -- animSpeed
    )
    NetworkAddPedToSynchronisedScene(PlayerPedId(), scene, dict, "loop", 8.0, 8.0, 0, 0, 1000.0, 0)

    NetworkStartSynchronisedScene(scene)

    Wait(5000) -- Simulated "hacking" part

    scene = NetworkCreateSynchronisedScene(GetEntityCoords(box), GetEntityRotation(box), 2, false, false, 1.0, 0.0, 1.0)

    -- success_react_exit_var_01 
    NetworkAddPedToSynchronisedScene(PlayerPedId(), scene, dict, "exit", 8.0, 8.0, 0, 0, 1000.0, 0)

    NetworkStartSynchronisedScene(scene)

    Wait(0)
    localScene = NetworkGetLocalSceneFromNetworkId(scene)
    repeat
        Wait(0)
    until not IsSynchronizedSceneRunning(localScene)
    -- Clean up
    DeleteObject(box)

end)
