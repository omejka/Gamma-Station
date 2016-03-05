/obj/screen/alien
	icon = 'icons/mob/screen1_xeno.dmi'

/obj/screen/alien/leap
	name = "toggle leap"
	icon_state = "leap_off"

/obj/screen/alien/leap/Click()
	if(istype(usr, /mob/living/carbon/alien/humanoid))
		var/mob/living/carbon/alien/humanoid/hunter/AH = usr
		AH.toggle_leap()

/obj/screen/alien/nightvision
	name = "toggle night-vision"
	icon_state = "nightvision1"

/obj/screen/alien/nightvision/Click()
	if(istype(usr, /mob/living/carbon/alien/))
		var/mob/living/carbon/alien/A = usr
		A.toggle_nvg()

/*/obj/screen/alien/nightvision/Click()
	var/mob/living/carbon/alien/A = usr
	var/obj/effect/proc_holder/alien/nightvisiontoggle/T = locate() in A.abilities
	if(T)
		T.fire(A)*/

/datum/hud/proc/alien_hud()

	src.adding = list()
	src.other = list()

	var/obj/screen/using
	var/obj/screen/inventory/inv_box

	using = new /obj/screen()
	using.name = "act_intent"
	using.dir = SOUTHWEST
	using.icon = 'icons/mob/screen1_xeno.dmi'
	using.icon_state = (mymob.a_intent == "hurt" ? "harm" : mymob.a_intent)
	using.screen_loc = ui_acti
	using.layer = 20
	src.adding += using
	action_intent = using

//intent small hud objects
	var/icon/ico

	ico = new('icons/mob/screen1_xeno.dmi', "black")
	ico.MapColors(0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, -1,-1,-1,-1)
	ico.DrawBox(rgb(255,255,255,1),1,ico.Height()/2,ico.Width()/2,ico.Height())
	using = new /obj/screen( src )
	using.name = "help"
	using.icon = ico
	using.screen_loc = ui_acti
	using.layer = 21
	src.adding += using
	help_intent = using

	ico = new('icons/mob/screen1_xeno.dmi', "black")
	ico.MapColors(0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, -1,-1,-1,-1)
	ico.DrawBox(rgb(255,255,255,1),ico.Width()/2,ico.Height()/2,ico.Width(),ico.Height())
	using = new /obj/screen( src )
	using.name = "disarm"
	using.icon = ico
	using.screen_loc = ui_acti
	using.layer = 21
	src.adding += using
	disarm_intent = using

	ico = new('icons/mob/screen1_xeno.dmi', "black")
	ico.MapColors(0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, -1,-1,-1,-1)
	ico.DrawBox(rgb(255,255,255,1),ico.Width()/2,1,ico.Width(),ico.Height()/2)
	using = new /obj/screen( src )
	using.name = "grab"
	using.icon = ico
	using.screen_loc = ui_acti
	using.layer = 21
	src.adding += using
	grab_intent = using

	ico = new('icons/mob/screen1_xeno.dmi', "black")
	ico.MapColors(0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, -1,-1,-1,-1)
	ico.DrawBox(rgb(255,255,255,1),1,1,ico.Width()/2,ico.Height()/2)
	using = new /obj/screen( src )
	using.name = "harm"
	using.icon = ico
	using.screen_loc = ui_acti
	using.layer = 21
	src.adding += using
	hurt_intent = using

//end intent small hud objects

	using = new /obj/screen()
	using.name = "mov_intent"
	using.dir = SOUTHWEST
	using.icon = 'icons/mob/screen1_xeno.dmi'
	using.icon_state = (mymob.m_intent == "run" ? "running" : "walking")
	using.screen_loc = ui_movi
	using.layer = 20
	src.adding += using
	move_intent = using

	using = new /obj/screen()
	using.name = "drop"
	using.icon = 'icons/mob/screen1_xeno.dmi'
	using.icon_state = "act_drop"
	using.screen_loc = ui_drop_throw
	using.layer = 19
	src.adding += using

