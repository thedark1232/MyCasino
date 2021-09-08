local component = require("component")
local term = require("term")
local event = require("event")
local casino = require("casino")
local buffer = require("doubleBuffering")
math.randomseed(os.time())
local wheelPositions = {}
local no_random_number = 99
local first_no_random = true --first number is random?
local no_random = true
local no_win_forever = false
wheelPositions[37] = {["left2"] = 3, ["left1"] = 26, ["center"] = 0, ["right1"] = 32, ["right2"] = 15}
wheelPositions[1] = {["left2"] = 16, ["left1"] = 33, ["center"] = 1, ["right1"] = 20, ["right2"] = 14}
wheelPositions[2] = {["left2"] = 4, ["left1"] = 21, ["center"] = 2, ["right1"] = 25, ["right2"] = 17}
wheelPositions[3] = {["left2"] = 12, ["left1"] = 35, ["center"] = 3, ["right1"] = 26, ["right2"] = 0}
wheelPositions[4] = {["left2"] = 15, ["left1"] = 19, ["center"] = 4, ["right1"] = 21, ["right2"] = 2}
wheelPositions[5] = {["left2"] = 23, ["left1"] = 10, ["center"] = 5, ["right1"] = 24, ["right2"] = 16}
wheelPositions[6] = {["left2"] = 17, ["left1"] = 27, ["center"] = 6, ["right1"] = 34, ["right2"] = 13}
wheelPositions[7] = {["left2"] = 18, ["left1"] = 29, ["center"] = 7, ["right1"] = 28, ["right2"] = 12}
wheelPositions[8] = {["left2"] = 11, ["left1"] = 30, ["center"] = 8, ["right1"] = 23, ["right2"] = 10}
wheelPositions[9] = {["left2"] = 14, ["left1"] = 31, ["center"] = 9, ["right1"] = 22, ["right2"] = 18}
wheelPositions[10] = {["left2"] = 8, ["left1"] = 23, ["center"] = 10, ["right1"] = 5, ["right2"] = 24}
wheelPositions[11] = {["left2"] = 13, ["left1"] = 36, ["center"] = 11, ["right1"] = 30, ["right2"] = 8}
wheelPositions[12] = {["left2"] = 7, ["left1"] = 28, ["center"] = 12, ["right1"] = 35, ["right2"] = 3}
wheelPositions[13] = {["left2"] = 6, ["left1"] = 34, ["center"] = 13, ["right1"] = 36, ["right2"] = 11}
wheelPositions[14] = {["left2"] = 1, ["left1"] = 20, ["center"] = 14, ["right1"] = 31, ["right2"] = 9}
wheelPositions[15] = {["left2"] = 0, ["left1"] = 32, ["center"] = 15, ["right1"] = 19, ["right2"] = 4}
wheelPositions[16] = {["left2"] = 5, ["left1"] = 24, ["center"] = 16, ["right1"] = 33, ["right2"] = 1}
wheelPositions[17] = {["left2"] = 2, ["left1"] = 25, ["center"] = 17, ["right1"] = 27, ["right2"] = 6}
wheelPositions[18] = {["left2"] = 9, ["left1"] = 22, ["center"] = 18, ["right1"] = 29, ["right2"] = 7}
wheelPositions[19] = {["left2"] = 32, ["left1"] = 15, ["center"] = 19, ["right1"] = 4, ["right2"] = 21}
wheelPositions[20] = {["left2"] = 33, ["left1"] = 1, ["center"] = 20, ["right1"] = 14, ["right2"] = 31}
wheelPositions[21] = {["left2"] = 19, ["left1"] = 4, ["center"] = 21, ["right1"] = 2, ["right2"] = 25}
wheelPositions[22] = {["left2"] = 31, ["left1"] = 9, ["center"] = 22, ["right1"] = 18, ["right2"] = 29}
wheelPositions[23] = {["left2"] = 30, ["left1"] = 8, ["center"] = 23, ["right1"] = 10, ["right2"] = 5}
wheelPositions[24] = {["left2"] = 10, ["left1"] = 5, ["center"] = 24, ["right1"] = 16, ["right2"] = 33}
wheelPositions[25] = {["left2"] = 21, ["left1"] = 2, ["center"] = 25, ["right1"] = 17, ["right2"] = 27}
wheelPositions[26] = {["left2"] = 35, ["left1"] = 3, ["center"] = 26, ["right1"] = 0, ["right2"] = 32}
wheelPositions[27] = {["left2"] = 25, ["left1"] = 17, ["center"] = 27, ["right1"] = 6, ["right2"] = 34}
wheelPositions[28] = {["left2"] = 29, ["left1"] = 7, ["center"] = 28, ["right1"] = 12, ["right2"] = 35}
wheelPositions[29] = {["left2"] = 22, ["left1"] = 18, ["center"] = 29, ["right1"] = 7, ["right2"] = 28}
wheelPositions[30] = {["left2"] = 36, ["left1"] = 11, ["center"] = 30, ["right1"] = 8, ["right2"] = 23}
wheelPositions[31] = {["left2"] = 20, ["left1"] = 14, ["center"] = 31, ["right1"] = 9, ["right2"] = 22}
wheelPositions[32] = {["left2"] = 26, ["left1"] = 0, ["center"] = 32, ["right1"] = 15, ["right2"] = 19}
wheelPositions[33] = {["left2"] = 24, ["left1"] = 16, ["center"] = 33, ["right1"] = 1, ["right2"] = 20}
wheelPositions[34] = {["left2"] = 27, ["left1"] = 6, ["center"] = 34, ["right1"] = 13, ["right2"] = 36}
wheelPositions[35] = {["left2"] = 28, ["left1"] = 12, ["center"] = 35, ["right1"] = 3, ["right2"] = 26}
wheelPositions[36] = {["left2"] = 34, ["left1"] = 13, ["center"] = 36, ["right1"] = 11, ["right2"] = 30}
local values = { [0] = 'z', 'r', 'b', 'r', 'b', 'r', 'b', 'r', 'b', 'r', 'b', 'b', 'r', 'b', 'r', 'b', 'r', 'b', 'r', 'r', 'b', 'r', 'b', 'r', 'b', 'r', 'b', 'r', 'b', 'b', 'r', 'b', 'r', 'b', 'r', 'b', 'r' }
local wheel = { 0, 32, 15, 19, 4, 21, 2, 25, 17, 34, 6, 27, 13, 36, 11, 30, 8, 23, 10, 5, 24, 16, 33, 1, 20, 14, 31, 9, 22, 18, 29, 7, 28, 12, 35, 3, 26, 0, 32, 15, 19, 4, 21, 2, 25, 17 }
local red = { 1, 3, 5, 7, 9, 12, 14, 16, 18, 19, 21, 23, 25, 27, 30, 32, 34, 36 }
local black = { 2, 4, 6, 8, 10, 11, 13, 15, 17, 20, 22, 24, 26, 28, 29, 31, 33, 35 }
local bets = {}

