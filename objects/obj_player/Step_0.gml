var right = keyboard_check(ord("D"))
var left = keyboard_check(ord("A"))
var up = keyboard_check(ord("W"))
var down = keyboard_check(ord("S"))
var sprint = keyboard_check(vk_shift)

moveSpd = sprint ? runSpd: walkSpd

xSpd = moveSpd * (right - left)
ySpd = moveSpd * (down - up)

if xSpd != 0 or ySpd != 0 {
	moving = true
} else {
	moving = false
}

if place_meeting(x + xSpd, y, obj_npc) {
	xSpd = 0
}

if place_meeting(x, y + ySpd, obj_npc) {
	ySpd = 0
}


if !global.pauseMovement {
	if right {
		sprite_index = spr_playerRight
		facing = 0
	} else if left {
		sprite_index = spr_playerLeft
		facing = 1
	} else if up {
		sprite_index = spr_playerUp
		facing = 2
	} else if down {
		sprite_index = spr_playerDown
		facing = 3
	}
	
	if moving and sprint {
		image_speed = 2
	} else if moving and !sprint {
		image_speed = 1
	} else {
		image_speed = 0
		image_index = 0
	}

	x += xSpd
	y += ySpd
}