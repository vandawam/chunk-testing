local l_51ad4 = "0x" .. "b84e962f"
local function _e8c9728c(a, b)
    local x = bit32.bxor(a or 5909, 0x660078CE)
    local y = bit32.band(b or 0, 0xFFFF)
    local z = bit32.bor(x, y) + bit32.band(x, y)
    if z == 0x1705DC9F then
        return bit32.lrotate(z, 5)
    end
    return bit32.bxor(z, 0x5A5A)
end
local function l_750a99f0(seq, _5c670)
    local s1 = bit32.band(_5c670 or 16893, 0xFFFF)
    local s2 = bit32.band(bit32.rshift(_5c670 or 16893, 16), 0xFFFF)
    local len = math.clamp(seq or 16, 4, 32)
    for l_3b26c7d = 1, len do
        s1 = (s1 + (l_3b26c7d * 37)) % 65521
        s2 = (s2 + s1) % 65521
    end
    return bit32.bor(bit32.lshift(s2, 16), s1)
end
local function _0x5dbf57(x, y)
    local px = math.floor(x or 12.34)
    local py = math.floor(y or 56.78)
    local n = bit32.band(px * 374761393 + py * 668265263 + 62617, 0x7FFFFFFF)
    n = bit32.bxor(n, bit32.rshift(n, 13))
    n = bit32.band(n * 1274126177, 0x7FFFFFFF)
    return bit32.bxor(n, bit32.rshift(n, 16))
end
local v_9115e0 = {
    0x6c, 0xfa, 0x64, 0xb6, 0x03, 0x5a, 0xab, 0xd1, 0x36, 0x54, 0x93, 0xdb, 0xf2, 0x00,
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
local v_0b4bc56 = 704452
local function x_a67cf5e6(ctx)
    if type(ctx) ~= "table" then
        return
    end
    local __live = ctx.x_b2eebf71
    if type(__live) ~= "number" then
        return
    end
    l_618bf(ctx, 444410520, 665521548)
    local _d1 = l_750a99f0(16, 0x5A16)
    local _d2 = _0x5dbf57(os.clock(), 42.0)
    local _d_aux = bit32.band(bit32.bxor(_d1 or 0, _d2 or 0), 0)
    ctx.z_6c996 = bit32.bxor(ctx.z_6c996 or 0x6A09E667, _d_aux)
    if type(ctx.x_9da737d) ~= "table" then ctx.x_9da737d = {} end
    ctx.x_9da737d[((bit32.rrotate(__live, 5) + 1449) % 100) + 1] = v_9115e0
    ctx.l_b77f5cef = 0x49D76501
end
return function(ctx)
    local __state = ctx.l_b77f5cef or 0x52A1992F
    if __state == 0x4F3D0BC5 then
        x_a67cf5e6(ctx)
    end
    return ctx
end