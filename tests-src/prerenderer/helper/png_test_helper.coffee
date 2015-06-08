exports.fillPng = (png, color) ->
  for y in [0..png.height-1]
    for x in [0..png.width-1]
      index = (png.width*y + x) << 2
      png.data[index]   = 255*color.red()
      png.data[index+1] = 255*color.green()
      png.data[index+2] = 255*color.blue()
      png.data[index+3] = 255
