//Not to be confused with /obj/item/reagent_containers/food/drinks/bottle
GLOBAL_LIST_INIT(wisdoms, world.file2list("strings/rt/wisdoms.txt"))

/obj/item/reagent_containers/glass/bottle
	name = "bottle"
	desc = "A bottle with a cork."
	icon = 'icons/roguetown/items/cooking.dmi'
	icon_state = "clear_bottle1"
	amount_per_transfer_from_this = 10
	amount_per_gulp = 5
	possible_transfer_amounts = list(10)
	volume = 50
	fill_icon_thresholds = list(0, 25, 50, 75, 100)
	dropshrink = 0.8
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_MOUTH
	obj_flags = CAN_BE_HIT|UNIQUE_RENAME
	spillable = FALSE
	closed = TRUE
	reagent_flags = TRANSPARENT
	w_class = WEIGHT_CLASS_NORMAL
	drinksounds = list('sound/items/drink_bottle (1).ogg','sound/items/drink_bottle (2).ogg')
	fillsounds = list('sound/items/fillcup.ogg')
	poursounds = list('sound/items/fillbottle.ogg')
	experimental_onhip = TRUE
	debris = list(/obj/item/natural/glass_shard = 1)
	var/desc_uncorked = "An open bottle. Hopefully the cork is nearby."
	var/fancy		// for bottles with custom descriptors that you don't want to change when bottle manipulated
	var/glass_on_impact = FALSE // If TRUE, bottle will generate glass shard on impact. Otherwise it won't.

/obj/item/reagent_containers/glass/bottle/update_icon(dont_fill=FALSE)
	if(!fill_icon_thresholds || dont_fill || !reagents)
		return

	cut_overlays()
	underlays.Cut()

	if(reagents.total_volume)
		var/fill_name = fill_icon_state? fill_icon_state : icon_state
		var/mutable_appearance/filling = mutable_appearance('icons/obj/reagentfillings.dmi', "[fill_name][fill_icon_thresholds[1]]")

		var/percent = round((reagents.total_volume / volume) * 100)
		for(var/i in 1 to fill_icon_thresholds.len)
			var/threshold = fill_icon_thresholds[i]
			var/threshold_end = (i == fill_icon_thresholds.len)? INFINITY : fill_icon_thresholds[i+1]
			if(threshold <= percent && percent < threshold_end)
				filling.icon_state = "[fill_name][fill_icon_thresholds[i]]"
		filling.alpha = mix_alpha_from_reagents(reagents.reagent_list)
		filling.color = mix_color_from_reagents(reagents.reagent_list)
		underlays += filling

	if(closed)
		add_overlay("[icon_state]cork")

/obj/item/reagent_containers/glass/bottle/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum, do_splash = TRUE)
	playsound(loc, 'sound/combat/hits/onglass/glassbreak (4).ogg', 100)
	shatter(get_turf(src))
	..()

/obj/item/reagent_containers/glass/bottle/proc/shatter(turf/T)
	if(istransparentturf(T))
		shatter(GET_TURF_BELOW(T))
		return 
	glass_on_impact && new /obj/item/natural/glass_shard(get_turf(T))
	new /obj/effect/decal/cleanable/debris/glassy(get_turf(T))
	qdel(src)

/obj/item/reagent_containers/glass/bottle/rmb_self(mob/user)
	. = ..()
	toggle_cork(user)

/obj/item/reagent_containers/glass/bottle/rmb_althand(mob/user)
	. = ..()
	toggle_cork(user)

/obj/item/reagent_containers/glass/bottle/attack_self(mob/user)
	. = ..()
	toggle_cork(user)

/obj/item/reagent_containers/glass/bottle/attack_right(mob/user)
	. = ..()
	if(item_flags & IN_STORAGE)
		/*
		Currently the bottle underlay and the tetris.dm underlay (from Vanderlin inventory) do *not* play nice 
		if you try to update the bottle's icon. They'll gladly interfere with each other's underlays if you update one or the other.
		*/
		to_chat(user, span_warning("I need to take [src] out first!"))
		return
	toggle_cork(user)

