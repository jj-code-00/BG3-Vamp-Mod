PersistentVars = {}

Ext.Osiris.RegisterListener("LongRestFinished", 0, "after", function ()
    -- Ext.Utils.Print("Rested")
    local character = Osi.GetHostCharacter()
    local characterHasBloodDrain = Osi.HasPassive(character,"Vamp_BloodPoolDrain")
    if characterHasBloodDrain then
        Ext.Utils.Print("Drain Time")
        --local amount = Osi.GetActionResourceValuePersonal(character, "Vamp_BloodPool", 0)
        Ext.Utils.Print("Drain ", PersistentVars['Blood'])
        local drainedBlood = PersistentVars['Blood'] - 1
        if drainedBlood < 0 then
            drainedBlood = 0
        end
        RestoreBlood(character,drainedBlood)
    end
end)

function RestoreBlood(character,amount)
    local action = {
        [0] = function () Ext.Utils.Print("Already Empty") end,
        [1] = function () Osi.ApplyStatus(character, "Vamp_RestoreBloodPool1", 1, 100,character) end,
        [2] = function () Osi.ApplyStatus(character, "Vamp_RestoreBloodPool2", 1, 100,character) end,
        [3] = function () Osi.ApplyStatus(character, "Vamp_RestoreBloodPool3", 1, 100,character) end,
        [4] = function () Osi.ApplyStatus(character, "Vamp_RestoreBloodPool4", 1, 100,character) end,
        [5] = function () Osi.ApplyStatus(character, "Vamp_RestoreBloodPool5", 1, 100,character) end,
        [6] = function () Osi.ApplyStatus(character, "Vamp_RestoreBloodPool6", 1, 100,character) end,
        [7] = function () Osi.ApplyStatus(character, "Vamp_RestoreBloodPool7", 1, 100,character) end,
        [8] = function () Osi.ApplyStatus(character, "Vamp_RestoreBloodPool8", 1, 100,character) end,
        [9] = function () Osi.ApplyStatus(character, "Vamp_RestoreBloodPool9", 1, 100,character) end,
        [10] = function () Osi.ApplyStatus(character, "Vamp_RestoreBloodPool10", 1, 100,character) end,
        [11] = function () Osi.ApplyStatus(character, "Vamp_RestoreBloodPool11", 1, 100,character) end,
        [12] = function () Osi.ApplyStatus(character, "Vamp_RestoreBloodPool12", 1, 100,character) end,
        [13] = function () Osi.ApplyStatus(character, "Vamp_RestoreBloodPool13", 1, 100,character) end,
        [14] = function () Osi.ApplyStatus(character, "Vamp_RestoreBloodPool14", 1, 100,character) end,
        [15] = function () Osi.ApplyStatus(character, "Vamp_RestoreBloodPool15", 1, 100,character) end,
        [16] = function () Osi.ApplyStatus(character, "Vamp_RestoreBloodPool16", 1, 100,character) end,
        [17] = function () Osi.ApplyStatus(character, "Vamp_RestoreBloodPool17", 1, 100,character) end,
        [18] = function () Osi.ApplyStatus(character, "Vamp_RestoreBloodPool18", 1, 100,character) end,
        [19] = function () Osi.ApplyStatus(character, "Vamp_RestoreBloodPool19", 1, 100,character) end,
        [20] = function () Osi.ApplyStatus(character, "Vamp_RestoreBloodPool20", 1, 100,character) end
    }
    action[amount]()
end

Ext.Osiris.RegisterListener("LongRestStarted", 0, "after", function ()
    -- Ext.Utils.Print("Rested")
    local character = Osi.GetHostCharacter()
    local characterHasBlood = Osi.HasPassive(character,"Vamp_BloodPool1")
    if characterHasBlood then
        local amount = Osi.GetActionResourceValuePersonal(character, "Vamp_BloodPool", 0)
        PersistentVars['Blood'] = amount
    end
end)