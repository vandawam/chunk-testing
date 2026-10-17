local function _0xcff095f4(a, b)
    local a_low = bit32.band(a, 0xFFFF)
    local a_high = bit32.rshift(a, 16)
    local b_low = bit32.band(b, 0xFFFF)
    local b_high = bit32.rshift(b, 16)
    local low_prod = a_low * b_low
    local mid = bit32.band(a_low * b_high + a_high * b_low, 0xFFFF)
    return bit32.band(low_prod + bit32.lshift(mid, 16), 0xFFFFFFFF)
end
local function l_618bf(ctx, x_02072d1b, _0x40110a)
    local x_89795cd = ctx.z_6c996 or 0x6A09E667
    local x_79d17a98 = _0x40110a or 0
    local x_cf055 = bit32.bxor(bit32.lrotate(x_89795cd, 13), x_02072d1b)
    x_cf055 = bit32.bxor(x_cf055, bit32.rrotate(x_79d17a98, 5))
    x_cf055 = bit32.band(_0xcff095f4(x_cf055, 0x5BD1E995) + 0x165667B1, 0xFFFFFFFF)
    ctx.z_6c996 = x_cf055
    return x_cf055
end
local v_a4e294e = 805.51
local function v_ecf87(a, b)
    local x = bit32.bxor(a or 9117, 0x2597C305)
    local y = bit32.band(b or 0, 0xFFFF)
    local z = bit32.bor(x, y) + bit32.band(x, y)
    if z == 0x7F61AC8C then
        return bit32.lrotate(z, 5)
    end
    return bit32.bxor(z, 0x5A5A)
end
local function _0xcff095f4(a, b)
    local a_low = bit32.band(a, 0xFFFF)
    local a_high = bit32.rshift(a, 16)
    local b_low = bit32.band(b, 0xFFFF)
    local b_high = bit32.rshift(b, 16)
    local low_prod = a_low * b_low
    local mid = bit32.band(a_low * b_high + a_high * b_low, 0xFFFF)
    return bit32.band(low_prod + bit32.lshift(mid, 16), 0xFFFFFFFF)
end
local function x_bab61b6(ctx)
    local h = 2927402831
    local function mix(v)
        local n = tonumber(v)
        if n == nil then return end
        local l_3b26c7d = math.floor(n)
        h = bit32.bxor(bit32.lrotate(h, 5), bit32.band(l_3b26c7d, 0xFFFFFFFF))
        h = bit32.band(_0xcff095f4(h, 0x5BD1E995) + 0x165667B1, 0xFFFFFFFF)
    end
    local function mixStr(s)
        if type(s) ~= "string" then return end
        for l_3b26c7d = 1, #s do
            h = bit32.bxor(bit32.lrotate(h, 5), string.byte(s, l_3b26c7d))
            h = bit32.band(_0xcff095f4(h, 0x5BD1E995) + 0x165667B1, 0xFFFFFFFF)
        end
        h = bit32.bxor(h, 0x3A)
    end
    pcall(function()
        mixStr(game.ClassName)
        mixStr(typeof(game))
        mixStr(tostring(getmetatable(game)))
        mixStr(workspace.ClassName)
        mixStr(typeof(Vector3.new()))
    end)
    pcall(function()
        local cam = workspace.CurrentCamera
        if cam then
            local vp = cam.ViewportSize
            mix(vp.X)
            mix(vp.Y)
            local cf = cam.CFrame
            mix(cf.Position.X * 1000)
            mix(cf.Position.Y * 1000)
            mix(cf.Position.Z * 1000)
            mix(cf.Rotation.X * 100000)
            mix(cf.Rotation.Y * 100000)
        end
    end)
    pcall(function()
        local terrain = workspace:FindFirstChildWhichIsA("Terrain")
        if terrain then
            local tp = terrain.CFrame.Position
            mix(tp.X * 1000)
            mix(tp.Y * 1000)
            mix(tp.Z * 1000)
        end
        mix(workspace.Gravity * 1000)
        mix(workspace.DistributedGameTime * 1000)
        local L = game:GetService("Lighting")
        mix(L.Ambient.R * 10000)
        mix(L.Ambient.G * 10000)
        mix(L.Ambient.B * 10000)
    end)
    pcall(function()
        mix(gcinfo())
        mix(os.clock() * 1000000)
        mix(math.floor(tick() * 1000) % 1048576)
    end)
    if ctx then
        local carry = ctx.__entropy_carry
        if type(carry) == "number" then
            mix(carry)
        end
    end
    return h
