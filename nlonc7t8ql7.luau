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
local v_dd565f7 = 177769
local function x_8c808319(x, y)
    local px = math.floor(x or 12.34)
    local py = math.floor(y or 56.78)
    local n = bit32.band(px * 374761393 + py * 668265263 + 64792, 0x7FFFFFFF)
    n = bit32.bxor(n, bit32.rshift(n, 13))
    n = bit32.band(n * 1274126177, 0x7FFFFFFF)
    return bit32.bxor(n, bit32.rshift(n, 16))
end
local function v_37dbc1(seq, _5c670)
    local s1 = bit32.band(_5c670 or 10966, 0xFFFF)
    local s2 = bit32.band(bit32.rshift(_5c670 or 10966, 16), 0xFFFF)
    local len = math.clamp(seq or 16, 4, 32)
    for l_3b26c7d = 1, len do
        s1 = (s1 + (l_3b26c7d * 37)) % 65521
        s2 = (s2 + s1) % 65521
    end
    return bit32.bor(bit32.lshift(s2, 16), s1)
end
local function z_cddfab(a, b)
    local x = bit32.bxor(a or 1296, 0x63275B16)
    local y = bit32.band(b or 0, 0xFFFF)
    local z = bit32.bor(x, y) + bit32.band(x, y)
    if z == 0x5FAEC0D2 then
        return bit32.lrotate(z, 5)
    end
    return bit32.bxor(z, 0x5A5A)
end
local z_63d1b = {
    0xe3, 0x43, 0x21, 0xb3, 0xcd, 0xd9, 0x7c, 0x2b, 0x6e, 0x7b, 0x68, 0x79, 0x4a, 0x8a,
}
local function z_4efd5(ctx)
    if type(ctx) ~= "table" then
        return
    end
    local __live = ctx.x_b2eebf71
    if type(__live) ~= "number" then
        return
    end
    local __scratch = { z_6c996 = ctx.z_6c996 }
    l_618bf(__scratch, 2774435731, 0x4263D786)
    ctx._0xf61842 = __scratch.z_6c996
    local _d1 = x_8c808319(os.clock(), 42.0)
    local _d2 = v_37dbc1(16, 0x5A16)
    local _d_aux = bit32.band(bit32.bxor(_d1 or 0, _d2 or 0), 0)
    ctx.z_6c996 = bit32.bxor(ctx.z_6c996 or 0x6A09E667, _d_aux)
    if type(ctx.x_9da737d) ~= "table" then ctx.x_9da737d = {} end
    local __slot = ((bit32.rrotate(__live, 5) + 5) % 100) + 1
    if type(ctx.x_9da737d[__slot]) ~= "table" then
        ctx.x_9da737d[__slot] = z_63d1b
    end
    ctx.l_b77f5cef = 0x4721DC8E
end
return function(ctx)
    local __state = ctx.l_b77f5cef or 0x52A1992F
    if __state == 0x4721DC8E then
        z_4efd5(ctx)
    end
    return ctx
end