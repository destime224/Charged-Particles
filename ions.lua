local module = {}


module.Ion = {}
module.Ion.__index = module.Ion

module.Ion.objects = {}

function module.Ion:new(world,x,y,charge)
	local object = {}
	
	object.charge = charge
	object.body = love.physics.newBody(world,x,y,"dynamic")
	object.shape = love.physics.newCircleShape(love.graphics.getWidth() * 0.01)
	--[[
		Я установил массу в 1 единицу. Если постовить истиную массу частицы
		(69/10^27), то частицы обретают нестандартное поведение
	]]
	object.fixture=love.physics.newFixture(object.body, object.shape, 1)
	
	setmetatable(object,self)
	table.insert(self.objects,object)
	return object
end

function module.Ion:draw()

	for i, ion in pairs(self.objects) do
		if ion.charge <= -1 then
			love.graphics.setColor(0.9,0.2,0.2)
		elseif ion.charge >= 1 then
			love.graphics.setColor(0.2,0.2,0.9)
		else
			love.graphics.setColor(0.6,0.6,0.6)
		end
		
		love.graphics.circle("fill", ion.body:getX(), ion.body:getY(), ion.shape:getRadius())
	end
end

--[[
function module.Part.new(x,y,ch)
	local object = {x=x, y=y, charge=ch}
	
	
	function object.render()
		if object.charge >= 1 then
			love.graphics.setColor(0.2,0.2,0.9)
		elseif object.charge <= -1 then
			love.graphics.setColor(0.9,0.2,0.2)
		else 
			love.graphics.setColor(0.7,0.7,0.7)
		end
		love.graphics.circle("fill",object.x,object.y,tool.minMax(object.charge,8,15),25)
		
		love.graphics.setColor(0,0,0)
		tool.drawCenteredText(object.charge, object.x, object.y)
	end
	
	
	setmetatable(object,module.Part)
	module.Part.__index = module.Part
	return object
end
]]

return module