pause = keyboard_check_pressed(vk_escape)

if pause and !global.pauseMovement {
	global.pauseMovement = true
	instance_create_depth(444, 46.5, -10000, obj_menu)
} else if instance_exists(obj_textbox) and !global.pauseMovement {
	global.pauseMovement = true
}