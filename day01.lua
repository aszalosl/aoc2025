-- Day #1
local function part1(file)
   local counter = 50
   local zeros = 0
   for line in io.lines(file) do
      local number = tonumber(string.sub(line, 2))
      if string.sub(line, 1, 1) == 'L' then
         counter = (counter - number) % 100
      elseif string.sub(line, 1, 1) == 'R' then
         counter = (counter + number) % 100
      else
         error("wrong first character" .. string.sub(line, 1, 1))
      end
      -- print(counter, " ", zeros)
      if counter == 0 then
         zeros = zeros + 1
      end
   end
   return zeros
end

local function part2(file)
   local counter = 50
   local zeros = 0
   local increment = 0
   for line in io.lines(file) do
      local number = tonumber(string.sub(line, 2))
      if string.sub(line, 1, 1) == 'L' then
         if counter == 0 then
            counter = 100
         end
         if number >= counter then
            increment = 1 + (number - counter) // 100
            zeros = zeros + increment
         end
         counter = (counter - number) % 100
      elseif string.sub(line, 1, 1) == 'R' then
         if (counter + number) >= 100 then
            increment = (number + counter) // 100
            zeros = zeros + increment
         end
         counter = (counter + number) % 100
      else
         error("wrong first character" .. string.sub(line, 1, 1))
      end
   end
   return zeros
end
-- print(part1("test01.txt"))
print("Part 1: ", part1("input01.txt"))
-- print(part2("test01.txt"))
print("Part 2:", part2("input01.txt"))
