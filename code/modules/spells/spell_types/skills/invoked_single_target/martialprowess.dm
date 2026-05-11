// A skill, currently meant to be for towner towner (excluding towner, the more freeform role atm)
// Allows you to take on an apprentice, giving them one of the skill gating traits
// And giving them Novice in corresponding skills. 
// Meant to be used once per round per character. Cannot have more than one apprentice per character.
// Encourage people to encourage w/ towners to get skills and give them a point of leverage.
/obj/effect/proc_holder/spell/invoked/martialprowess
	name = "Take Protegé"
	desc = "Take on an individual as your protegé, allowing them to level up their weapon skills past Expert. This ability gains a charge with the passing of each dae.\n\ <span class = 'notice'>You currently have the potential to take on 1 protégés.</span>"
	overlay_state = "craft_buff"
	releasedrain = 50
	chargedrain = 0
	chargetime = 3 SECONDS // A charge time mostly to render it useless for putting an input on someone's screen mid combat. 
	recharge_time = 30 SECONDS
	antimagic_allowed = TRUE
	range = 1
	var/charges = 1

/obj/effect/proc_holder/spell/invoked/martialprowess/cast(list/targets, mob/user = usr)
	. = ..()
	var/mob/living/L = targets[1]
	if(charges < 1)
		to_chat(user, span_warning("You cannot take on another protegé yet."))
		revert_cast()
		return
	if(user == L)
		to_chat(user, span_warning("You cannot take yourself on as a protegé."))
		revert_cast()
		return
	if(HAS_TRAIT(L, TRAIT_MARTIAL_PROWESS))
		to_chat(user, span_warning("They've already been trained!"))
		revert_cast()
		return
	if(alert(L, "[user.name] is offering to take you on as their protegé, allowing your martial skills to surpass that of mere Expertise. Do you accept?", "Veteran's Protegé", "SERVE AND LEARN", "I REFUSE") == "I REFUSE")
		to_chat(user, span_warning("[L.name] has declined your offer to take them on as your protegé."))
		revert_cast()
		return
	ADD_TRAIT(L, TRAIT_MARTIAL_PROWESS, TRAIT_GENERIC)
	charges--
	desc = "Take on an individual as your protegé, allowing them to level up their weapon skills past Expert. This ability gains a charge with the passing of each dae.\n\ <span class = 'notice'>You currently have the potential to take on [charges] protégés.</span>"
