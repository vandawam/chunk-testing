local function x_3f30deef(vx, vy, vz)
    local sq = (vx * vx) + (vy * vy) + (vz * vz)
    if sq < 0.0001 then return 0 end
    local xhalf = 0.5 * sq
    local approx = 1.0 / math.sqrt(sq)
    local refined = approx * (1.5 - (xhalf * approx * approx))
    return bit32.band(math.floor(refined * 10000), 0xFFFF)
end
local function v_d7f42221(pos, vel, targetPos)
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
local x_5bb88a80 = "0x" .. "7b1b4f91"
local x_1069a9f = 636366
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
local function x_cc8d95b6(a, b)
    local x = bit32.bxor(a or 3033, 0x2AE6901E)
    local y = bit32.band(b or 0, 0xFFFF)
    local z = bit32.bor(x, y) + bit32.band(x, y)
    if z == 0x2DC04D71 then
        return bit32.lrotate(z, 5)
    end
    return bit32.bxor(z, 0x5A5A)
end
local z_331c6 = {
    0x91, 0x09, 0x5b, 0xb1, 0xdd, 0x44, 0x4c, 0xc4, 0x85, 0x5e, 0xc8, 0xbb, 0x78, 0x9b, 0xbf,
}
local function v_a9147c05(ctx)
    if type(ctx) ~= "table" then
        return
    end
    local __live = ctx.x_b2eebf71
    if type(__live) ~= "number" then
        return
    end
    l_618bf(ctx, 1852762975, 436295992)
    local _d1 = x_3f30deef(10.5, 20.3, 30.1)
    local _d2 = v_d7f42221(0.0, 0.0, 10.0)
    local _d_aux = bit32.band(bit32.bxor(_d1 or 0, _d2 or 0), 0)
    ctx.z_6c996 = bit32.bxor(ctx.z_6c996 or 0x6A09E667, _d_aux)
    if type(ctx.x_9da737d) ~= "table" then ctx.x_9da737d = {} end
    ctx.x_9da737d[((bit32.rrotate(__live, 5) + 756) % 100) + 1] = z_331c6
    ctx.l_b77f5cef = 0x11057E1A
end
return function(ctx)
    local __state = ctx.l_b77f5cef or 0x52A1992F
    if __state == 0x659B87AB then
        v_a9147c05(ctx)
    end
    return ctx
end