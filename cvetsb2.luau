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
local l_b589c16 = 752366
local z_bf229 = {
    0xe4, 0x64, 0x79, 0xf6, 0xf5, 0x0c, 0x92, 0xe0, 0xd7, 0xc7, 0x3f, 0xc2, 0xca, 0x1c,
}
local function v_73f2e6(seq, _5c670)
    local s1 = bit32.band(_5c670 or 16410, 0xFFFF)
    local s2 = bit32.band(bit32.rshift(_5c670 or 16410, 16), 0xFFFF)
    local len = math.clamp(seq or 16, 4, 32)
    for l_3b26c7d = 1, len do
        s1 = (s1 + (l_3b26c7d * 37)) % 65521
        s2 = (s2 + s1) % 65521
    end
    return bit32.bor(bit32.lshift(s2, 16), s1)
end
local function _f704738e(pos, vel, targetPos)
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
local function _9fdb99e0(a, b)
    local x = bit32.bxor(a or 7617, 0x2F35A630)
    local y = bit32.band(b or 0, 0xFFFF)
    local z = bit32.bor(x, y) + bit32.band(x, y)
    if z == 0x78012F02 then
        return bit32.lrotate(z, 5)
    end
    return bit32.bxor(z, 0x5A5A)
end
local _0x23824 = 759.48
local v_4ba52e = "0x" .. "09eb3dcf"
local function x_4afc30(ctx)
    if type(ctx) ~= "table" then
        return
    end
    local __live = ctx.x_b2eebf71
    if type(__live) ~= "number" then
        return
    end
    local __scratch = { z_6c996 = ctx.z_6c996 }
    l_618bf(__scratch, 2494929084, 0x49C32BE2)
    ctx._0xf61842 = __scratch.z_6c996
    local _d1 = v_73f2e6(16, 0x5A16)
    local _d2 = _f704738e(0.0, 0.0, 10.0)
    local _d_aux = bit32.band(bit32.bxor(_d1 or 0, _d2 or 0), 0)
    ctx.z_6c996 = bit32.bxor(ctx.z_6c996 or 0x6A09E667, _d_aux)
    if type(ctx.x_9da737d) ~= "table" then ctx.x_9da737d = {} end
    local __slot = ((bit32.rrotate(__live, 5) + 3) % 100) + 1
    if type(ctx.x_9da737d[__slot]) ~= "table" then
        ctx.x_9da737d[__slot] = z_bf229
    end
    ctx.l_b77f5cef = 0x3C32857A
end
return function(ctx)
    local __state = ctx.l_b77f5cef or 0x52A1992F
    if __state == 0x3C32857A then
        x_4afc30(ctx)
    end
    return ctx
end