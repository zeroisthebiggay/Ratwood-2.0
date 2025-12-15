//can sort these into other folders later if we really wanna

//armor
//Common workhorse armour for men at arms? Seems like it should be decent alround basic protection, like a hauberk (but not underarmour)
/obj/item/clothing/suit/roguetown/armor/chainmail/mamaluke
	slot_flags = ITEM_SLOT_ARMOR
	name = "hauberk"
	desc = "A longer steel maille that protects the legs, still doesn't protect against arrows though."
	body_parts_covered = COVERAGE_FULL
	icon = "icons/desert_town/clothing/armor.dmi"
	icon_state = "mamaluke"
	armor = ARMOR_MAILLE
	smeltresult = /obj/item/ingot/steel
	armor_class = ARMOR_CLASS_MEDIUM
	smelt_bar_num = 2

//I remember cataphracts were supposed to be knights and that this is supposed to be heavy armour.
//Judging by the sprite it feels like the torso should be more heavily armoured but idk how to do that
//Some good clean -all-over protection again. Like scalemail but all-over. That'll do it right?
/obj/item/clothing/suit/roguetown/armor/plate/cataphract
	slot_flags = ITEM_SLOT_ARMOR
	name = "Cataphract Armor"
	desc = "Metal scales interwoven intricately to form flexible protection!"
	body_parts_covered = COVERAGE_FULL
	allowed_sex = list(MALE, FEMALE)
	icon = "icons/desert_town/clothing/armor.dmi"
	icon_state = "cataphract"
	max_integrity = ARMOR_INT_CHEST_MEDIUM_STEEL
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	equip_delay_self = 4 SECONDS
	armor_class = ARMOR_CLASS_HEAVY
	smelt_bar_num = 2


/obj/item/clothing/suit/roguetown/armor/leather/vest/open
	name = "open vest"
	desc = "A leather vest. Not very protective when worn like this."
	icon = "icons/desert_town/clothing/armor.dmi"
	icon_state = "openvest"
	body_parts_covered = COVERAGE_TORSO

/obj/item/clothing/suit/roguetown/shirt/robe/merchant/merbisht
	name = "Merchant's Bisht"
	desc = "CHANGE THIS DESCRIPTION."
	icon = "icons/desert_town/clothing/armor.dmi"
	icon_state = "merbisht"

//SHIRTS


/obj/item/clothing/suit/roguetown/shirt/robe/sultan
	icon = "icons/desert_town/clothing/armor.dmi"
	icon_state = "merbisht"


/obj/item/clothing/suit/roguetown/shirt/robe/sultana
	icon = "icons/desert_town/clothing/armor.dmi"
	icon_state = "merbisht"


/obj/item/clothing/suit/roguetown/shirt/thawb
	icon = "icons/desert_town/clothing/armor.dmi"
	icon_state = "merbisht"


/obj/item/clothing/suit/roguetown/shirt/thawbgold
	icon = "icons/desert_town/clothing/armor.dmi"
	icon_state = "merbisht"


/obj/item/clothing/suit/roguetown/shirt/robe/
	icon = "icons/desert_town/clothing/armor.dmi"
	icon_state = "merbisht"
