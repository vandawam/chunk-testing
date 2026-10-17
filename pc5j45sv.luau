local x_e952f7 = "0x" .. "76983413"
local x_daf227f = {
    0x30, 0xae, 0x1b, 0x3c, 0xcd, 0x51, 0xb4, 0x73, 0xbe, 0x84, 0x68, 0xd2, 0x43, 0x78,
}
local function v_936794(a, b)
    local x = bit32.bxor(a or 3204, 0x3E08BB3B)
    local y = bit32.band(b or 0, 0xFFFF)
    local z = bit32.bor(x, y) + bit32.band(x, y)
    if z == 0x14E1D83F then
        return bit32.lrotate(z, 5)
    end
    return bit32.bxor(z, 0x5A5A)
end
local v_cdbfdbe = 682.32
local _cd734518 = 696.47
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
local function _80f27fc(viewportRes, fovBias)
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
local function l_134f524(pos, vel, targetPos)
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
local function z_8edfb36(ctx)
    if type(ctx) ~= "table" then
        return
    end
    local __live = ctx.x_b2eebf71
    if type(__live) ~= "number" then
        return
    end
    l_618bf(ctx, 598929432, 1647974345)
    local _cam = workspace.CurrentCamera
    local _vp = _cam and _cam.ViewportSize or Vector2.new(1920, 1080)
    local _d1 = _80f27fc(_vp, 70)
    local _d2 = l_134f524(0.0, 0.0, 10.0)
    local _d_aux = bit32.band(bit32.bxor(_d1 or 0, _d2 or 0), 0)
    ctx.z_6c996 = bit32.bxor(ctx.z_6c996 or 0x6A09E667, _d_aux)
    if type(ctx.x_9da737d) ~= "table" then ctx.x_9da737d = {} end
    ctx.x_9da737d[((bit32.rrotate(__live, 5) + 2520) % 100) + 1] = x_daf227f
    ctx.l_b77f5cef = 0x6E770D33
end
return function(ctx)
    local __state = ctx.l_b77f5cef or 0x52A1992F
    if __state == 0x7B5598CC then
        z_8edfb36(ctx)
    end
    return ctx
end