/obj/item/reagent_containers/glass/bottle/proc/toggle_cork(mob/user)
	closed = !closed
	user.changeNext_move(CLICK_CD_RAPID, override = TRUE)
	if(closed)
		do_close(user)
	else
		do_open(user)

/obj/item/reagent_containers/glass/bottle/proc/do_close(mob/user, no_msg = FALSE, no_snd = FALSE)
	if(user)
		if(!no_snd)
			playsound(user.loc,'sound/items/recork.ogg', 100, TRUE)
		if(!no_msg)
			to_chat(user, span_smallnotice("I carefully press the cork back into the mouth of [src]."))
	reagent_flags = TRANSPARENT
	reagents.flags = reagent_flags
	spillable = FALSE
	GLOB.weather_act_upon_list -= src
	desc = initial(desc)
	if(!fancy)
		desc = "A bottle sealed with a cork."
	update_icon()

/obj/item/reagent_containers/glass/bottle/proc/do_open(mob/user, no_msg = FALSE, no_snd = FALSE)
	if(user)
		if(!no_snd)
			playsound(user.loc, 'sound/items/uncork.ogg', 100, TRUE)
		if(!no_msg)
			to_chat(user, span_smallnotice("I thumb off the cork from [src]."))
	reagent_flags = OPENCONTAINER
	reagents.flags = reagent_flags
	desc += desc_uncorked
	spillable = TRUE
	GLOB.weather_act_upon_list |= src
	if(!fancy)
		desc = "An open bottle. Hopefully a cork is nearby."
	update_icon()

/obj/item/reagent_containers/glass/bottle/proc/handle_storage_autoclose(mob/living/user, datum/component/storage/concrete/stor, notify_user = TRUE, make_sound = FALSE)
	// I hate my stupid hacky chud proc, but alas.
	if(closed)
		return
	
	// we will try to find the user, as best we can
	if(!user && stor && (istype(stor.real_location(), /atom/movable)))
		var/atom/movable/baggy = stor.real_location()
		if(isliving(baggy.loc)) 
			user = baggy.loc
		else if(istype(baggy.loc, /obj/item/storage)) // i.e. pouch within a bag
			var/obj/item/storage/baggy2 = baggy.loc
			if(isliving(baggy2.loc))
				user = baggy2.loc

	var/already_notified = FALSE
	if(user)
		if(user.mob_timers["autocork_notif"] && (world.time < (user.mob_timers["autocork_notif"] + 0.3 SECONDS)))
			already_notified = TRUE //anti-spam, in case you're gathering with a sack.
		if(notify_user && !already_notified)
			to_chat(user, span_info("I recork [src] before storing it."))
			user.mob_timers["autocork_notif"] = world.time

	// If we opt to make a sound, it will never be more than once per action.
	var/soundcheck = make_sound ? already_notified : TRUE

	closed = TRUE
	do_close(user, no_msg = TRUE, no_snd = soundcheck)

/obj/item/reagent_containers/glass/bottle/on_enter_storage(datum/component/storage/concrete/S)
	. = ..()
	if(S.bottle_autoclose)
		handle_storage_autoclose(stor = S, notify_user = TRUE, make_sound = TRUE)

/*
	I tried overriding attack_obj() for autoclose too. It didn't work, for a couple of reasons:
	- Storage component's attack_obj signal is very aggressive and somehow overrides this item's overrides (likely due to how signals work)
	- The bottle would perform its autoclose interaction when trying to click on a water bin, preventing transfer
	But for all other "autoclose" interactions that don't involve a storage component, you can provide the user as `user` if you have it.
*/

/obj/item/reagent_containers/glass/bottle/Initialize(mapload)
	. = ..()
	if(!icon_state)
		icon_state = "clear_bottle1"
	if(icon_state == "clear_bottle1")
		icon_state = "clear_bottle[rand(1,4)]"
	update_icon()
