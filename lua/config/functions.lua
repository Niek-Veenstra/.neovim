local F = {}

local bufferline = require("bufferline")
F.sort_terminal = function(buf_a, buf_b)
  if buf_a.name == "zsh" then
    return false
  end
  if buf_b.name == "zsh" then
    return true
  end
  return bufferline.sort_by("directory")
end
return F
