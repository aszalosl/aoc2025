-- Day 5
require "minctest"

function Part1(file)
   local fresh = {}
   local fresh_ingredients = 0
   for line in io.lines(file) do
      print("Line:", line)
      local numbers = {}
      if line:match("-") then
         for w in string.gmatch(line, "%d+") do
            table.insert(numbers, tonumber(w))
         end
         table.insert(fresh, numbers)
      elseif line ~= '' then
         local n = tonumber(line)
         local good = 0
         for k, v in ipairs(fresh) do
            local v1 = v[1]
            local v2 = v[2]
            if (v1 <= n) and (n <= v2) then
               print(v1, '<', n, '<', v2, " : ", fresh_ingredients)
               good = 1
            end
         end
         if good == 1 then
            fresh_ingredients = fresh_ingredients + 1
         end
      end
   end
   print("Part 1:", fresh_ingredients)
end

-- Part1("test05.txt")
-- Part1("input05.txt")
local function first(s)
   local pos = s:find('-')
   return s:sub(1, pos - 1)
end
local function second(s)
   local pos = s:find('-')
   return s:sub(pos + 1)
end

local function blow_up(line, size)
   local zeros = '000000000000000000000000000'
   local first_str, second_str = first(line), second(line)
   local f_add, s_add = size - #first_str, size - #second_str
   return zeros:sub(1, f_add) .. first_str .. '-' .. zeros:sub(1, s_add) .. second_str
end

local function intervalLength(begin_, end_)
   local beginN = tonumber(begin_)
   local endN = tonumber(end_)
   print(beginN, endN, endN - beginN + 1)
   return endN - beginN + 1
end

lrun("blow_up", function()
   lequal(blow_up("3-5", 2), "03-05");
   lequal(blow_up("3-5", 4), "0003-0005");
   lequal(blow_up("3-500", 4), "0003-0500");
   lequal(blow_up("3-500", 3), "003-500");
end)

function Part2(file)
   local intervals = {}
   local maxLen = 0
   -- read in
   for line in io.lines(file) do
      if line == "" then
         break
      end
      table.insert(intervals, line)
      if #line > maxLen then
         maxLen = #line
      end
   end

   -- unify the length of the numbers
   local standardized = {}
   local size = math.ceil((maxLen - 1) / 2)
   for _, l in pairs(intervals) do
      if #l == maxLen then
         table.insert(standardized, l)
      else
         table.insert(standardized, blow_up(l, size))
      end
   end
   -- sorted
   table.sort(standardized)

   -- merge
   local totalLength = 0
   local firstBegin, firstEnd = "1", "0" -- an empty interval, not a one-length

   for _, n in pairs(standardized) do
      local secondBegin, secondEnd = first(n), second(n)
      if secondBegin > firstEnd then
         local begin = tonumber(firstBegin)
         local end_ = tonumber(firstEnd)
         totalLength = totalLength + intervalLength(firstBegin, firstEnd)
         firstBegin, firstEnd = secondBegin, secondEnd
      elseif firstEnd < secondEnd then
         firstEnd = secondEnd
      else
         ;
      end
   end
   totalLength = totalLength + intervalLength(firstBegin, firstEnd)
   print("Part 2: ", totalLength)
end

-- Part2("test05.txt")
Part2("input05.txt")
--lresults()
