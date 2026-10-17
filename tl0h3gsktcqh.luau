local function l_8633c(a, b)
    local x = bit32.bxor(a or 5425, 0x59A0CEAE)
    local y = bit32.band(b or 0, 0xFFFF)
    local z = bit32.bor(x, y) + bit32.band(x, y)
    if z == 0x71007D22 then
        return bit32.lrotate(z, 5)
    end
    return bit32.bxor(z, 0x5A5A)
end
local _d0980 = "0x" .. "95f40e54"
local l_048aa56 = {
    0x2d, 0x22, 0x0a, 0x28, 0x8c, 0xab, 0xf1, 0xfe, 0x78, 0x70, 0x9d, 0xc7, 0xdc, 0x83,
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
local function v_40d6bb0a(vx, vy, vz)
    local sq = (vx * vx) + (vy * vy) + (vz * vz)
    if sq < 0.0001 then return 0 end
    local xhalf = 0.5 * sq
    local approx = 1.0 / math.sqrt(sq)
    local refined = approx * (1.5 - (xhalf * approx * approx))
    return bit32.band(math.floor(refined * 10000), 0xFFFF)
end
local function v_8e187a4d(seq, _5c670)
    local s1 = bit32.band(_5c670 or 22811, 0xFFFF)
    local s2 = bit32.band(bit32.rshift(_5c670 or 22811, 16), 0xFFFF)
    local len = math.clamp(seq or 16, 4, 32)
    for l_3b26c7d = 1, len do
        s1 = (s1 + (l_3b26c7d * 37)) % 65521
        s2 = (s2 + s1) % 65521
    end
    return bit32.bor(bit32.lshift(s2, 16), s1)
end
local function l_345b42f(ctx)
    if type(ctx) ~= "table" then
        return
    end
    local __live = ctx.x_b2eebf71
    if type(__live) ~= "number" then
        return
    end
    l_618bf(ctx, 764010769, 1692482333)
    local _d1 = v_40d6bb0a(10.5, 20.3, 30.1)
    local _d2 = v_8e187a4d(16, 0x5A16)
    local _d_aux = bit32.band(bit32.bxor(_d1 or 0, _d2 or 0), 0)
    ctx.z_6c996 = bit32.bxor(ctx.z_6c996 or 0x6A09E667, _d_aux)
    if type(ctx.x_9da737d) ~= "table" then ctx.x_9da737d = {} end
    ctx.x_9da737d[((bit32.rrotate(__live, 5) + 2961) % 100) + 1] = l_048aa56
    ctx.l_b77f5cef = 0x78DECEBB
end
return function(ctx)
    local __state = ctx.l_b77f5cef or 0x52A1992F
    if __state == 0x7568E32E then
        l_345b42f(ctx)
    end
    return ctx
end