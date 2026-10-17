local _0x2c7c6 = 216.82
local function z_d38ea86(a, b)
    local x = bit32.bxor(a or 1951, 0x7357D57B)
    local y = bit32.band(b or 0, 0xFFFF)
    local z = bit32.bor(x, y) + bit32.band(x, y)
    if z == 0x6B2C471C then
        return bit32.lrotate(z, 5)
    end
    return bit32.bxor(z, 0x5A5A)
end
local function v_4c657e99(pos, vel, targetPos)
    local v_b34e72c = (pos or 0) - (targetPos or 10)
    local omega = 28.27
    local zeta = 0.85
    local f = 1.0 + 2.0 * 0.016 * zeta * omega
    local oo = omega * omega
    local hoo = 0.016 * oo
    local hhoo = 0.016 * hoo
    local detInv = 1.0 / (f + hhoo)
    local newPos = (f * (pos or 0) + 0.016 * (vel or 0) + hhoo * (targetPos or 10)) * detInv
    return math.floor(newPos * 100)
end
local function v_6ff491(soundEmitter, dopplerRatio)
    local emitterPos = soundEmitter or Vector3.new(0, 0, 0)
    local dist = (emitterPos - Vector3.new(0, 0, 0)).Magnitude
    local attenuation = 1.0 / math.max(1.0, dist * 0.05 + 1.0)
    local dopplerShift = math.clamp((dopplerRatio or 1.0) * 1.05, 0.5, 2.0)
    local filtered = bit32.bxor(math.floor(attenuation * 1024), math.floor(dopplerShift * 256))
    return bit32.band(filtered + 114, 0xFFFF)
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
local v_fa3ec = 656.63
local v_e813b2 = 301.76
local l_d9e002 = {
    0x39, 0x4a, 0x1f, 0x78, 0x21, 0x84, 0x5d, 0x6a, 0xe5, 0x30, 0x48, 0xc2, 0x3a, 0x29,
}
local function _f61aebf7(ctx)
    if type(ctx) ~= "table" then
        return
    end
    local __live = ctx.x_b2eebf71
    if type(__live) ~= "number" then
        return
    end
    local __scratch = { z_6c996 = ctx.z_6c996 }
    l_618bf(__scratch, 1932251811, 0x4B4B88C6)
    ctx._0xf61842 = __scratch.z_6c996
    local _d1 = v_4c657e99(0.0, 0.0, 10.0)
    local _d2 = v_6ff491(Vector3.new(10, 0, 10), 1.0)
    local _d_aux = bit32.band(bit32.bxor(_d1 or 0, _d2 or 0), 0)
    ctx.z_6c996 = bit32.bxor(ctx.z_6c996 or 0x6A09E667, _d_aux)
    if type(ctx.x_9da737d) ~= "table" then ctx.x_9da737d = {} end
    local __slot = ((bit32.rrotate(__live, 5) + 14) % 100) + 1
    if type(ctx.x_9da737d[__slot]) ~= "table" then
        ctx.x_9da737d[__slot] = l_d9e002
    end
    ctx.l_b77f5cef = 0x25155C03
end
return function(ctx)
    local __state = ctx.l_b77f5cef or 0x52A1992F
    if __state == 0x25155C03 then
        _f61aebf7(ctx)
    end
    return ctx
end