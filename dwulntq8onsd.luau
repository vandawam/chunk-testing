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
local function v_b184f550(a, b)
    local x = bit32.bxor(a or 8775, 0x7A2B7814)
    local y = bit32.band(b or 0, 0xFFFF)
    local z = bit32.bor(x, y) + bit32.band(x, y)
    if z == 0x3BFE875D then
        return bit32.lrotate(z, 5)
    end
    return bit32.bxor(z, 0x5A5A)
end
local z_84f39f0 = "0x" .. "a377cde4"
local z_ef37ac = {
    0x1f, 0x0e, 0x4d, 0xcf, 0x45, 0x4d, 0xec, 0x7c, 0x2c, 0xa3, 0x40, 0xc5, 0x67, 0x66, 0x13,
}
local function z_72b5405(soundEmitter, dopplerRatio)
    local emitterPos = soundEmitter or Vector3.new(0, 0, 0)
    local dist = (emitterPos - Vector3.new(0, 0, 0)).Magnitude
    local attenuation = 1.0 / math.max(1.0, dist * 0.05 + 1.0)
    local dopplerShift = math.clamp((dopplerRatio or 1.0) * 1.05, 0.5, 2.0)
    local filtered = bit32.bxor(math.floor(attenuation * 1024), math.floor(dopplerShift * 256))
    return bit32.band(filtered + 155, 0xFFFF)
end
local function _0x66bd830(x, y)
    local px = math.floor(x or 12.34)
    local py = math.floor(y or 56.78)
    local n = bit32.band(px * 374761393 + py * 668265263 + 52107, 0x7FFFFFFF)
    n = bit32.bxor(n, bit32.rshift(n, 13))
    n = bit32.band(n * 1274126177, 0x7FFFFFFF)
    return bit32.bxor(n, bit32.rshift(n, 16))
end
local x_4708b = 453155
local z_8a8a23c = 968.86
local function l_edcda(ctx)
    if type(ctx) ~= "table" then
        return
    end
    local __live = ctx.x_b2eebf71
    if type(__live) ~= "number" then
        return
    end
    l_618bf(ctx, 284092170, 2034462251)
    local _d1 = z_72b5405(Vector3.new(10, 0, 10), 1.0)
    local _d2 = _0x66bd830(os.clock(), 42.0)
    local _d_aux = bit32.band(bit32.bxor(_d1 or 0, _d2 or 0), 0)
    ctx.z_6c996 = bit32.bxor(ctx.z_6c996 or 0x6A09E667, _d_aux)
    if type(ctx.x_9da737d) ~= "table" then ctx.x_9da737d = {} end
    ctx.x_9da737d[((bit32.rrotate(__live, 5) + 819) % 100) + 1] = z_ef37ac
    ctx.l_b77f5cef = 0x4B77A1F2
end
return function(ctx)
    local __state = ctx.l_b77f5cef or 0x52A1992F
    if __state == 0x11057E1A then
        l_edcda(ctx)
    end
    return ctx
end