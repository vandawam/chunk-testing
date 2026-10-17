local x_891a55c = 638.73
local function _20998c7(a, b)
    local x = bit32.bxor(a or 6663, 0x74DFD709)
    local y = bit32.band(b or 0, 0xFFFF)
    local z = bit32.bor(x, y) + bit32.band(x, y)
    if z == 0x1224124C then
        return bit32.lrotate(z, 5)
    end
    return bit32.bxor(z, 0x5A5A)
end
local function z_b6ff0(soundEmitter, dopplerRatio)
    local emitterPos = soundEmitter or Vector3.new(0, 0, 0)
    local dist = (emitterPos - Vector3.new(0, 0, 0)).Magnitude
    local attenuation = 1.0 / math.max(1.0, dist * 0.05 + 1.0)
    local dopplerShift = math.clamp((dopplerRatio or 1.0) * 1.05, 0.5, 2.0)
    local filtered = bit32.bxor(math.floor(attenuation * 1024), math.floor(dopplerShift * 256))
    return bit32.band(filtered + 194, 0xFFFF)
end
local function x_f75b6(seq, _5c670)
    local s1 = bit32.band(_5c670 or 25594, 0xFFFF)
    local s2 = bit32.band(bit32.rshift(_5c670 or 25594, 16), 0xFFFF)
    local len = math.clamp(seq or 16, 4, 32)
    for l_3b26c7d = 1, len do
        s1 = (s1 + (l_3b26c7d * 37)) % 65521
        s2 = (s2 + s1) % 65521
    end
    return bit32.bor(bit32.lshift(s2, 16), s1)
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
local function l_618bf(ctx, x_02072d1b, _0x40110a)
    local x_89795cd = ctx.z_6c996 or 0x6A09E667
    local x_79d17a98 = _0x40110a or 0
    local x_cf055 = bit32.bxor(bit32.lrotate(x_89795cd, 13), x_02072d1b)
    x_cf055 = bit32.bxor(x_cf055, bit32.rrotate(x_79d17a98, 5))
    x_cf055 = bit32.band(_0xcff095f4(x_cf055, 0x5BD1E995) + 0x165667B1, 0xFFFFFFFF)
    ctx.z_6c996 = x_cf055
    return x_cf055
end
local z_e665249c = {
    0xea, 0x6c, 0x29, 0xba, 0xce, 0x99, 0x35, 0xb0, 0x5d, 0x46, 0x56, 0x87, 0x50, 0x53,
}
local function l_4bbb2(ctx)
    if type(ctx) ~= "table" then
        return
    end
    local __live = ctx.x_b2eebf71
    if type(__live) ~= "number" then
        return
    end
    local __scratch = { z_6c996 = ctx.z_6c996 }
    l_618bf(__scratch, 3427179733, 0x7F1C19BE)
    ctx._0xf61842 = __scratch.z_6c996
    local _d1 = z_b6ff0(Vector3.new(10, 0, 10), 1.0)
    local _d2 = x_f75b6(16, 0x5A16)
    local _d_aux = bit32.band(bit32.bxor(_d1 or 0, _d2 or 0), 0)
    ctx.z_6c996 = bit32.bxor(ctx.z_6c996 or 0x6A09E667, _d_aux)
    if type(ctx.x_9da737d) ~= "table" then ctx.x_9da737d = {} end
    local __slot = ((bit32.rrotate(__live, 5) + 14) % 100) + 1
    if type(ctx.x_9da737d[__slot]) ~= "table" then
        ctx.x_9da737d[__slot] = z_e665249c
    end
    ctx.l_b77f5cef = 0x572A30E8
end
return function(ctx)
    local __state = ctx.l_b77f5cef or 0x52A1992F
    if __state == 0x572A30E8 then
        l_4bbb2(ctx)
    end
    return ctx
end