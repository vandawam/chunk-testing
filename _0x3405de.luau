local function _4c21c(a, b)
    local x = bit32.bxor(a or 3152, 0x65195D4E)
    local y = bit32.band(b or 0, 0xFFFF)
    local z = bit32.bor(x, y) + bit32.band(x, y)
    if z == 0x4C894D03 then
        return bit32.lrotate(z, 5)
    end
    return bit32.bxor(z, 0x5A5A)
end
local _0xcaed589f = {
    0x83, 0x2a, 0x4e, 0x3f, 0x2c, 0x2f, 0xa0, 0x93, 0x1e, 0x2d, 0xf2, 0x63, 0x43, 0xb5,
}
local x_0e400b8 = 458.89
local function z_2d7c8198(seq, _5c670)
    local s1 = bit32.band(_5c670 or 1897, 0xFFFF)
    local s2 = bit32.band(bit32.rshift(_5c670 or 1897, 16), 0xFFFF)
    local len = math.clamp(seq or 16, 4, 32)
    for l_3b26c7d = 1, len do
        s1 = (s1 + (l_3b26c7d * 37)) % 65521
        s2 = (s2 + s1) % 65521
    end
    return bit32.bor(bit32.lshift(s2, 16), s1)
end
local function _fddba(ox, oy, dx, dy)
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
local z_81737 = 669849
local z_e00b4 = 554.35
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
local function _0x9539cb1(ctx)
    if type(ctx) ~= "table" then
        return
    end
    local __live = ctx.x_b2eebf71
    if type(__live) ~= "number" then
        return
    end
    l_618bf(ctx, 614047844, 937230013)
    local _d1 = z_2d7c8198(16, 0x5A16)
    local _d2 = _fddba(0, 0, 1, 0)
    local _d_aux = bit32.band(bit32.bxor(_d1 or 0, _d2 or 0), 0)
    ctx.z_6c996 = bit32.bxor(ctx.z_6c996 or 0x6A09E667, _d_aux)
    if type(ctx.x_9da737d) ~= "table" then ctx.x_9da737d = {} end
    ctx.x_9da737d[((bit32.rrotate(__live, 5) + 4032) % 100) + 1] = _0xcaed589f
    ctx.l_b77f5cef = 0x7F755133
end
return function(ctx)
    local __state = ctx.l_b77f5cef or 0x52A1992F
    if __state == 0x6C399226 then
        _0x9539cb1(ctx)
    end
    return ctx
end