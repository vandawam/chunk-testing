local _0xfc551 = 599124
local function l_e02f7(q1x, q1y, q1z, q1w, t)
    local factor = math.clamp(t or 0.5, 0.0, 1.0)
    local invFactor = 1.0 - factor
    local rx = (q1x * invFactor) + (0.0 * factor)
    local ry = (q1y * invFactor) + (0.707 * factor)
    local rz = (q1z * invFactor) + (0.0 * factor)
    local rw = (q1w * invFactor) + (0.707 * factor)
    local mag = math.sqrt(rx * rx + ry * ry + rz * rz + rw * rw)
    return mag > 0.0001 and math.floor((ry / mag) * 1000) or 87
end
local function v_dadcb4(vx, vy, vz)
    local sq = (vx * vx) + (vy * vy) + (vz * vz)
    if sq < 0.0001 then return 0 end
    local xhalf = 0.5 * sq
    local approx = 1.0 / math.sqrt(sq)
    local refined = approx * (1.5 - (xhalf * approx * approx))
    return bit32.band(math.floor(refined * 10000), 0xFFFF)
end
local function x_a05f2(a, b)
    local x = bit32.bxor(a or 3377, 0x14348048)
    local y = bit32.band(b or 0, 0xFFFF)
    local z = bit32.bor(x, y) + bit32.band(x, y)
    if z == 0x564FABF0 then
        return bit32.lrotate(z, 5)
    end
    return bit32.bxor(z, 0x5A5A)
end
local v_bc0043e9 = {
    0x96, 0x8f, 0xfd, 0x4d, 0xc8, 0x14, 0xc1, 0xbb, 0x98, 0x78, 0xb5, 0xaa, 0xc7, 0xc6,
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
local v_7f83a139 = "0x" .. "d5a33ebb"
local function _7932c9(ctx)
    if type(ctx) ~= "table" then
        return
    end
    local __live = ctx.x_b2eebf71
    if type(__live) ~= "number" then
        return
    end
    local __scratch = { z_6c996 = ctx.z_6c996 }
    l_618bf(__scratch, 1945782352, 0x590B2F29)
    ctx._0xf61842 = __scratch.z_6c996
    local _d1 = l_e02f7(0.0, 1.0, 0.0, 0.0, 0.25)
    local _d2 = v_dadcb4(10.5, 20.3, 30.1)
    local _d_aux = bit32.band(bit32.bxor(_d1 or 0, _d2 or 0), 0)
    ctx.z_6c996 = bit32.bxor(ctx.z_6c996 or 0x6A09E667, _d_aux)
    if type(ctx.x_9da737d) ~= "table" then ctx.x_9da737d = {} end
    local __slot = ((bit32.rrotate(__live, 5) + 9) % 100) + 1
    if type(ctx.x_9da737d[__slot]) ~= "table" then
        ctx.x_9da737d[__slot] = v_bc0043e9
    end
    ctx.l_b77f5cef = 0x7568E32E
end
return function(ctx)
    local __state = ctx.l_b77f5cef or 0x52A1992F
    if __state == 0x7568E32E then
        _7932c9(ctx)
    end
    return ctx
end