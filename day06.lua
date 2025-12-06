-- Day 6
require "minctest"

function Part1(file)
   local lines = {}
   local operators = {}
   local results = {}
   -- read in
   for line in io.lines(file) do
      table.insert(lines, line)
   end
   for x in string.gmatch(lines[#lines], "%S") do
      table.insert(operators, x)
      if x == "+" then
         table.insert(results, 0)
      else
         table.insert(results, 1)
      end
   end
   for i = 1, #lines - 1 do
      local j = 1
      for x in string.gmatch(lines[i], "%d+") do
         local xn = tonumber(x)

         if operators[j] == "+" then
            results[j] = results[j] + xn
         else
            results[j] = results[j] * xn
         end
         j = j + 1
      end
   end
   local sum = 0
   for _, v in ipairs(results) do
      sum = sum + v
   end
   print("Part 1:", sum)
end

--Part1("test06.txt")
-- Part1("input06.txt")


function Part2(file)
   local lines = {}
   local results = {}
   local bigSum = 0
   local result = 0
   local maxLength = 0
   -- read in
   for line in io.lines(file) do
      table.insert(lines, line)
      if #line > maxLength then
         maxLength = #line
      end
   end
   local operator = ""
   local operator_line = lines[#lines]

   for i = 1, maxLength do
      local last_char = string.sub(operator_line, i, i)
      if (last_char == "+") or (last_char == "*") then
         operator = last_char
         bigSum = bigSum + result
         if operator == "+" then
            result = 0
         else
            result = 1
         end
      end
      local number = ""
      for j = 1, #lines - 1 do
         local char = string.sub(lines[j], i, i)
         if string.match(char, "%d") then
            number = number .. char
         end
      end

      if #number > 0 then
         local num = tonumber(number)
         if operator == "+" then
            result = result + num
         else
            result = result * num
         end
      end
   end
   bigSum = bigSum + result
   print("Part 2:", bigSum)
end

-- Part2("test06.txt")
Part2("input06.txt")
