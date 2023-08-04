-- Mod: Unbreakable Sewable Items
-- Desc: This modification prevents items that are capable of being repaired using the Sewing Kit from becoming broken. It keeps them at 0% durability and unusable until you repair them."

local itemsList = {
	-- sewing kit
    "earmuffshat",
    "beefalohat",
    "featherhat",
    "goggleshat",
    "deserthat",
    "winterhat",
    "walrushat",
    "tophat",
    "sweatervest",
    "trunkvest_summer",
    "trunkvest_winter",
    "armorslurper",
    "beargervest",
    "umbrella",
    "eyebrellahat",
    "rainhat",
    "raincoat",
    "catcoonhat",
    "reflectivevest",
    "strawhat",
    "heatrock",
    "bernie_inactive",
    "walterhat",
    "moonstorm_goggleshat",
    "carnival_vest_a",
    "carnival_vest_b",
    "carnival_vest_c",
    "dragonheadhat",
    "dragonbodyhat",
    "dragontailhat",
    "monkey_smallhat",
    "monkey_mediumhat",
    "polly_rogershat",
	-- other items
    "molehat"
}

local origHeatFn
local origCarriedHeatFn

-- Set broken tag in item name
local function setBrokenTag(inst, broken)
    if GetModConfigData('NAMETAG_UNBREAK') then
        if broken then
            inst:AddTag("broken")
        else
            inst:RemoveTag("broken")
        end
    end
end

-- Dont allow equipping a broken item
local function setItemState(inst, enable)
    if inst.components.equippable ~= nil then
        if enable then
            setBrokenTag(inst, true)
            inst.components.equippable.restrictedtag = "blocked_dressitem"
        else
            setBrokenTag(inst, false)
            inst.components.equippable.restrictedtag = nil
        end
    end
end

local function setBrokenItems(inst, data)
    if data and data.percent then
        if data.percent > 0 then
            if not inst:HasTag("repaired_dressitem") then
                inst:AddTag("repaired_dressitem")
				setItemState(inst, false)
            end
        else  
            inst:RemoveTag("repaired_dressitem")
			local owner = inst.components.inventoryitem:GetGrandOwner()
			if owner and owner.components.inventory then -- avoid crash of item (thermal stone) when inside a container
				if owner.components.inventory:IsItemEquipped(inst) then
					owner.components.inventory:GiveItem(inst)
				end
			end
            setItemState(inst, true)
        end
    end
end

-- Disable broken thermal stone
local function updateHeatrock(inst)
	if inst.components.fueled ~= nil and inst.components.heater ~= nil then
		local fuelPercent = inst.components.fueled:GetPercent()
		if fuelPercent then
            if fuelPercent <= 0 then
                inst.currentTempRange = 0
                inst.AnimState:PlayAnimation(tostring(3), true)
                inst.components.inventoryitem:ChangeImageName("heat_rock3")
                inst._light.Light:SetIntensity(0)
                inst._light.Light:Enable(false)
                inst.AnimState:ClearBloomEffectHandle()
                setBrokenTag(inst, true)
                inst.components.heater.heatfn = nil
                inst.components.heater.carriedheatfn = nil
            else
                setBrokenTag(inst, false)
                inst.components.heater.heatfn = origHeatFn
                inst.components.heater.carriedheatfn = origCarriedHeatFn
            end
        end
	end
end

-- Update sewable/fueled items
local function fueledItems (inst)
    if inst.components.fueled ~= nil then
        inst.components.fueled.accepting = true
        inst.components.fueled:SetDepletedFn(setBrokenItems)
        inst:ListenForEvent("percentusedchange", setBrokenItems)
        if inst.prefab ~= 'heatrock' then -- allows compatibility with the infinite thermal stone mod
            inst:DoTaskInTime(0, function()
                setBrokenItems(inst, { percent = inst.components.fueled:GetPercent() })
            end)
        else
            inst:ListenForEvent("temperaturedelta", updateHeatrock)
        end
    end
end

-- Set broken items condition to 1% to prevent them from becoming infinite when item is disabled
local function setOnePercent(inst, data, component)
    if data and data.percent then
        if data.percent <= 0 then
            inst.components[component]:SetPercent(0.01)
        end
    end
end

local function unbreakableMod (inst)
    if GLOBAL.TheWorld.ismastersim then
        local configOption = inst.prefab:upper() .. "_UNBREAK"
		if GetModConfigData(configOption) then
            -- Initialize necessary properties
            if GetModConfigData('BROKENUI_UNBREAK') and not inst:HasTag("show_broken_ui") then
                inst:AddTag("show_broken_ui")
            end
            if inst.components.equippable == nil and inst.prefab ~= 'heatrock' then
                inst:AddComponent("equippable")
            elseif inst.components.heater ~= nil and inst.prefab == 'heatrock' then
                origHeatFn = inst.components.heater.heatfn
                origCarriedHeatFn = inst.components.heater.carriedheatfn
            end
            fueledItems(inst)
        else
            -- Update broken items if disabled in the config options in mid game
            inst:DoTaskInTime(2, function()
                if inst.components.fueled ~= nil then
                    setOnePercent(inst, { percent = inst.components.fueled:GetPercent() }, "fueled")
                end
            end)
        end
    end
end

for _, prefab in ipairs(itemsList) do
    AddPrefabPostInit(prefab, unbreakableMod)
end

-- c_give("sewing_kit",1)
-- c_select();c_sel().components.fueled:SetPercent(0)