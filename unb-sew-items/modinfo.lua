name = "Unbreakable Sewable Items"
description = "This mod prevents items that are capable of being repaired using the Sewing Kit from becoming broken. It keeps them at 0% durability and unusable until you repair them.\n\nIn the mod settings, you can turn off some mod functions and disable unbreakability for the items you want."
author = "Gabryus"
version = "2.3"

forumthread = ""

icon_atlas = "modicon.xml"
icon = "modicon.tex"

api_version = 10

dont_starve_compatible = false
reign_of_giants_compatible = false
dst_compatible = true

all_clients_require_mod = true
client_only_mod = false

-- Makes configuration_options more compact and readable
local function addConfig(label, name, default, hover)
    return {label = label, name = name, options = { {description = "Disabled", data = false}, {description = "Enabled", data = true} }, default = default, hover = hover}
end

-- Divides menu for ease of navigation
local function divide(label)
	return {name = "", label = label, options = { { description = "", data = "" } }, default = "" }
end

configuration_options = {
    divide("Options"),
    addConfig("Broken UI", "BROKENUI_UNBREAK", true, "When an item breaks, its icon gets a red border. "),
    addConfig("Broken Nametag", "NAMETAG_UNBREAK", true, "When an item breaks, the word 'broken' is set in the item name."),

    divide("Sewable Items"),
    addConfig("Thermal Stone", "HEATROCK_UNBREAK", true, ""),
    addConfig("Rabbit Earmuffs", "EARMUFFSHAT_UNBREAK", true, ""),
    addConfig("Beefalo Hat", "BEEFALOHAT_UNBREAK", true, ""),
    addConfig("Feather Hat", "FEATHERHAT_UNBREAK", true, ""),
    addConfig("Fashion Goggles", "GOGGLESHAT_UNBREAK", true, ""),
    addConfig("Desert Goggles", "DESERTHAT_UNBREAK", true, ""),
    addConfig("Winter Hat", "WINTERHAT_UNBREAK", true, ""),
    addConfig("Tam o' Shanter", "WALRUSHAT_UNBREAK", true, ""),
    addConfig("Top Hat", "TOPHAT_UNBREAK", true, ""),
    addConfig("Dapper Vest", "SWEATERVEST_UNBREAK", true, ""),
    addConfig("Breezy Vest", "TRUNKVEST_SUMMER_UNBREAK", true, ""),
    addConfig("Puffy Vest", "TRUNKVEST_WINTER_UNBREAK", true, ""),
    addConfig("Belt of Hunger", "ARMORSLURPER_UNBREAK", true, ""),
    addConfig("Hibearnation Vest", "BEARGERVEST_UNBREAK", true, ""),
    addConfig("Umbrella", "UMBRELLA_UNBREAK", true, ""),
    addConfig("Eyebrella", "EYEBRELLAHAT_UNBREAK", true, ""),
    addConfig("Rain Hat", "RAINHAT_UNBREAK", true, ""),
    addConfig("Rain Coat", "RAINCOAT_UNBREAK", true, ""),
    addConfig("Cat Cap", "CATCOONHAT_UNBREAK", true, ""),
    addConfig("Summer Frest", "REFLECTIVEVEST_UNBREAK", true, ""),
    addConfig("Straw Hat", "STRAWHAT_UNBREAK", true, ""),
    addConfig("Bernie", "BERNIE_INACTIVE_UNBREAK", true, ""),
    addConfig("Pinetree Pioneer Hat", "WALTERHAT_UNBREAK", true, ""),
    addConfig("Astroggles", "MOONSTORM_GOGGLESHAT_UNBREAK", true, ""),
    addConfig("Chirpy Scarf", "CARNIVAL_VEST_A_UNBREAK", true, ""),
    addConfig("Chirpy Cloak", "CARNIVAL_VEST_B_UNBREAK", true, ""),
    addConfig("Chirpy Capelet", "CARNIVAL_VEST_C_UNBREAK", true, ""),
    addConfig("Lucky Beast Head", "DRAGONHEADHAT_UNBREAK", true, ""),
    addConfig("Lucky Beast Body", "DRAGONBODYHAT_UNBREAK", true, ""),
    addConfig("Lucky Beast Tail", "DRAGONTAILHAT_UNBREAK", true, ""),
    addConfig("Pirate's Bandana", "MONKEY_SMALLHAT_UNBREAK", true, ""),
    addConfig("Captain's Tricorn", "MONKEY_MEDIUMHAT_UNBREAK", true, ""),
    addConfig("Polly Roger's Hat", "POLLY_ROGERSHAT_UNBREAK", true, ""),

    divide("Other Items"),
    addConfig("Moggles", "MOLEHAT_UNBREAK", false, "This item can be repaired with Glow Berries."),
}