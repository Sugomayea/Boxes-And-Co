//get inputs and shi
up = keyboard_check_pressed(ord("W"))
down = keyboard_check_pressed(ord("S"))
accept = keyboard_check_pressed(vk_space)

//store # of options in current menu
op_length = array_length(option[menu_level])

//move through menu
pos += down - up
if pos >= op_length {
	pos = 0
} else if pos < 0 {
	pos = op_length - 1
}

switch (fullscreen) {
	case 0:
		option[1, 0] = "Fullscreen - False"
		break
	case 1:
		option[1, 0] = "Fullscreen - True"
		break
}

//using options
if accept {
	var _sml = menu_level
	
	switch (menu_level){
		//main
		case 0:
			switch (pos) {
				//resume
				case 0:
					instance_destroy()
					obj_pause.pause = false
					global.pauseMovement = false
					break
				//settings
				case 1:
					menu_level = 1
					break
				//save and qui shi
				case 2:
					game_end()
					break
			}
			break
		
		//settings
		case 1:
			switch (pos) {
				//fullscreen
				case 0:
					break
				//controls
				case 1:
					break
				//credits
				case 2:
					break
				//return
				case 3:
					menu_level = 0
					break
			}
	}
		
	//set pos back
	if _sml != menu_level {
		pos = 0
	}
	
	op_length = array_length(option[menu_level])
}