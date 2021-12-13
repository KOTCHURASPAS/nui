-- NUI.Functions = {}
NUI.Functions.shadowtext = function(text, font, x, y, color, x_a, y_a)
	draw.SimpleText(text, font, x + 1, y + 1, Color(0, 0, 0,255), x_a, y_a)
	local w,h = draw.SimpleText(text, font, x, y, color, x_a, y_a)
	return w,h
end