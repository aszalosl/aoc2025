require "minctest"
require "BigNum"
local bigsum = BigNum.new(0)

local function concatString(a, b)
   local c = a .. b
   return tonumber(c)
end

local function concatNumber(a, b)
   local as = tostring(a)
   local bs = tostring(b)
   return concatString(as, bs)
end

local function searchInvalid(a1, a2, power, b)
   local original = a1 * power + a2
   local interval_sum = 0
   local invalidNumber

   while a1 * power + a1 < original do
      a1 = a1 + 1
   end

   while a1 * power + a1 <= b do
      invalidNumber = a1 * power + a1
      if concatNumber(a1, a1) == invalidNumber then
         interval_sum = interval_sum + invalidNumber
      end
      a1 = a1 + 1
   end
   return interval_sum
end

local function handleInterval(pair)
   local b, _ = string.find(pair, "-")
   if b % 2 == 0 then
      pair = "0" .. pair
      b, _ = string.find(pair, "-")
   end
   local l = b - ((b - 1) // 2) - 1
   local first_begin = tonumber(string.sub(pair, 1, (b - 1) // 2))
   local first_end = tonumber(string.sub(pair, (b - 1) // 2 + 1, b - 1))
   local second = tonumber(string.sub(pair, b + 1))
   local result = searchInvalid(first_begin, first_end, 10 ^ l, second)
   BigNum.add(bigsum, BigNum.new(result), bigsum)
end

local function part1(filename)
   io.input(filename)
   local line = io.read("l")
   for pair in string.gmatch(line, "[0-9-]+") do
      print("> " .. pair)
      handleInterval(pair)
   end
   return tostring(bigsum)
end


lrun("Invalid", function()
   lequal(searchInvalid(1, 1, 10, 22), 11 + 22);
   lequal(searchInvalid(9, 5, 10, 115), 99);
   lequal(searchInvalid(9, 98, 100, 1012), 1010);
   lequal(searchInvalid(11885, 11880, 100000, 1188511890), 1188511885);
   lequal(searchInvalid(222, 220, 1000, 222224), 222222);
   lequal(searchInvalid(169, 8522, 10000, 1698528), 0);
   lequal(searchInvalid(446, 443, 1000, 446449), 446446);
   lequal(searchInvalid(3859, 3856, 10000, 38593862), 38593859);
   lequal(searchInvalid(2, 93, 100, 351), 0);
end)

--print(lresults())
-- print(part1("test02.txt"))
--print(part1("input02.txt"))

local sum = 0

local function checkNumber(s)
   local sLen = #s
   local i = 2
   while i <= sLen // 2 + 1 do
      local left1, right2 = string.sub(s, 1, sLen - i + 1), string.sub(s, i)
      local left2, right1 = string.sub(s, sLen - i + 2), string.sub(s, 1, i - 1)
      -- print(left1 .. " - " .. right2 .. ' and ' .. left2 .. ' - ' .. right1)
      if (left1 == right2) and (left2 == right1) then
         print(s)
         return tonumber(s)
      end
      i = i + 1
   end
   return 0
end

lrun("checkNumber", function()
   lequal(checkNumber("111"), 111);
   lequal(checkNumber("1010"), 1010);
   lequal(checkNumber("1011"), 0);
   lequal(checkNumber("2121212121"), 2121212121);
   lequal(checkNumber("2121212122"), 0);
   lequal(checkNumber("121212"), 121212);
   lequal(checkNumber("101011"), 0);
   lequal(checkNumber('527552755'), 0);
end)


local function searchInterval(first, second)
   for number = first, second do
      local s = tostring(number|0)
      -- print(s)
      sum = sum + checkNumber(s)
   end
end


local function part2(filename)
   io.input(filename)
   local line = io.read("l")
   for pair in string.gmatch(line, "[0-9-]+") do
      local b, _ = string.find(pair, "-")
      local first = string.sub(pair, 1, b - 1)
      local second = string.sub(pair, b + 1)
      print(first, " - ", second)
      searchInterval(first, second)
   end
   print(sum)
end

-- print(lresults())
-- print(part2("test02.txt"))
print(part2("input02.txt"))
