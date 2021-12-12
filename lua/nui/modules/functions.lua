NUI.Functions.shadowtext = function(text, font, x, y, color, x_a, y_a, color_shadow)
	color_shadow = color_shadow or Color(0, 0, 0,255)
	draw.SimpleText(text, font, x + 1, y + 1, color_shadow, x_a, y_a)
	local w,h = draw.SimpleText(text, font, x, y, color, x_a, y_a)
	return w,h
end