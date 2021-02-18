
local args = {...}
local side
if #args > 1 or #args < 1 then 
  print("Invalid number of arguments.")
else
  side = args[1]
end
if side == "left" or side == "right" or side == "back" or side == "top" or side == "bottom" then
  m = peripheral.wrap(side)
else
 print("Invalid argument!")
end

local function iterator()
	return coroutine.wrap( function()
		for line in string.gmatch( filmText, "([^\n]*)\n") do
			coroutine.yield(line)
		end
		return false
	end )
end

m.clear()
m.setTextScale(1)
m.setCursorPos(1,1)
local it = iterator()

local bFinished = false
while not bFinished do
        
        -- Make 'b' the exit key
        --local sEvent, param = os.pullEvent("key")
        --if sEvent == "key" then
                --if param == 48 then
                --bFinished = true
            --end
        --end
            
	-- Read the frame header
	local holdLine = it()
	if not holdLine then
		bFinished = true
		break
	end

	-- Get this every frame incase the monitor resizes	
	local w,h = m.getSize()
	local startX = math.floor( (w - 65) / 2 )
	local startY = math.floor( (h - 14) / 2 )

	-- Print the frame
	m.clear()
	for n=1,13 do
		local line = it()
		if line then
			m.setCursorPos(startX, startY + n)
		        m.write( line )
		else
			bFinished = true
			break
		end
	end

	-- Hold the frame
	local hold = tonumber(holdLine) or 1
	local delay = (hold * 0.05) - 0.01
	sleep( delay )
end