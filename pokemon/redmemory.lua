local w = 25
local w2 = 60
local h = 27
local prev_val = {}
local change_counter = {}

function drawmemory(transx, transy, start_addr, numrows)
    for i = 1, numrows do
        for j = 0, 31 do
            local x = transx + w2 + w * j
            local y = transy + h * i
            local addr = start_addr + (i - 1) * 32 + j
            local val = memory.read_u8(addr)
            if prev_val[addr] ~= nil then
                if prev_val[addr] ~= val then
                    change_counter[addr] = 2
                end
            end
            if change_counter[addr] ~= nil and change_counter[addr] > 0 then
                gui.drawRectangle(x, y, w - 5, h - 5, nil, "#88ff0000")
                change_counter[addr] = change_counter[addr] - 1
            end
            prev_val[addr] = val
            gui.drawText(x, y + 5, string.format("%02x", val), "black", nil, nil, 7)
            
        end
    end
end

function main()
    gui.drawImageRegion("bg3.png", 160, 0, 1200 - 160, 900, 160, 0)
    gui.drawImageRegion("bg3.png", 0, 144, 1200, 900 - 144, 0, 144)
    drawmemory(180, 10, 0xd100, 23)
    drawmemory(180, 710, 0xd540, 3)
end

gui.clearImageCache()
client.SetGameExtraPadding(0, 0, 950, 700)




while true do
    if emu.framecount() % 15 == 0 then
        main()
    end

    emu.frameadvance()
  end