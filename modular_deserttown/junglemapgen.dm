// \code\modules\roguetown\mapgen

/obj/effect/landmark/mapGenerator/rogue/jungle
	mapGeneratorType = /datum/mapGenerator/jungle
	endTurfX = 400
	endTurfY = 300
	startTurfX = 1
	startTurfY = 1


/datum/mapGenerator/jungle
	modules = list(/datum/mapGeneratorModule/jungle,/datum/mapGeneratorModule/jungleroad,/datum/mapGeneratorModule/junglesand,/datum/mapGeneratorModule/junglemire, /datum/mapGeneratorModule/junglewater)


/datum/mapGeneratorModule/jungle
	clusterCheckFlags = CLUSTER_CHECK_ALL
	allowed_turfs = list(/turf/open/floor/rogue/dunes, /turf/open/floor/rogue/desert_grass, /turf/open/floor/rogue/dirt, /turf/open/floor/rogue/grass, /turf/open/floor/rogue/grassred, /turf/open/floor/rogue/grassyel, /turf/open/floor/rogue/grasscold, /turf/open/floor/rogue/grassgrey)
	excluded_turfs = list(/turf/open/floor/rogue/dirt/road)
	spawnableAtoms = list(/obj/structure/flora/newtreealt = 2,
							/obj/structure/flora/roguetree/palm = 8,
							/obj/structure/flora/roguegrass = 10,
							/obj/structure/flora/roguegrass/maneater = 3,
							/obj/structure/flora/roguegrass/maneater/real/juvenile = 1.5,
							/obj/item/grown/log/tree/stick = 5,
							/obj/structure/flora/roguetree/stump/log/palm = 7,
							/obj/structure/flora/roguetree/stump = 3,
							/obj/structure/glowshroom = 1.3,
							/obj/structure/flora/ausbushes/ppflowers = 0.5,
							/obj/structure/flora/ausbushes/ywflowers = 0.4,
							/obj/item/natural/stone = 4,
							/obj/item/natural/rock = 4,
							/obj/item/magic/artifact = 0.7,
							/obj/structure/leyline = 0.2,
							/obj/structure/voidstoneobelisk = 0.3,
							/obj/structure/flora/roguegrass/herb/manabloom = 0.4,
							/obj/item/magic/manacrystal = 0.4,
							/obj/structure/closet/dirthole/closed/loot = 2,
							/obj/structure/flora/roguegrass/swampweed = 1.5,
							/obj/structure/flora/roguegrass/herb/random = 5,
							/obj/structure/flora/rogueshroom = 1,
							/obj/effect/decal/remains/bear = 0.5,
							/obj/effect/decal/remains/human = 0.3,
							/obj/structure/zizo_bane = 0.5,)
	spawnableTurfs = list(/turf/open/floor/rogue/dirt/road=2,
						/turf/open/water/swamp=2,)
	allowed_areas = list(/area/rogue/outdoors/jungle)

/datum/mapGeneratorModule/jungleroad
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/rogue/dirt/road)
	spawnableAtoms = list(/obj/item/natural/stone = 6,/obj/item/grown/log/tree/stick = 5)
	allowed_areas = list(/area/rogue/outdoors/jungle)

/datum/mapGeneratorModule/junglesand
	clusterCheckFlags = CLUSTER_CHECK_NONE
	allowed_turfs = list(/turf/open/floor/rogue/AzureSand, /turf/open/floor/rogue/dunes)
	spawnableAtoms = list(/obj/item/natural/stone = 10, /obj/item/grown/log/tree/stick = 10,
	/obj/item/reagent_containers/food/snacks/fish/crab = 1, /obj/item/reagent_containers/food/snacks/fish/lobster = 1, /obj/item/reagent_containers/food/snacks/fish/oyster = 2)
	allowed_areas = list(/area/rogue/outdoors/jungle)

/datum/mapGeneratorModule/junglewater
	clusterCheckFlags = CLUSTER_CHECK_SAME_ATOMS
	allowed_turfs = list(/turf/open/water/swamp)
	excluded_turfs = list(/turf/open/water/swamp/deep)
	allowed_areas = list(/area/rogue/outdoors/jungle)
	spawnableAtoms = list(/obj/structure/glowshroom = 5,
							/obj/item/restraints/legcuffs/beartrap/armed = 1,
							/obj/structure/flora/roguetree/stump/log = 10,
							/obj/structure/flora/roguetree = 10,
							/obj/structure/flora/ausbushes/reedbush = 20,
							/obj/structure/flora/roguegrass/water/reeds = 20,
							/obj/structure/zizo_bane = 3)

/datum/mapGeneratorModule/junglemire//extra goodies and extra traps in the danger zone for intrepid travellers
	clusterCheckFlags =  CLUSTER_CHECK_NONE
	allowed_turfs = list(/turf/open/floor/rogue/desert_grass, /turf/open/floor/rogue/dirt)
	excluded_turfs = list(/turf/open/floor/rogue/dirt/road)
	allowed_areas = list(/area/rogue/outdoors/jungle/sunken)
	spawnableAtoms = list(/obj/structure/glowshroom = 2,
							/obj/structure/flora/rogueshroom/unhappy/random = 4,
							/obj/structure/flora/roguetree/jungle = 4,
							/obj/structure/flora/roguetree/jungle/small = 4,
							/obj/structure/flora/roguegrass/bush/jungle = 5,
							/obj/structure/flora/roguegrass/bush/jungle/large = 10,
							/obj/structure/flora/roguegrass/jungle = 10,
							/obj/structure/flora/roguegrass/jungle/sparse = 10,
							/obj/structure/flora/roguegrass/water/reeds = 10,
							/obj/structure/flora/roguegrass/maneater = 5,
							/obj/structure/flora/roguegrass/maneater/real = 3,
							/obj/item/grown/log/tree/stick = 5,
							/obj/item/magic/artifact = 0.5,
							/obj/structure/leyline = 0.5,
							/obj/structure/voidstoneobelisk = 1,
							/obj/structure/flora/roguegrass/herb/manabloom = 1,
							/obj/item/magic/manacrystal = 1,
							/obj/item/grown/log/tree/stick = 5,
							/obj/structure/flora/roguetree/stump/log = 5,
							/obj/structure/flora/roguetree/stump = 5,
							/obj/structure/closet/dirthole/closed/loot = 2,
							/obj/structure/flora/roguegrass/swampweed = 4,
							/obj/structure/flora/roguegrass/herb/random = 6,
							/obj/structure/flora/rogueshroom = 3,
							/obj/effect/decal/remains/bear = 2,
							/obj/structure/flora/mushroomcluster/unhappy = 2,
							/obj/structure/flora/tinymushrooms/unhappy = 2,
							/obj/structure/zizo_bane = 3)
	spawnableTurfs = list(/turf/open/floor/rogue/dirt/road=3,
						/turf/open/water/swamp=3)
