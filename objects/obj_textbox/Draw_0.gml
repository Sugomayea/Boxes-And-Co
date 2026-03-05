accept_key = keyboard_check_pressed(vk_space)

textbox_x = camera_get_view_x(view_camera[0])
textbox_y = camera_get_view_y(view_camera[0]) + 448

//---------------------setup---------------------
if setup = false {
	setup = true
	draw_set_font(global.font_main)
	draw_set_valign(fa_top)
	draw_set_halign(fa_left)
	
	for (var p = 0; p < page_number; p++) {
		//find out how many chars in page and store in var
		text_length[p] = string_length(text[p])
		
		
		//get the x pos for textbox
			//char on left
			text_x_offset[p] = 305
			portrait_x_offset[p] = 32
			//char on right
			if speaker_side[p] = -1 {
				text_x_offset[p] = 32
				portrait_x_offset[p] = 1008
			}
			//no character (center box)
			if speaker_sprite[p] = noone {
				text_x_offset[p] = 160
			}
			
		//set individ chars and finding where the lines of text should be
		for (var c = 0; c < text_length[p]; c++) {
			var _char_pos = c + 1
			
			//store individ chars in array
			char[c, p] = string_char_at(text[p], _char_pos)
			
			//get current width of line
			var _txt_up_to_char = string_copy(text[p], 1, _char_pos)
			var _current_txt_w = string_width(_txt_up_to_char) - string_width(char[c, p])
			
			//get last free space
			if char[c, p] = " " {
				last_free_space = _char_pos + 1
			}
			
			//get line breaks 
			if _current_txt_w - line_break_offset[p] > line_width {
				line_break_pos[line_break_num[p], p] = last_free_space
				line_break_num[p]++
				var _txt_up_to_last_space = string_copy(text[p], 1, last_free_space)
				var _last_free_space_string = string_char_at(text[p], last_free_space)
				line_break_offset[p] = string_width(_txt_up_to_last_space) - string_width(_last_free_space_string)
			}
		}
		
		//getting each chars coords
		for (var c = 0; c < text_length[p]; c++) {
			var _char_pos = c + 1
			var _txt_x = textbox_x + text_x_offset[p] + border
			var _txt_y = textbox_y + border
			//get current width of line
			var _txt_up_to_char = string_copy(text[p], 1, _char_pos)
			var _current_txt_w = string_width(_txt_up_to_char) - string_width(char[c, p])
			var _txt_line = 0
			
			//compensate for string breaks
			for (var lb = 0; lb < line_break_num[p]; lb++) {
			    //if current looping char is after line break
				if _char_pos >= line_break_pos[lb, p] {
					var _str_copy = string_copy(text[p], line_break_pos[lb, p], _char_pos - line_break_pos[lb, p])
					_current_txt_w = string_width(_str_copy)
					
					//record the "line" this char should be on
					_txt_line = lb + 1 // +1 since lb starts on 0
				}
			}
			
			//add to x and y coords based on new info
			char_x[c, p] = _txt_x + _current_txt_w
			char_y[c, p] = _txt_y + _txt_line * line_sep
		}
	}
}
	
	
//typing text
if text_pause_timer <= 0 {
	if draw_char < text_length[page] {
		draw_char += text_speed
		draw_char = clamp(draw_char, 0, text_length[page])
		var _check_char = string_char_at(text[page], draw_char)
		if _check_char = "." || _check_char = "," || _check_char = ";" {
			text_pause_timer = text_pause_time
			if !audio_is_playing(snd[page]) {
				audio_play_sound(snd[page], 8, false)
			}
		} else {
			//typing snd
			if snd_count < snd_delay {
				snd_count++
			} else {
				snd_count = 0
				if !audio_is_playing(snd[page]) {
					audio_play_sound(snd[page], 8, false)
				}
			}
		}
	}
} else {
	text_pause_timer--
}

//---------------------flip trhough pages---------------------
if accept_key {
	if draw_char = text_length[page] {
		//next page
		if page < page_number - 1 {
			page++
			draw_char = 0
		} else {
			//link text for options
			if option_number > 0 {
				create_textbox(option_link_id[option_pos])
			}
			
			instance_destroy()
			global.pauseMovement = false
		}
	} else {
		draw_char = text_length[page]
	}
}

