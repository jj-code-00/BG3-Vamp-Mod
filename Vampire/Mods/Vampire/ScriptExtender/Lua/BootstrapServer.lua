PersistentVars = {}

--Start: Functions for draining blood each long rest

Ext.Osiris.RegisterListener("LongRestStarted", 0, "after", function ()
    for i,v in ipairs(Osi.DB_PartyMembers:Get(nil)) do
        local character = string.sub(v[1],-36)
        if (Osi.HasPassive(character,"Sanguinare_Vampiris") == 1) then
            PersistentVars[character] = Osi.GetActionResourceValuePersonal(character, "Vamp_BloodPool", 0)
        end
    end
end)

Ext.Osiris.RegisterListener("LongRestFinished", 0, "after", function ()
    for i,v in ipairs(Osi.DB_PartyMembers:Get(nil)) do
        local character = string.sub(v[1],-36)
        if (Osi.HasPassive(character,"Sanguinare_Vampiris") == 1) then
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

--End: Functions for draining blood each long rest

--Start: Functions for impaler FlavouredEnemy

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

--End: Functions for impaler FlavouredEnemy

--Start: Functions for what characters a vampire can feed on

Ext.Osiris.RegisterListener("CharacterJoinedParty", 1, "after", function (character)
    Osi.ApplyStatus(character, "Vamp_StatusCanFeed", -1, 100, character)
end)

Ext.Osiris.RegisterListener("CharacterLeftParty", 1, "after", function (character)
    Osi.RemoveStatus(character, "Vamp_StatusCanFeed", character)
end)

--End: Functions for what characters a vampire can feed on

--Start: Functions for if the vampire can respec

Ext.Osiris.RegisterListener("RequestEndTheDaySuccess", 0, "after", function()
    for i,v in ipairs(Osi.DB_PartyMembers:Get(nil)) do
        local character = string.sub(v[1],-36)
        if (Osi.HasPassive(character,"Sanguinare_Vampiris") == 1) then
            Osi.ApplyStatus(character,"Vamp_CanRepec",-1, 100,character)
        end
    end
end)

Ext.Osiris.RegisterListener("TeleportedFromCamp", 1, "after", function (character_)
    local character = string.sub(character_,-36)
    if (Osi.HasActiveStatus(character,"Sanguinare_Vampiris") == 1) then
        Osi.RemoveStatus(character,"Vamp_CanRepec",character)
    end
end)

--End: Functions for if the vampire can respec

--Start: Functions for feeding on lover bonus

Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function(object, status, causee, storyActionID)
    if status == "Vamp_Fed" and Osi.GetApprovalRating(object, causee) >= 81 then
        Osi.ApplyStatus(causee,"Vamp_Fed_HAPPYLover",-1, 100,object)
    end
end)

--End: Functions for feeding on lover bonus

--Start: Functions to check for unarmed abilityValue

function ChangeUnarmedAbility(character_)
    if Osi.HasPassive(character_,"Sanguinare_Vampiris") == 1 then
        if (Osi.GetAbility(character_, "Dexterity") > Osi.GetAbility(character_, "Strength")) then
            local character = Ext.Entity.Get(character_)
            character.Stats.UnarmedAttackAbility = "Dexterity"
            character:Replicate("Stats")
        end
        if (Osi.GetAbility(character_, "Dexterity") < Osi.GetAbility(character_, "Strength")) then
            local character = Ext.Entity.Get(character_)
            character.Stats.UnarmedAttackAbility = "Strength"
            character:Replicate("Stats")
        end
    end
end

Ext.Osiris.RegisterListener("LeveledUp", 1, "after", function(character_)
    ChangeUnarmedAbility(character_)
end)

Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function(object, status, causee, storyActionID)
    if Osi.IsCharacter(object) == 1 then
        ChangeUnarmedAbility(object)
    end
end)

Ext.Osiris.RegisterListener("StatusRemoved", 4, "after", function(object, status, causee, applyStoryActionID)
    if Osi.IsCharacter(object) == 1 then
        ChangeUnarmedAbility(object)
    end
end)

Ext.Osiris.RegisterListener("RespecCompleted", 1, "after", function(character_)
    if Osi.HasPassive(character_,"Sanguinare_Vampiris") == 0 then
        local character = Ext.Entity.Get(character_)
        character.Stats.UnarmedAttackAbility = "Strength"
        character:Replicate("Stats")

    end
end)

--End: Functions to check for unarmed abilityValue