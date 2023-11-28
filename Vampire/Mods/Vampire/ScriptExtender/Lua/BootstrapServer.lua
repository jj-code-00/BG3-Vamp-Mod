PersistentVars = {}

Ext.Osiris.RegisterListener("LongRestStarted", 0, "after", function ()
    for i,v in ipairs(Osi.DB_PartyMembers:Get(nil)) do
        local character = string.sub(v[1],-36)
        if (Osi.HasPassive(character,"Sanguinare_Vampiris")) then
            PersistentVars[character] = Osi.GetActionResourceValuePersonal(character, "Vamp_BloodPool", 0)
        end
    end
end)

--May need to change the classes bit into checking for vamp_pool passive incase multiclassing messes with it
Ext.Osiris.RegisterListener("LongRestFinished", 0, "after", function ()
    for i,v in ipairs(Osi.DB_PartyMembers:Get(nil)) do
        local character = string.sub(v[1],-36)
        if (Osi.HasPassive(character,"Sanguinare_Vampiris")) then
            local drainedBlood = PersistentVars[character] - 1
            if drainedBlood < 0 then
                drainedBlood = 0
            end
            RestoreBlood(character,drainedBlood)
        end
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
        [19] = function () Osi.ApplyStatus(character, "Vamp_RestoreBloodPool19", 1, 100,character) end
    }
    action[amount]()
end

Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function(object, status, causee, storyActionID)
    if status == "Vamp_StatusFlavouredEnemy" then
        for k,v in pairs(PersistentVars) do
            if PersistentVars[k] == (status .. causee) then
                Osi.RemoveStatus(k, status, causee)
            end
          end
        PersistentVars[object] = status .. causee
    end
end)

Ext.Osiris.RegisterListener("CharacterJoinedParty", 1, "after", function (character)
    Osi.ApplyStatus(character, "Vamp_StatusCanFeed", -1, 100, character)
end)

Ext.Osiris.RegisterListener("CharacterLeftParty", 1, "after", function (character)
    Osi.RemoveStatus(character, "Vamp_StatusCanFeed", character)
end)

Ext.Osiris.RegisterListener("RequestEndTheDaySuccess", 0, "after", function()
    for i,v in ipairs(Osi.DB_PartyMembers:Get(nil)) do
        local character = string.sub(v[1],-36)
        if (Osi.HasPassive(character,"Sanguinare_Vampiris")) then
            Osi.ApplyStatus(character,"Vamp_CanRepec",-1, 100,character)
        end
    end
end)

Ext.Osiris.RegisterListener("TeleportedFromCamp", 1, "after", function (character_)
    local character = string.sub(character_,-36)
    if (Osi.HasActiveStatus(character,"Sanguinare_Vampiris")) then
        _P(character)
        Osi.RemoveStatus(character,"Vamp_CanRepec",character)
    end
end)