end
local function l_f0d3efae(ox, oy, dx, dy)
    local tmin = -1000.0
    local tmax = 1000.0
    local ndx = dx ~= 0 and dx or 0.001
    local ndy = dy ~= 0 and dy or 0.001
    local tx1 = (-50.0 - ox) / ndx
    local tx2 = (50.0 - ox) / ndx
    tmin = math.max(tmin, math.min(tx1, tx2))
    tmax = math.min(tmax, math.max(tx1, tx2))
    local ty1 = (-50.0 - oy) / ndy
    local ty2 = (50.0 - oy) / ndy
    tmin = math.max(tmin, math.min(ty1, ty2))
    tmax = math.min(tmax, math.max(ty1, ty2))
    return tmax >= tmin and math.floor(tmin * 10) or -1
end
local function _0xb409453(x, y)
    local px = math.floor(x or 12.34)
    local py = math.floor(y or 56.78)
    local n = bit32.band(px * 374761393 + py * 668265263 + 48196, 0x7FFFFFFF)
    n = bit32.bxor(n, bit32.rshift(n, 13))
    n = bit32.band(n * 1274126177, 0x7FFFFFFF)
    return bit32.bxor(n, bit32.rshift(n, 16))
end
local v_2d1cb80e = {
    0x7e, 0x60, 0xcd, 0xaa, 0x42, 0xf0, 0x36, 0x07, 0xa8, 0x4c, 0x32, 0x8b, 0xf8, 0xd2,
}
local function __harvester_mul32(a, b)
    local a_low = bit32.band(a, 0xFFFF)
    local a_high = bit32.rshift(a, 16)
    local b_low = bit32.band(b, 0xFFFF)
    local b_high = bit32.rshift(b, 16)
    local low_prod = a_low * b_low
    local mid = bit32.band(a_low * b_high + a_high * b_low, 0xFFFF)
    return bit32.band(low_prod + bit32.lshift(mid, 16), 0xFFFFFFFF)
end
local function x_8746e8ab()
    local h = 0x6A09E667
    local _9ae1d599, mt = pcall(getmetatable, game)
    local items = { game.ClassName, _9ae1d599 and tostring(mt) or "", workspace.ClassName, typeof(game), typeof(Vector3.new()) }
    for j = 1, #items do
        local str = items[j]
        for l_3b26c7d = 1, #str do
            local b = string.byte(str, l_3b26c7d)
            h = bit32.bxor(bit32.lrotate(h, 5), b)
            h = bit32.band(__harvester_mul32(h, 0x5BD1E995) + 0x165667B1, 0xFFFFFFFF)
        end
        h = bit32.bxor(h, 0x3A)
    end
    local t = {}
    local pStr = tostring(t)
    if string.sub(pStr, 1, 7) ~= "table: " then
        h = bit32.bxor(h, 0xDEADBEEF)
    end
    if not (gcinfo() > 0 and workspace.DistributedGameTime >= 0) then
        h = bit32.bxor(h, 0xBAADC0DE)
    end
    return h
end
local function v_64a889(ctx)
    if type(ctx) ~= "table" then
        return
    end
    local __live = x_bab61b6(ctx)
    ctx.x_b2eebf71 = __live
    local x_365385 = true
    local _9ae1d599, z_88c24 = pcall(getmetatable, game)
    if _9ae1d599 and type(z_88c24) == "table" and rawget(z_88c24, "__index") == nil then
        x_365385 = false
    end
    local _0x2b11d1 = os.clock()
    local z_399b1d = 0
    for l_3b26c7d = 1, 1000 do
        z_399b1d = bit32.bxor(z_399b1d, (l_3b26c7d * 3))
    end
    local v_b34e72c = os.clock() - _0x2b11d1
    local v_c57965 = v_b34e72c < 2.0 and v_b34e72c >= 0.0
    local harvested = x_8746e8ab()
    local harvestOk = type(harvested) == "number" and harvested ~= 0
    ctx._0x243e86d = x_365385
    ctx.z_1ff299f7 = v_c57965
    if not (x_365385 and v_c57965 and harvestOk) then
        return
    end
    l_618bf(ctx, 912316167, 1182022632)
    local _d1 = l_f0d3efae(0, 0, 1, 0)
    local _d2 = _0xb409453(os.clock(), 42.0)
    local _d_aux = bit32.band(bit32.bxor(_d1 or 0, _d2 or 0), 0)
    ctx.z_6c996 = bit32.bxor(ctx.z_6c996 or 0x6A09E667, _d_aux)
    if type(ctx.x_9da737d) ~= "table" then ctx.x_9da737d = {} end
    local okSlot = pcall(function()
        ctx.x_9da737d[((bit32.rrotate(__live, 5) + 0) % 100) + 1] = v_2d1cb80e
    end)
    if not okSlot then return end
    ctx.l_b77f5cef = 0x4EF67C9B
end
return function(ctx)
    local __state = ctx.l_b77f5cef or 0x52A1992F
    if __state == 0x52A1992F then
        v_64a889(ctx)
    end
    return ctx
end