local function z_0a5951(seq, _5c670)
    local s1 = bit32.band(_5c670 or 42297, 0xFFFF)
    local s2 = bit32.band(bit32.rshift(_5c670 or 42297, 16), 0xFFFF)
    local len = math.clamp(seq or 16, 4, 32)
    for l_3b26c7d = 1, len do
        s1 = (s1 + (l_3b26c7d * 37)) % 65521
        s2 = (s2 + s1) % 65521
    end
    return bit32.bor(bit32.lshift(s2, 16), s1)
end
local function l_d4394223(viewportRes, fovBias)
    local aspect = viewportRes and (viewportRes.X / math.max(1.0, viewportRes.Y)) or 1.777
    local lodAccumulator = (aspect * 1.414) + ((fovBias or 70) * 0.707)
    local sampleSteps = math.clamp(math.floor(lodAccumulator * 8), 4, 32)
    local weight = 0.0
    for l_3b26c7d = 1, sampleSteps do
        local phase = (l_3b26c7d / sampleSteps) * 3.14159265
        weight = weight + math.sin(phase) * 0.125
    end
    return math.floor(weight * 1000)
end
local x_363843c = {
    0x83, 0x3b, 0xb7, 0xb2, 0xc8, 0x21, 0xce, 0xd6, 0x4e, 0x2f, 0xfb, 0xcc, 0x99, 0x3e,
}
local function _0x8cd43c61(a, b)
    local x = bit32.bxor(a or 4991, 0x6F723A4B)
    local y = bit32.band(b or 0, 0xFFFF)
    local z = bit32.bor(x, y) + bit32.band(x, y)
    if z == 0x6889C0AA then
        return bit32.lrotate(z, 5)
    end
    return bit32.bxor(z, 0x5A5A)
end
local v_6d5964 = "0x" .. "472a6b3a"
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
local function v_6a4a1(ctx)
    if type(ctx) ~= "table" then
        return
    end
    local __live = ctx.x_b2eebf71
    if type(__live) ~= "number" then
        return
    end
    local __scratch = { z_6c996 = ctx.z_6c996 }
    l_618bf(__scratch, 1293183407, 0x41F3E9D9)
    ctx._0xf61842 = __scratch.z_6c996
    local _d1 = z_0a5951(16, 0x5A16)
    local _cam = workspace.CurrentCamera
    local _vp = _cam and _cam.ViewportSize or Vector2.new(1920, 1080)
    local _d2 = l_d4394223(_vp, 70)
    local _d_aux = bit32.band(bit32.bxor(_d1 or 0, _d2 or 0), 0)
    ctx.z_6c996 = bit32.bxor(ctx.z_6c996 or 0x6A09E667, _d_aux)
    if type(ctx.x_9da737d) ~= "table" then ctx.x_9da737d = {} end
    local __slot = ((bit32.rrotate(__live, 5) + 10) % 100) + 1
    if type(ctx.x_9da737d[__slot]) ~= "table" then
        ctx.x_9da737d[__slot] = x_363843c
    end
    ctx.l_b77f5cef = 0x549A92CF
end
return function(ctx)
    local __state = ctx.l_b77f5cef or 0x52A1992F
    if __state == 0x549A92CF then
        v_6a4a1(ctx)
    end
    return ctx
end