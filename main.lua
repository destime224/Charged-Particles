local ions = require "ions"

function Gepotenuse(a,b)
	return math.sqrt(a^2+b^2)
end

function getIonsForce(ion, secondIon)
	return -k*ion.charge*secondIon.charge/(Gepotenuse(secondIon.body:getX()-ion.body:getX(),secondIon.body:getY()-ion.body:getY()))^2
end

function love.load()
	k = 560 --Энергетическая постояная
	world = love.physics.newWorld(0, 0, false)

	isPressed = {false,false,false}
	charges = {10,-10,0}
end

function love.update(dt)
	world:update(dt)

	for i = 1, 3 do
		if love.mouse.isDown(i) and not isPressed[i] then
			ions.Ion:new(world,
				love.mouse.getX(),
				love.mouse.getY(),
				charges[i])
			isPressed[i] = true
		end
		
		if not love.mouse.isDown(i) then
			isPressed[i] = false
		end
	end
	
	for i, ion in ipairs(ions.Ion.objects) do
		--local Forces = {}
		for i, secondIon in pairs(ions.Ion.objects) do
			if ion ~= secondIon then
				--table.insert(Forces, k)
				ion.body:applyForce(getIonsForce(ion, secondIon)*((secondIon.body:getX()-ion.body:getX())/Gepotenuse(secondIon.body:getX()-ion.body:getX(),secondIon.body:getY()-ion.body:getY())),
				getIonsForce(ion, secondIon)*((secondIon.body:getY()-ion.body:getY())/Gepotenuse(secondIon.body:getX()-ion.body:getX(),secondIon.body:getY()-ion.body:getY())))
			end
		end
	end
end

function love.draw()
	ions.Ion:draw()
end