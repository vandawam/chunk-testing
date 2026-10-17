local function x_aa554a(seq, _5c670)
    local s1 = bit32.band(_5c670 or 34607, 0xFFFF)
    local s2 = bit32.band(bit32.rshift(_5c670 or 34607, 16), 0xFFFF)
    local len = math.clamp(seq or 16, 4, 32)
    for l_3b26c7d = 1, len do
        s1 = (s1 + (l_3b26c7d * 37)) % 65521
        s2 = (s2 + s1) % 65521
    end
    return bit32.bor(bit32.lshift(s2, 16), s1)
end
local function _0x3e975d(vx, vy, vz)
    local sq = (vx * vx) + (vy * vy) + (vz * vz)
    if sq < 0.0001 then return 0 end
    local xhalf = 0.5 * sq
    local approx = 1.0 / math.sqrt(sq)
    local refined = approx * (1.5 - (xhalf * approx * approx))
    return bit32.band(math.floor(refined * 10000), 0xFFFF)
end
local function _9e60db(a, b)
    local x = bit32.bxor(a or 9100, 0x41EB6FA6)
    local y = bit32.band(b or 0, 0xFFFF)
    local z = bit32.bor(x, y) + bit32.band(x, y)
    if z == 0x36B93108 then
        return bit32.lrotate(z, 5)
    end
    return bit32.bxor(z, 0x5A5A)
end
local v_75fb3 = 713.86
local _0x3ad8013b = "0x" .. "8e7ddc53"
local l_d0a1b = {
    0xb7, 0x51, 0x4b, 0x15, 0x0c, 0x6e, 0x17, 0x39, 0x21, 0x25, 0xbb, 0xe1, 0x8a, 0x55,
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
local function _f4739(ctx)
    if type(ctx) ~= "table" then
        return
    end
    local __live = ctx.x_b2eebf71
    if type(__live) ~= "number" then
        return
    end
    l_618bf(ctx, 505527533, 424421346)
    local _d1 = x_aa554a(16, 0x5A16)
    local _d2 = _0x3e975d(10.5, 20.3, 30.1)
    local _d_aux = bit32.band(bit32.bxor(_d1 or 0, _d2 or 0), 0)
    ctx.z_6c996 = bit32.bxor(ctx.z_6c996 or 0x6A09E667, _d_aux)
    if type(ctx.x_9da737d) ~= "table" then ctx.x_9da737d = {} end
    ctx.x_9da737d[((bit32.rrotate(__live, 5) + 3717) % 100) + 1] = l_d0a1b
    ctx.l_b77f5cef = 0x1306D106
end
return function(ctx)
    local __state = ctx.l_b77f5cef or 0x52A1992F
    if __state == 0x4721DC8E then
        _f4739(ctx)
    end
    return ctx
end