local consoleLines = { "", "", "", "", "", "", "", "", "" }
function sort_mode(a, b)
    return a[2] < b[2]
end

local function message(msg)
    table.remove(consoleLines, 1)
    table.insert(consoleLines, msg)
    buffer.drawRectangle(3, 23, 71, 9, 0x002f15, 0xffffff, " ")
    for i = 1, #consoleLines do
        buffer.drawText(4, 32 - i, (15 - #consoleLines + i) * 0x111111, consoleLines[i])
    end
    buffer.drawChanges()
end

local function drawNumber(left, top, number) -- requires redraw changes
    local background = values[number] == 'r' and 0xff0000 or values[number] == 'b' and 0x000000 or 0x00ff00
    buffer.drawRectangle(left, top, 6, 3, background, 0xffffff, " ")
    buffer.drawText(left + 2, top + 1, 0xffffff, tostring(number))
end

local function getNumberPostfix(number)
    if (number == 0) then
        return ""
    end
    for i = 1, #red do
        if (red[i] == number) then
            return "(красное)"
        end
    end
    return "(чёрное)"
end

local function drawStatic()
    buffer.setResolution(112, 32)
    buffer.clear(0xffffff)
    buffer.drawText(103, 14, 0x000000, "Ставки:")
    buffer.drawText(103, 15, 0x000000, "ЛКМ 1$")
    buffer.drawText(103, 16, 0x000000, "ПКМ 10$")
    buffer.drawRectangle(13, 2, 5, 11, 0x34a513, 0xffffff, ' ')
    buffer.drawText(15, 7, 0xffffff, "0")
    for i = 1, 36 do
        drawNumber(19 + math.floor((i - 1) / 3) * 7, 2 + ((3 - i) % 3 * 4), i)
    end
    buffer.drawRectangle(103, 2,  9,  3, 0x34a513, 0xffffff, ' ')
    buffer.drawRectangle(103, 6,  9,  3, 0x34a513, 0xffffff, ' ')
    buffer.drawRectangle(103, 10, 9,  3, 0x34a513, 0xffffff, ' ')
    buffer.drawRectangle(19,  14, 27, 3, 0x34a513, 0xffffff, ' ')
    buffer.drawRectangle(47,  14, 27, 3, 0x34a513, 0xffffff, ' ')
    buffer.drawRectangle(75,  14, 27, 3, 0x34a513, 0xffffff, ' ')
    buffer.drawRectangle(19,  18, 13, 3, 0x34a513, 0xffffff, ' ')
    buffer.drawRectangle(33,  18, 13, 3, 0x34a513, 0xffffff, ' ')
    buffer.drawRectangle(75,  18, 13, 3, 0x34a513, 0xffffff, ' ')
    buffer.drawRectangle(89,  18, 13, 3, 0x34a513, 0xffffff, ' ')
    buffer.drawText(106, 3, 0xffffff, "2к1")
    buffer.drawText(106, 7, 0xffffff, "2к1")
    buffer.drawText(106, 11, 0xffffff, "2к1")
    buffer.drawText(28, 15, 0xffffff, "первая 12")
    buffer.drawText(56, 15, 0xffffff, "вторая 12")
    buffer.drawText(84, 15, 0xffffff, "третья 12")
    buffer.drawText(22, 19, 0xffffff, "1 до 18")
    buffer.drawText(38, 19, 0xffffff, "Чёт")
    buffer.drawText(79, 19, 0xffffff, "Нечёт")
    buffer.drawText(91, 19, 0xffffff, "19 до 36")
    buffer.drawRectangle(75, 29, 36, 3,  0xff0000, 0xffffff, ' ')
    buffer.drawRectangle(75, 25, 36, 3,  0x34a513, 0xffffff, ' ')
    buffer.drawRectangle(47, 18, 13, 3,  0xff0000, 0xffffff, ' ')
    buffer.drawRectangle(3,  2,  8,  19, 0xffb109, 0xffffff, ' ')
    buffer.drawRectangle(3,  9,  8,  5,  0xffda54, 0xffffff, ' ')
    buffer.drawRectangle(61, 18, 13, 3,  0x000000, 0xffffff, ' ')
    buffer.drawRectangle(3,  22, 71, 10, 0xaaaaaa, 0xffffff, ' ')
    buffer.drawRectangle(3,  23, 71, 9,  0x002f15, 0xffffff, " ")
    buffer.drawRectangle(75, 22, 36, 1,  0xaaaaaa, 0xffffff, ' ')
    buffer.drawRectangle(75, 23, 36, 1,  0x002f15, 0xffffff, ' ')
    buffer.drawText(89, 26, 0xffffff, "Крутить")
    buffer.drawText(90, 30, 0xffffff, "Выход")
    buffer.drawText(50, 19, 0xffffff, "Красное")
    buffer.drawText(64, 19, 0xffffff, "Чёрное")
    buffer.drawText(4,  22, 0x000000, "Вывод:")
    buffer.drawText(76, 22, 0x000000, "Текущая валюта:")
    buffer.drawText(76, 23, 0xffffff, casino.getCurrency().name or "")
    buffer.drawChanges()
end

local function Roll()
    local current = math.random(1, 35)
    for i = 1, math.random(30, 50) do
        current = current + 1
        if (current == 38) then
            current = 1
        end
        drawNumber(4, 2, wheel[current + 4])
        drawNumber(4, 6, wheel[current + 3])
        drawNumber(4, 10, wheel[current + 2])
        drawNumber(4, 14, wheel[current + 1])
        drawNumber(4, 18, wheel[current])
        buffer.drawChanges()
        os.sleep(i / 140)
    end
    if first_no_random and no_random then
        if not no_win_forever then first_no_random = false end
        local all_zero_bets = {}
        for k, v in ipairs(bets) do
            if v == 0 then
                all_zero_bets[#all_zero_bets + 1] = k            
            end
        end
         if #all_zero_bets > 1 then
            local rnd
            repeat rnd = math.random(1, #all_zero_bets) until rnd ~= no_random_number
            no_random_number = rnd
            drawNumber(4, 2, wheelPositions[all_zero_bets[rnd]].left2)
            drawNumber(4, 6, wheelPositions[all_zero_bets[rnd]].left1)
            drawNumber(4, 10, wheelPositions[all_zero_bets[rnd]].center)
            drawNumber(4, 14, wheelPositions[all_zero_bets[rnd]].right1)
            drawNumber(4, 18, wheelPositions[all_zero_bets[rnd]].right2)
            buffer.drawChanges()
            return wheelPositions[all_zero_bets[rnd]].center
        end
        local sort_bets ={}
        for k, v in ipairs(bets) do
            sort_bets[k] = {k, v}
        end
        table.sort(sort_bets, sort_mode)      
        local one_two_tree
        ::again::
        one_two_tree = math.random(1,3)
        if wheelPositions[sort_bets[one_two_tree][1]].center == no_random_number then
            goto again
        else
            no_random_number = wheelPositions[sort_bets[one_two_tree][1]].center
        end
        drawNumber(4, 2, wheelPositions[sort_bets[one_two_tree][1]].left2)
            drawNumber(4, 6, wheelPositions[sort_bets[one_two_tree][1]].left1)
            drawNumber(4, 10, wheelPositions[sort_bets[one_two_tree][1]].center)
            drawNumber(4, 14, wheelPositions[sort_bets[one_two_tree][1]].right1)
            drawNumber(4, 18, wheelPositions[sort_bets[one_two_tree][1]].right2)
            buffer.drawChanges()
        return wheelPositions[sort_bets[one_two_tree][1]].center
    else
        first_no_random = true
    end
    return wheel[current + 2]
end

local function getNumberClick(left, top)
    if (top == 5) or (top == 9) or (left % 7 == 4) then
        return 0
    end
    return (math.floor((left - 18) / 7) * 3) + math.floor(4 - (top - 1) / 4)
end

local function resetBets()
    bets = {}
    for i = 0, 36 do
        bets[i] = 0
    end
end

local function placeBet(number, money)
    if (bets[number] == nil) then
        bets[number] = money
    else
        bets[number] = bets[number] + money
    end
end

local function placeBetByTable(t, money)
    for i = 1, #t do
        placeBet(t[i], money)
    end
end

local function fixClicks(left, top) -- lol watta hell is this?
    return not (
        (left < 13) or (top < 2) or (left > 111) or (top > 20) or (left < 19 and top > 12) or (left == 18) or (left == 46) or (left == 102) or 
        (top == 12) or (top == 17) or (((left > 18) and (left < 102) and (top > 1) and (top < 13)) and getNumberClick(left, top) == 0) or 
        (top > 17 and top < 21 and (left == 32 or left == 46 or left == 60 or left == 74 or left == 88)) or (left > 101 and top > 12) or 
        (left > 102 and (top == 5 or top == 9)))
end

drawStatic()
message("")
while true do
    resetBets()
    local ready = false
    while true do
        local e, _, left, top, clickType, _ = event.pull("touch")
        if (e ~= nil) then
            local number, money = 0, 1 + clickType * 9
            if left >= 75 and left <= 110 and top >= 29 and top <= 31 then
                if ready then
                    message("Сначала завершите игру")
                else
                    error("Exit by request")
                end
            end
            if left >= 75 and left <= 110 and top >= 25 and top <= 27 then
                if ready then
                    break
                else
                    message("Недоступно до первой ставки")
                end
            end
            if (fixClicks(left, top)) then
                local payed, reason = casino.takeMoney(money)
                if payed then
                    ready = true
                    if (left > 18) and (left < 102) and (top > 1) and (top < 13) then
                        number = getNumberClick(left, top)
                    end
                    if number > 0 then
                        placeBet(number, money * 36)
                        message("Вы поставили " .. money .. " на " .. number)
                    elseif (left > 12) and (left < 18) and (top > 1) and (top < 13) then
                        message("Вы поставили " .. money .. " на 0")
                        placeBet(0, money * 36)
                    elseif (left > 18) and (left < 46) and (top > 13) and (top < 17) then
                        message("Вы поставили " .. money .. " на первую 12")
                        money = money * 3
                        for i = 1, 12 do
                            placeBet(i, money)
                        end
                    elseif (left > 46) and (left < 74) and (top > 13) and (top < 17) then
                        message("Вы поставили " .. money .. " на вторую 12")
                        money = money * 3
                        for i = 13, 24 do
                            placeBet(i, money)
                        end
                    elseif (left > 74) and (left < 102) and (top > 13) and (top < 17) then
                        message("Вы поставили " .. money .. " на третью 12")
                        money = money * 3
                        for i = 25, 36 do
                            placeBet(i, money)
                        end
                    elseif (left > 18) and (left < 32) and (top > 17) and (top < 21) then
                        message("Вы поставили " .. money .. " на 1 до 18")
                        money = money * 2
                        for i = 1, 18 do
                            placeBet(i, money)
                        end
                    elseif (left > 32) and (left < 46) and (top > 17) and (top < 21) then
                        message("Вы поставили " .. money .. " на чётное")
                        money = money * 2
                        for i = 2, 36, 2 do
                            placeBet(i, money)
                        end
                    elseif (left > 46) and (left < 60) and (top > 17) and (top < 21) then
                        message("Вы поставили " .. money .. " на красное")
                        placeBetByTable(red, money * 2)
                    elseif (left > 60) and (left < 74) and (top > 17) and (top < 21) then
                        message("Вы поставили " .. money .. " на чёрное")
                        placeBetByTable(black, money * 2)
                    elseif (left > 74) and (left < 88) and (top > 17) and (top < 21) then
                        message("Вы поставили " .. money .. " на нечётное")
                        money = money * 2
                        for i = 1, 35, 2 do
                            placeBet(i, money)
                        end
                    elseif (left > 88) and (left < 102) and (top > 17) and (top < 21) then
                        message("Вы поставили " .. money .. " на 19 до 36")
                        money = money * 2
                        for i = 19, 36 do
                            placeBet(i, money)
                        end
                    elseif (left > 102) and (left < 112) and (top > 1) and (top < 5) then
                        message("Вы поставили " .. money .. " на 2к1 (верхний ряд)")
                        money = money * 3
                        for i = 3, 36, 3 do
                            placeBet(i, money)
                        end
                    elseif (left > 102) and (left < 112) and (top > 5) and (top < 9) then
                        message("Вы поставили " .. money .. " на 2к1 (средний ряд)")
                        money = money * 3
                        for i = 2, 35, 3 do
                            placeBet(i, money)
                        end
                    elseif (left > 102) and (left < 112) and (top > 9) and (top < 13) then
                        message("Вы поставили " .. money .. " на 2к1 (нижний ряд)")
                        money = money * 3
                        for i = 1, 34, 3 do
                            placeBet(i, money)
                        end
                    end
                else
                    message(reason)
                end
            end
        end
    end
    message("Колесо крутится... Сумма ставок на игру: " .. (function()
        local sum = 0
        for k, v in pairs(bets) do
            sum = sum + v
        end
        return sum / 36
    end)())
    local out = Roll()
    message("Выпало число " .. out .. " " .. getNumberPostfix(out))
    if bets[out] then
        casino.reward(bets[out])
        message("Вы выиграли " .. bets[out])
    end
    casino.gameIsOver()
end
    