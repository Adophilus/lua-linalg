local lui = {}

lui = {
	Vector = function (vector)
		vector = vector or 1

		local self = {}

		local createEmptyVector = function (dimension, default)
			dimension = dimension or 1
			default = default or 0
			local vec = { }
			for i = 1, dimension do
				vec[i] = default
			end
			return vec
		end

		if (type(vector) == "number") then
			self.vector = createEmptyVector(vector)
		else
			self.vector = vector
		end

		self = {
			vector = vector,
			add  = function (vec)
				if (#self ~= #vec) then
					error("The dimensions of the vector do not match!")
				end

				local returnVector = lui.Vector(createEmptyVector(#self))
				for i = 1, #self.vector do
					returnVector.vector[i] = self.vector[i] + vec.vector[i]
				end

				return returnVector
			end,
			copy = function ()
				local returnVector = lui.Vector(createEmptyVector(#self))
				for i = 1, #self do
					returnVector[i] = self.vector[i]
				end
				return returnVector
			end,
			cross = function (vec)
				if (#self ~= 3 or #vec ~= 3) then
					error("Cross product can oly be calculated in 3d space!")
				end

				local returnVector = lui.Vector(createEmptyVector(3))
				returnVector[1] = (self.vector[2] * vec.vector[3]) - (self.vector[3] * vec.vector[2])
				returnVector[2] = (self.vector[3] * vec.vector[1]) - (self.vector[1] * vec.vector[3])
				returnVector[3] = (self.vector[1] * vec.vector[2]) - (self.vector[2] * vec.vector[1])

				return returnVector
			end,
			dot  = function (vec)
				if not (#self == #vec) then
					error("The dimensions of the vector do not match!")
				end

				local returnValue = 0
				for i = 1, #self do
					returnValue = returnValue + (self.vector[i] * vec.vector[i])
				end

				return returnValue
			end,
			empty = function (dimension, default)
				return createEmptyVector(dimension, default)
			end,
			minus = function (vec)
				if (#self ~= #vec) then
					error("The dimensions of the vector do not match!")
				end

				local returnVector = self.copy()
				for i = 1, #self do
					returnVector[i] = returnVector[i] - vec[i]
				end

				return returnVector
			end,
			scale = function (scalar)
				local returnVector = self.copy()
				for i = 1, #self do
					returnVector[i] = returnVector[i] * scalar
				end
				return returnVector
			end
		}

		return setmetatable(self, {
			__add = function (_, vec)
				return self.add(vec)
			end,
			__div = function (_, scalar)
				if (type(scalar) == "number") then
					return self.scale(1 / scalar)
				else
					return error("Invalid operation!")
				end
			end,
			__index = function (_, key)
				if (type(key) == "number") then
					return self.vector[key]
				else
					return error("Invalid index!")
				end
			end,
			__len = function ()
				return #self.vector
			end,
			__mul = function (_, vec)
				if (type(vec) == "number") then
					return self.scale(vec)
				else
					return self.cross(vec)
				end
			end,
			__newindex = function (_, key, value)
				if (type(key) == "number") then
					self.vector[key] = value
				else
					return error("Invalid index!")
				end
			end,
			__sub = function (_, vec)
				return self.minus(vec)
			end,
			__tostring = function ()
				return  "[ " .. table.concat(self.vector, "  ") .. " ]"
			end
		})
	end
}


return lui