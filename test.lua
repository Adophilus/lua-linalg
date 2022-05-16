local lui = require("lui")

local vector_1 = lui.Vector({ 1, 0, 1 })
local vector_2 = lui.Vector({ 0, 1, 0 })

print("Vector 1:", vector_1)
print("Vector 2:", vector_2)

print()

print("Vector 1 + Vector 2:", vector_1 + vector_2)
print("Vector 1 - Vector 2:", vector_1 - vector_2)
print("Vector 1 × Vector 2:", vector_1 * vector_2)
print("Vector 1 • Vector 2:", vector_1 * vector_2)
print("5 × Vector 1:", vector_1 * 5)
print("5 ÷ Vector 1:", vector_1 / 5)
