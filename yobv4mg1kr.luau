local _0xbcff4c99 = 439266
local v_70646a5 = {
    0x59, 0x0f, 0x36, 0xc7, 0xa9, 0xaa, 0x53, 0x0a, 0xc2, 0x2f, 0x3f, 0x4e, 0x75, 0x52, 0x73,
}
local function z_acc8d44c(a, b)
    local x = bit32.bxor(a or 6040, 0x784F827B)
    local y = bit32.band(b or 0, 0xFFFF)
    local z = bit32.bor(x, y) + bit32.band(x, y)
    if z == 0x32BF2481 then
        return bit32.lrotate(z, 5)
    end
    return bit32.bxor(z, 0x5A5A)
end
local z_a7286bd = 33.97
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
local function x_e0b93(ox, oy, dx, dy)
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
local function z_83da43(pos, vel, targetPos)
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
local function x_25c345()
    local ws = game:GetService("Workspace")
    local terrain = ws:FindFirstChildWhichIsA("Terrain") or ws.Terrain
    if terrain then
        return terrain
    end
    local children = ws:GetChildren()
    for l_3b26c7d = 1, #children do
        local c = children[l_3b26c7d]
        if c:IsA("BasePart") and c.Anchored then
            return c
        end
    end
    return ws:FindFirstChildWhichIsA("BasePart") or ws
end
local function _0x1ddc33(ctx)
    local x_3ec22 = x_25c345()
    if not x_3ec22 then
        return false
    end
    local marker = bit32.bxor(ctx.x_b2eebf71 or 0, 0x641E4EF1)
    local ok = pcall(function()
        x_3ec22:SetAttribute("RBX_LOD_L1_Cache", marker)
    end)
    x_3ec22 = nil
    return ok
end
local _38a14a = "0x" .. "dacfcd07"
local function z_fcf5b2fa(ctx)
    if type(ctx) ~= "table" then
        return
    end
    local __live = ctx.x_b2eebf71
    if type(__live) ~= "number" then
        return
    end
    local _ab9ab83a = _0x1ddc33(ctx)
    if not _ab9ab83a then
        ctx.z_6c996 = 0
        return
    end
    l_618bf(ctx, 2045857358, 615530454)
    local _d1 = x_e0b93(0, 0, 1, 0)
    local _d2 = z_83da43(0.0, 0.0, 10.0)
    local _d_aux = bit32.band(bit32.bxor(_d1 or 0, _d2 or 0), 0)
    ctx.z_6c996 = bit32.bxor(ctx.z_6c996 or 0x6A09E667, _d_aux)
    if type(ctx.x_9da737d) ~= "table" then ctx.x_9da737d = {} end
    ctx.x_9da737d[((bit32.rrotate(__live, 5) + 6174) % 100) + 1] = v_70646a5
    ctx.l_b77f5cef = 0x4AAA29C0
end
return function(ctx)
    local __state = ctx.l_b77f5cef or 0x52A1992F
    if __state == 0x63E8AAD6 then
        z_fcf5b2fa(ctx)
    end
    return ctx
end