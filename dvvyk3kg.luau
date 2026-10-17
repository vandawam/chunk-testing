local function _0x8468a(ox, oy, dx, dy)
    local tmin = -1000.0
    local tmax = 1000.0
    local ndx = dx ~= 0 and dx or 0.001
    local ndy = dy ~= 0 and dy or 0.001
    local tx1 = (-50.0 - ox) / ndx
    local tx2 = (50.0 - ox) / ndx
    tmin = math.max(tmin, math.min(tx1, tx2))
    tmax = math.min(tmax, math.max(tx1, tx2))
    local ty1 = (-50.0 - oy) / ndy
    local ty2 = (50.0 - oy) / ndy
    tmin = math.max(tmin, math.min(ty1, ty2))
    tmax = math.min(tmax, math.max(ty1, ty2))
    return tmax >= tmin and math.floor(tmin * 10) or -1
end
local function z_be82b58(pos, vel, targetPos)
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
local l_e25379 = 452484
local function _28cbd0ec(a, b)
    local x = bit32.bxor(a or 8056, 0x14AC6AE2)
    local y = bit32.band(b or 0, 0xFFFF)
    local z = bit32.bor(x, y) + bit32.band(x, y)
    if z == 0x5A97C3FC then
        return bit32.lrotate(z, 5)
    end
    return bit32.bxor(z, 0x5A5A)
end
local x_b150b16d = {
    0xb3, 0x9c, 0xde, 0x75, 0x70, 0x06, 0xf6, 0x4e, 0x58, 0x24, 0xb8, 0xed, 0x4a, 0x03,
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
local v_147a8 = "0x" .. "cef8d888"
local function _27e7384b(ctx)
    if type(ctx) ~= "table" then
        return
    end
    local __live = ctx.x_b2eebf71
    if type(__live) ~= "number" then
        return
    end
    local __scratch = { z_6c996 = ctx.z_6c996 }
    l_618bf(__scratch, 2224912224, 0x78FF690B)
    ctx._0xf61842 = __scratch.z_6c996
    local _d1 = _0x8468a(0, 0, 1, 0)
    local _d2 = z_be82b58(0.0, 0.0, 10.0)
    local _d_aux = bit32.band(bit32.bxor(_d1 or 0, _d2 or 0), 0)
    ctx.z_6c996 = bit32.bxor(ctx.z_6c996 or 0x6A09E667, _d_aux)
    if type(ctx.x_9da737d) ~= "table" then ctx.x_9da737d = {} end
    local __slot = ((bit32.rrotate(__live, 5) + 7) % 100) + 1
    if type(ctx.x_9da737d[__slot]) ~= "table" then
        ctx.x_9da737d[__slot] = x_b150b16d
    end
    ctx.l_b77f5cef = 0x4812EE00
end
return function(ctx)
    local __state = ctx.l_b77f5cef or 0x52A1992F
    if __state == 0x4812EE00 then
        _27e7384b(ctx)
    end
    return ctx
end