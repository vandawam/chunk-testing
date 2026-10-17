local x_875b5ac3 = 811175
local v_1a599d2 = {
    0x4b, 0xf4, 0x09, 0x3c, 0x9c, 0x77, 0x31, 0x28, 0xeb, 0x71, 0x3a, 0x16, 0xda, 0x7d,
}
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
local l_442acd77 = 295497
local function l_2501d65(a, b)
    local x = bit32.bxor(a or 601, 0x6195F5C1)
    local y = bit32.band(b or 0, 0xFFFF)
    local z = bit32.bor(x, y) + bit32.band(x, y)
    if z == 0x5076F197 then
        return bit32.lrotate(z, 5)
    end
    return bit32.bxor(z, 0x5A5A)
end
local x_9b125e = 195472
local function v_a58dd891(q1x, q1y, q1z, q1w, t)
    local factor = math.clamp(t or 0.5, 0.0, 1.0)
    local invFactor = 1.0 - factor
    local rx = (q1x * invFactor) + (0.0 * factor)
    local ry = (q1y * invFactor) + (0.707 * factor)
    local rz = (q1z * invFactor) + (0.0 * factor)
    local rw = (q1w * invFactor) + (0.707 * factor)
    local mag = math.sqrt(rx * rx + ry * ry + rz * rz + rw * rw)
    return mag > 0.0001 and math.floor((ry / mag) * 1000) or 64
end
local function _1698d3(ox, oy, dx, dy)
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
local function _796314c(ctx)
    if type(ctx) ~= "table" then
        return
    end
    local __live = ctx.x_b2eebf71
    if type(__live) ~= "number" then
        return
    end
    l_618bf(ctx, 1196658277, 1228885426)
    local _d1 = v_a58dd891(0.0, 1.0, 0.0, 0.0, 0.25)
    local _d2 = _1698d3(0, 0, 1, 0)
    local _d_aux = bit32.band(bit32.bxor(_d1 or 0, _d2 or 0), 0)
    ctx.z_6c996 = bit32.bxor(ctx.z_6c996 or 0x6A09E667, _d_aux)
    if type(ctx.x_9da737d) ~= "table" then ctx.x_9da737d = {} end
    ctx.x_9da737d[((bit32.rrotate(__live, 5) + 5229) % 100) + 1] = v_1a599d2
    ctx.l_b77f5cef = 0x54C77B9B
end
return function(ctx)
    local __state = ctx.l_b77f5cef or 0x52A1992F
    if __state == 0x142B580F then
        _796314c(ctx)
    end
    return ctx
end