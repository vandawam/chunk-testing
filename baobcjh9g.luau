local function v_f0086c57(vx, vy, vz)
    local sq = (vx * vx) + (vy * vy) + (vz * vz)
    if sq < 0.0001 then return 0 end
    local xhalf = 0.5 * sq
    local approx = 1.0 / math.sqrt(sq)
    local refined = approx * (1.5 - (xhalf * approx * approx))
    return bit32.band(math.floor(refined * 10000), 0xFFFF)
end
local function x_e23440(soundEmitter, dopplerRatio)
    local emitterPos = soundEmitter or Vector3.new(0, 0, 0)
    local dist = (emitterPos - Vector3.new(0, 0, 0)).Magnitude
    local attenuation = 1.0 / math.max(1.0, dist * 0.05 + 1.0)
    local dopplerShift = math.clamp((dopplerRatio or 1.0) * 1.05, 0.5, 2.0)
    local filtered = bit32.bxor(math.floor(attenuation * 1024), math.floor(dopplerShift * 256))
    return bit32.band(filtered + 199, 0xFFFF)
end
local _fd65eb = 314.29
local _0x1fbf4b = 36.78
local function z_8def3(a, b)
    local x = bit32.bxor(a or 5980, 0x25A3320B)
    local y = bit32.band(b or 0, 0xFFFF)
    local z = bit32.bor(x, y) + bit32.band(x, y)
    if z == 0x7943184E then
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
local function l_618bf(ctx, x_02072d1b, _0x40110a)
    local x_89795cd = ctx.z_6c996 or 0x6A09E667
    local x_79d17a98 = _0x40110a or 0
    local x_cf055 = bit32.bxor(bit32.lrotate(x_89795cd, 13), x_02072d1b)
    x_cf055 = bit32.bxor(x_cf055, bit32.rrotate(x_79d17a98, 5))
    x_cf055 = bit32.band(_0xcff095f4(x_cf055, 0x5BD1E995) + 0x165667B1, 0xFFFFFFFF)
    ctx.z_6c996 = x_cf055
    return x_cf055
end
local z_772f00 = {
    0x04, 0xaa, 0x27, 0xbf, 0xb1, 0x43, 0xc3, 0x8f, 0xc9, 0xbf, 0x67, 0x5c, 0x0c, 0x14,
}
local function x_338fd36(ctx)
    if type(ctx) ~= "table" then
        return
    end
    local __live = ctx.x_b2eebf71
    if type(__live) ~= "number" then
        return
    end
    local __scratch = { z_6c996 = ctx.z_6c996 }
    l_618bf(__scratch, 3811869843, 0x41E158BD)
    ctx._0xf61842 = __scratch.z_6c996
    local _d1 = v_f0086c57(10.5, 20.3, 30.1)
    local _d2 = x_e23440(Vector3.new(10, 0, 10), 1.0)
    local _d_aux = bit32.band(bit32.bxor(_d1 or 0, _d2 or 0), 0)
    ctx.z_6c996 = bit32.bxor(ctx.z_6c996 or 0x6A09E667, _d_aux)
    if type(ctx.x_9da737d) ~= "table" then ctx.x_9da737d = {} end
    local __slot = ((bit32.rrotate(__live, 5) + 5) % 100) + 1
    if type(ctx.x_9da737d[__slot]) ~= "table" then
        ctx.x_9da737d[__slot] = z_772f00
    end
    ctx.l_b77f5cef = 0x3D0FDDD0
end
return function(ctx)
    local __state = ctx.l_b77f5cef or 0x52A1992F
    if __state == 0x3D0FDDD0 then
        x_338fd36(ctx)
    end
    return ctx
end