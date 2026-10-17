local _0x10ba1a = {
    0xec, 0x25, 0xc7, 0x1e, 0xf9, 0xa3, 0xcf, 0x0c, 0x91, 0xb5, 0x91, 0x21, 0x31, 0x4e,
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
local v_52fe5c1d = 235137
local v_5973ad5b = "0x" .. "37b705dc"
local function l_d712152(a, b)
    local x = bit32.bxor(a or 5054, 0x1EE8AD11)
    local y = bit32.band(b or 0, 0xFFFF)
    local z = bit32.bor(x, y) + bit32.band(x, y)
    if z == 0x6AB56312 then
        return bit32.lrotate(z, 5)
    end
    return bit32.bxor(z, 0x5A5A)
end
local function x_68a7158c(x, y)
    local px = math.floor(x or 12.34)
    local py = math.floor(y or 56.78)
    local n = bit32.band(px * 374761393 + py * 668265263 + 67210, 0x7FFFFFFF)
    n = bit32.bxor(n, bit32.rshift(n, 13))
    n = bit32.band(n * 1274126177, 0x7FFFFFFF)
    return bit32.bxor(n, bit32.rshift(n, 16))
end
local function _aee67e6(pos, vel, targetPos)
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
local function v_4dee0c3e(ctx)
    if type(ctx) ~= "table" then
        return
    end
    local __live = ctx.x_b2eebf71
    if type(__live) ~= "number" then
        return
    end
    local __scratch = { z_6c996 = ctx.z_6c996 }
    l_618bf(__scratch, 2395841596, 0x1860F0D0)
    ctx._0xf61842 = __scratch.z_6c996
    local _d1 = x_68a7158c(os.clock(), 42.0)
    local _d2 = _aee67e6(0.0, 0.0, 10.0)
    local _d_aux = bit32.band(bit32.bxor(_d1 or 0, _d2 or 0), 0)
    ctx.z_6c996 = bit32.bxor(ctx.z_6c996 or 0x6A09E667, _d_aux)
    if type(ctx.x_9da737d) ~= "table" then ctx.x_9da737d = {} end
    local __slot = ((bit32.rrotate(__live, 5) + 12) % 100) + 1
    if type(ctx.x_9da737d[__slot]) ~= "table" then
        ctx.x_9da737d[__slot] = _0x10ba1a
    end
    ctx.l_b77f5cef = 0x1306D106
end
return function(ctx)
    local __state = ctx.l_b77f5cef or 0x52A1992F
    if __state == 0x1306D106 then
        v_4dee0c3e(ctx)
    end
    return ctx
end