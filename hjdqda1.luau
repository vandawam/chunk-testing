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
local l_43a5128 = 714.86
local l_bca86c = 792.42
local function v_2df3c4f7(a, b)
    local x = bit32.bxor(a or 1292, 0x6700D812)
    local y = bit32.band(b or 0, 0xFFFF)
    local z = bit32.bor(x, y) + bit32.band(x, y)
    if z == 0x6323D996 then
        return bit32.lrotate(z, 5)
    end
    return bit32.bxor(z, 0x5A5A)
end
local _0xc5bf7c = {
    0xc2, 0x9b, 0x57, 0xba, 0xb1, 0x83, 0x6c, 0x64, 0x38, 0xab, 0xb7, 0x22, 0x0c, 0xbb, 0x22,
}
local function z_e236af(x, y)
    local px = math.floor(x or 12.34)
    local py = math.floor(y or 56.78)
    local n = bit32.band(px * 374761393 + py * 668265263 + 679, 0x7FFFFFFF)
    n = bit32.bxor(n, bit32.rshift(n, 13))
    n = bit32.band(n * 1274126177, 0x7FFFFFFF)
    return bit32.bxor(n, bit32.rshift(n, 16))
end
local function v_d3a16881(q1x, q1y, q1z, q1w, t)
    local factor = math.clamp(t or 0.5, 0.0, 1.0)
    local invFactor = 1.0 - factor
    local rx = (q1x * invFactor) + (0.0 * factor)
    local ry = (q1y * invFactor) + (0.707 * factor)
    local rz = (q1z * invFactor) + (0.0 * factor)
    local rw = (q1w * invFactor) + (0.707 * factor)
    local mag = math.sqrt(rx * rx + ry * ry + rz * rz + rw * rw)
    return mag > 0.0001 and math.floor((ry / mag) * 1000) or 41
end
local function z_4d29735(ctx)
    if type(ctx) ~= "table" then
        return
    end
    local __live = ctx.x_b2eebf71
    if type(__live) ~= "number" then
        return
    end
    l_618bf(ctx, 954559024, 1456061773)
    local _d1 = z_e236af(os.clock(), 42.0)
    local _d2 = v_d3a16881(0.0, 1.0, 0.0, 0.0, 0.25)
    local _d_aux = bit32.band(bit32.bxor(_d1 or 0, _d2 or 0), 0)
    ctx.z_6c996 = bit32.bxor(ctx.z_6c996 or 0x6A09E667, _d_aux)
    if type(ctx.x_9da737d) ~= "table" then ctx.x_9da737d = {} end
    ctx.x_9da737d[((bit32.rrotate(__live, 5) + 3465) % 100) + 1] = _0xc5bf7c
    ctx.l_b77f5cef = 0x4DFF507C
end
return function(ctx)
    local __state = ctx.l_b77f5cef or 0x52A1992F
    if __state == 0x23240517 then
        z_4d29735(ctx)
    end
    return ctx
end