//equippable shit
	//suit
	/*inv_box = new /obj/screen/inventory()
	inv_box.name = "o_clothing"
	inv_box.dir = SOUTH
	inv_box.icon = 'icons/mob/screen1_xeno.dmi'
	inv_box.icon_state = "suit"
	inv_box.screen_loc = ui_alien_oclothing
	inv_box.slot_id = slot_wear_suit
	inv_box.layer = 19
	src.adding += inv_box*/

	inv_box = new /obj/screen/inventory()
	inv_box.name = "r_hand"
	inv_box.dir = WEST
	inv_box.icon = 'icons/mob/screen1_xeno.dmi'
	inv_box.icon_state = "hand_r_inactive"
	if(mymob && !mymob.hand)	//This being 0 or null means the right hand is in use
		inv_box.icon_state = "hand_r_active"
	inv_box.screen_loc = ui_rhand
	inv_box.layer = 19
	inv_box.slot_id = slot_r_hand
	src.r_hand_hud_object = inv_box
	src.adding += inv_box

	inv_box = new /obj/screen/inventory()
	inv_box.name = "l_hand"
	inv_box.dir = EAST
	inv_box.icon = 'icons/mob/screen1_xeno.dmi'
	inv_box.icon_state = "hand_l_inactive"
	if(mymob && mymob.hand)	//This being 1 means the left hand is in use
		inv_box.icon_state = "hand_l_active"
	inv_box.screen_loc = ui_lhand
	inv_box.layer = 19
	inv_box.slot_id = slot_l_hand
	src.l_hand_hud_object = inv_box
	src.adding += inv_box

	using = new /obj/screen/inventory()
	using.name = "hand"
	using.dir = SOUTH
	using.icon = 'icons/mob/screen1_xeno.dmi'
	using.icon_state = "swap_1"
	using.screen_loc = ui_swaphand1
	using.layer = 19
	src.adding += using

	using = new /obj/screen/inventory()
	using.name = "hand"
	using.dir = SOUTH
	using.icon = 'icons/mob/screen1_xeno.dmi'
	using.icon_state = "swap_2"
	using.screen_loc = ui_swaphand2
	using.layer = 19
	src.adding += using

	/*//pocket 1
	inv_box = new /obj/screen/inventory()
	inv_box.name = "storage1"
	inv_box.icon = 'icons/mob/screen1_xeno.dmi'
	inv_box.icon_state = "pocket"
	inv_box.screen_loc = ui_storage1
	inv_box.slot_id = slot_l_store
	inv_box.layer = 19
	src.adding += inv_box

	//pocket 2
	inv_box = new /obj/screen/inventory()
	inv_box.name = "storage2"
	inv_box.icon = 'icons/mob/screen1_xeno.dmi'
	inv_box.icon_state = "pocket"
	inv_box.screen_loc = ui_storage2
	inv_box.slot_id = slot_r_store
	inv_box.layer = 19
	src.adding += inv_box*/

	//head
	/*inv_box = new /obj/screen/inventory()
	inv_box.name = "head"
	inv_box.icon = 'icons/mob/screen1_xeno.dmi'
	inv_box.icon_state = "head"
	inv_box.screen_loc = ui_alien_head
	inv_box.slot_id = slot_head
	inv_box.layer = 19
	src.adding += inv_box*/
//end of equippable shit

	mymob.nightvisionicon = new /obj/screen/alien/nightvision()
	mymob.nightvisionicon.screen_loc = ui_alien_nightvision
	src.adding += mymob.nightvisionicon

	using = new /obj/screen()
	using.name = "resist"
	using.icon = 'icons/mob/screen1_xeno.dmi'
	using.icon_state = "act_resist"
	using.screen_loc = ui_pull_resist
	using.layer = 19
	src.adding += using

	if(istype(mymob, /mob/living/carbon/alien/humanoid/hunter))
		mymob.leap_icon = new /obj/screen/alien/leap()
		mymob.leap_icon.screen_loc = ui_storage2
		src.adding += mymob.leap_icon

	mymob.throw_icon = new /obj/screen()
	mymob.throw_icon.icon = 'icons/mob/screen1_xeno.dmi'
	mymob.throw_icon.icon_state = "act_throw_off"
	mymob.throw_icon.name = "throw"
	mymob.throw_icon.screen_loc = ui_drop_throw

	/*mymob.oxygen = new /obj/screen()
	mymob.oxygen.icon = 'icons/mob/screen1_xeno.dmi'
	mymob.oxygen.icon_state = "oxy0"
	mymob.oxygen.name = "oxygen"
	mymob.oxygen.screen_loc = ui_alien_oxygen*/

	/*mymob.toxin = new /obj/screen()
	mymob.toxin.icon = 'icons/mob/screen1_xeno.dmi'
	mymob.toxin.icon_state = "tox0"
	mymob.toxin.name = "toxin"
	mymob.toxin.screen_loc = ui_alien_toxin*/

	/*mymob.fire = new /obj/screen()
	mymob.fire.icon = 'icons/mob/screen1_xeno.dmi'
	mymob.fire.icon_state = "fire0"
	mymob.fire.name = "fire"
	mymob.fire.screen_loc = ui_alien_fire*/

	//Freezes byond client
	mymob.alien_plasma_display = new /obj/screen()
	mymob.alien_plasma_display.icon = 'icons/mob/screen1_xeno.dmi'
	mymob.alien_plasma_display.icon_state = "power_display3"
	mymob.alien_plasma_display.name = "plasma stored"
	mymob.alien_plasma_display.screen_loc = ui_alienplasmadisplay

	mymob.healths = new /obj/screen()
	mymob.healths.icon = 'icons/mob/screen1_xeno.dmi'
	mymob.healths.icon_state = "health0"
	mymob.healths.name = "health"
	mymob.healths.screen_loc = ui_alien_health

	mymob.pullin = new /obj/screen()
	mymob.pullin.icon = 'icons/mob/screen1_xeno.dmi'
	mymob.pullin.icon_state = "pull0"
	mymob.pullin.name = "pull"
	mymob.pullin.screen_loc = ui_pull_resist

	mymob.zone_sel = new /obj/screen/zone_sel()
	mymob.zone_sel.icon = 'icons/mob/screen1_xeno.dmi'
	mymob.zone_sel.overlays.Cut()
	mymob.zone_sel.overlays += image('icons/mob/zone_sel.dmi', "[mymob.zone_sel.selecting]")

	mymob.client.screen = list()

	mymob.client.screen += list( mymob.throw_icon, mymob.zone_sel, mymob.healths, mymob.alien_plasma_display, mymob.pullin) //, mymob.hands, mymob.rest, mymob.sleep, mymob.mach )
	mymob.client.screen += src.adding + src.other
	mymob.client.screen += mymob.client.void
