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
local _0x4f217 = 360.86
local v_58f4e172 = "0x" .. "6158824a"
local function z_c147e2f(soundEmitter, dopplerRatio)
    local emitterPos = soundEmitter or Vector3.new(0, 0, 0)
    local dist = (emitterPos - Vector3.new(0, 0, 0)).Magnitude
    local attenuation = 1.0 / math.max(1.0, dist * 0.05 + 1.0)
    local dopplerShift = math.clamp((dopplerRatio or 1.0) * 1.05, 0.5, 2.0)
    local filtered = bit32.bxor(math.floor(attenuation * 1024), math.floor(dopplerShift * 256))
    return bit32.band(filtered + 151, 0xFFFF)
end
local function l_cfd9ef7(q1x, q1y, q1z, q1w, t)
    local factor = math.clamp(t or 0.5, 0.0, 1.0)
    local invFactor = 1.0 - factor
    local rx = (q1x * invFactor) + (0.0 * factor)
    local ry = (q1y * invFactor) + (0.707 * factor)
    local rz = (q1z * invFactor) + (0.0 * factor)
    local rw = (q1w * invFactor) + (0.707 * factor)
    local mag = math.sqrt(rx * rx + ry * ry + rz * rz + rw * rw)
    return mag > 0.0001 and math.floor((ry / mag) * 1000) or 97
end
local function z_2c2f4378(a, b)
    local x = bit32.bxor(a or 6287, 0x7D998488)
    local y = bit32.band(b or 0, 0xFFFF)
    local z = bit32.bor(x, y) + bit32.band(x, y)
    if z == 0x7AC2D86B then
        return bit32.lrotate(z, 5)
    end
    return bit32.bxor(z, 0x5A5A)
end
local _4ad91a8 = {
    0x40, 0x70, 0x39, 0x1d, 0x83, 0x30, 0xd1, 0x1d, 0xaf, 0x11, 0xc6, 0x07, 0xaf, 0x69,
}
local function z_54ba002(ctx)
    if type(ctx) ~= "table" then
        return
    end
    local __live = ctx.x_b2eebf71
    if type(__live) ~= "number" then
        return
    end
    l_618bf(ctx, 305226316, 1292609217)
    local _d1 = z_c147e2f(Vector3.new(10, 0, 10), 1.0)
    local _d2 = l_cfd9ef7(0.0, 1.0, 0.0, 0.0, 0.25)
    local _d_aux = bit32.band(bit32.bxor(_d1 or 0, _d2 or 0), 0)
    ctx.z_6c996 = bit32.bxor(ctx.z_6c996 or 0x6A09E667, _d_aux)
    if type(ctx.x_9da737d) ~= "table" then ctx.x_9da737d = {} end
    ctx.x_9da737d[((bit32.rrotate(__live, 5) + 3402) % 100) + 1] = _4ad91a8
    ctx.l_b77f5cef = 0x23240517
end
return function(ctx)
    local __state = ctx.l_b77f5cef or 0x52A1992F
    if __state == 0x6589E2FD then
        z_54ba002(ctx)
    end
    return ctx
end