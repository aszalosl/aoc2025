require "minctest"
local test_table = {}
for line in io.lines("test04.txt") do
   table.insert(test_table, line)
end

local function getCh(x, y, table)
   if y < 1 or y > #table then
      return 0
   end
   if x < 1 or x > #(table[y]) then
      return 0
   end
   -- print("check ", x, y, string.sub(lines[y], x, x))
   if string.sub(table[y], x, x) == "@" then
      return 1
   else
      return 0
   end
end

lrun("get", function()
   lequal(getCh(5, 0, test_table), 0);
   lequal(getCh(0, 1, test_table), 0);
   lequal(getCh(1, 1, test_table), 0);
   lequal(getCh(10, 1, test_table), 0);
   lequal(getCh(1, 10, test_table), 1);
   lequal(getCh(1, 11, test_table), 0);
   lequal(getCh(11, 1, test_table), 0);
end)

-- lresults()

local function neighbours(x, y, table)
   local counter = 0
   counter = counter + getCh(x - 1, y - 1, table) + getCh(x, y - 1, table) + getCh(x + 1, y - 1, table)
   counter = counter + getCh(x - 1, y, table) + getCh(x + 1, y, table)
   counter = counter + getCh(x - 1, y + 1, table) + getCh(x, y + 1, table) + getCh(x + 1, y + 1, table)
   return counter
end

local function part1(file)
   local lines = {}
   for line in io.lines(file) do
      table.insert(lines, line)
   end
   local count = 0
   for y = 1, #lines do
      for x = 1, #(lines[y]) do
         if (getCh(x, y, lines) == 1) and (neighbours(x, y, lines) < 4) then
            count = count + 1
         end
      end
   end
   print("part 1: ", count)
end

part1("test04.txt")

local function one_round(table)
   local change = 0
   for y = 1, #table do
      for x = 1, #(table[y]) do
         if (getCh(x, y, table) == 1) and (neighbours(x, y, table) < 4) then
            change = change + 1
            table[y] = string.sub(table[y], 1, x - 1) .. "." .. string.sub(table[y], x + 1)
         end
      end
   end
   return change
end

local function part2(file)
   -- load
   local lines = {}
   for line in io.lines(file) do
      table.insert(lines, line)
   end
   -- removing
   local count = 0
   repeat
      local ch = one_round(lines)
      count = count + ch
   until (ch == 0)
   print("part 2:", count)
end

-- part2("test04.txt")
part2("input04.txt")