//---------------------draw factors---------------------
var _txtb_x = textbox_x + text_x_offset[page]
var _txtb_y = textbox_y
txtb_img += txtb_img_spd
txtb_spr_w = sprite_get_width(txtb_spr[page])
txtb_spr_h = sprite_get_height(txtb_spr[page])
//draw speaker and shi
if speaker_sprite[page] != noone {
	sprite_index = speaker_sprite[page]
	var _speaker_x = textbox_x + portrait_x_offset[page]
	if speaker_side[page] = -1 {
		_speaker_x += sprite_width
	}
	//draw speaker now
	draw_sprite_ext(txtb_spr[page], txtb_img, textbox_x + portrait_x_offset[page], textbox_y, sprite_width/txtb_spr_w, sprite_height/txtb_spr_h, 0, c_white, 1)
	draw_sprite_ext(sprite_index, image_index, _speaker_x, textbox_y, speaker_side[page], 1, 0, c_white, 1)
}
//back of the box
draw_sprite_ext(txtb_spr[page], txtb_img, _txtb_x, _txtb_y, textbox_width/txtb_spr_w, textbox_height/txtb_spr_h, 0, c_white, 1)

//---------------------options---------------------
if draw_char = text_length[page] && page = page_number - 1 {
	//option seclet
	if (keyboard_check_pressed(ord("S")) or keyboard_check_pressed(ord("W"))) and options_drawn = true {
		audio_play_sound(snd_selectChange, 10, false)
		options_drawn = false
	}
	
	option_pos += keyboard_check_pressed(ord("S")) - keyboard_check_pressed(ord("W"))
	if option_pos >= option_number {
		option_pos = 0
	} else if option_pos < 0 {
		option_pos = option_number - 1
	}
	
	//draw options
	var _op_space = 60
	var _op_border = 15
	for (var op = 0; op < option_number; op++) {
		//the option box
		var _o_w = string_width(option[op]) + _op_border * 2
		
		draw_sprite_ext(txtb_spr[page], txtb_img, _txtb_x + 68, _txtb_y - _op_space * option_number + _op_space * op, _o_w/txtb_spr_w, (_op_space - 2)/txtb_spr_h, 0, c_white, 1)
		options_drawn = true
		
		//draw arrow
		if option_pos = op {
			draw_sprite(spr_arrowThing, 0, _txtb_x + 4, _txtb_y - _op_space * option_number + _op_space * op)
		}
		
		//option text
		draw_text(_txtb_x + 64 + _op_border, _txtb_y - _op_space * option_number + _op_space * op + 8, option[op])
	}
}

//---------------------draw text FINALLY---------------------
for (var c = 0; c < draw_char; c++) {
	//-------------special stuff (my stash)--------------------
	//floation yeah
	var _float_x = 0
	var _float_y = 0
	if float_text[c, page] = true {
		float_dir_x[c, page] -= 6
		float_dir_y[c, page] -= 6
		_float_x = dcos(float_dir_x[c, page]) * float_markiplier_x[c, page]
		_float_y = dsin(float_dir_y[c, page]) * float_markiplier_y[c, page]
	}
	
	//shake text
	var _shake_x = 0
	var _shake_y = 0
	if shake_break[c, page] != 0 {
		if shake_text[c, page] = true {
			shake_timer[c, page]--
			if shake_timer[c, page] <= 0 {
				shake_timer[c, page] = irandom_range(1, 2)
				shake_dir[c, page] = irandom(360)
			}
			if shake_timer[c, page] <= 1 {
				_shake_x = lengthdir_x(shake_modifier[c, page], shake_dir[c, page])
				_shake_y = lengthdir_y(shake_modifier[c, page], shake_dir[c, page])
			}
		}
		shake_break[c, page]--
	}
	
	//the text
    draw_text_colour(char_x[c, page] + _float_x + _shake_x, char_y[c, page] + _float_y + _shake_y, char[c, page], col_1[c, page], col_2[c, page], col_3[c, page], col_4[c, page], 1)
}