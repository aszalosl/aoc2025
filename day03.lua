require "minctest"
local joltage_sum = 0

local function maxi(s)
   local max_value, max_place = "0", 0
   for i = 1, #s do
      -- print(i, string.sub(s, i, i), max_value, max_place)
      if string.sub(s, i, i) > max_value then
         max_value, max_place = string.sub(s, i, i), i
      end
   end
   return max_value, max_place
end

local function part1(file)
   joltage_sum = 0
   for line in io.lines(file) do
      -- print(line, #line)
      local value, place = maxi(line)
      if place < #line then
         local value2, _ = maxi(string.sub(line, place + 1))
         joltage_sum = joltage_sum + value * 10 + value2
      else
         local value2, _ = maxi(string.sub(line, 1, place - 1))
         joltage_sum = joltage_sum + value2 * 10 + value
      end
   end
   return joltage_sum
end

-- print(part1("test03.txt"))
-- print(part1("input03.txt"))

local function stackBack(stack, value, limit, maxLength)
   --print("stack: '" .. stack .. "', value: ", value, "  limit:", limit)
   if stack == "" then
      return value
   end
   local i = math.min(#stack, limit)
   local stackLength = #stack
   --print(" i", i, " stack:", stack, " length: ", stackLength, "last char: ", string.sub(stackLength, stackLength))
   while (i > 0) and (string.sub(stack, stackLength, stackLength) < value) do
      -- print(string.sub(stack, stackLength, stackLength), " vs ", value)
      i = i - 1
      stackLength = stackLength - 1
   end
   if i == 0 then
      -- print("case a", stackLength)
      if stackLength < maxLength then
         return string.sub(stack, 1, stackLength) .. value
      else
         return string.sub(stack, 1, stackLength)
      end
   elseif (string.sub(i, i) < value) and (stackLength < maxLength) then
      -- print("case b", i, stackLength)
      return string.sub(stack, 1, stackLength) .. value
   else
      -- print("case c", i, stackLength)
      return string.sub(stack, 1, stackLength)
   end
end


lrun("stackBack", function()
   lequal(stackBack("1", "2", 3, 2), "2");
   lequal(stackBack("2", "1", 3, 2), "2");
   lequal(stackBack("2", "1", 1, 2), "2");
   lequal(stackBack("2", "3", 1, 2), "3");
   lequal(stackBack("2", "3", 1, 2), "3");
   lequal(stackBack("23", "4", 0, 3), "234");
   lequal(stackBack("23", "4", 1, 2), "24");
   lequal(stackBack("43", "2", 2, 3), "432");
end)

-- ciklus vegig a soron, parameter a szam hossza
local function manageLine(line, numberLength)
   local stack = ""
   for i = 1, #line do
      local limit = #stack + #line - i - numberLength + 1
      --print("#s: ", #stack, " left:", #line - i, " limit: ", #stack + #line - i - numberLength)
      stack = stackBack(stack, string.sub(line, i, i), limit, numberLength)
      --print(stack, string.sub(line, i, i), limit)
   end
   return stack
end

lrun("manageLine", function()
   lequal(manageLine("12345", 3), "345");
   lequal(manageLine("54321", 3), "543");
   lequal(manageLine("14325", 3), "435");
   lequal(manageLine("987654321111111", 12), "987654321111")
   lequal(manageLine("811111111111119", 12), "811111111119");
   lequal(manageLine("234234234234278", 12), "434234234278");
   lequal(manageLine("818181911112111", 12), "888911112111");
end)

-- print(lresults())

local function part2(file)
   joltage_sum = 0
   for line in io.lines(file) do
      joltage_sum = joltage_sum + manageLine(line, 12)
   end
   return joltage_sum
end

--print(part2("test03.txt"))
print(part2("input03.txt"))
