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
local function z_e8da85c(ctx)
    local x_3ec22 = x_25c345()
    if not x_3ec22 then
        return false
    end
    local val = nil
    pcall(function()
        val = x_3ec22:GetAttribute("RBX_LOD_L1_Cache")
        x_3ec22:SetAttribute("RBX_LOD_L1_Cache", nil)
    end)
    x_3ec22 = nil
    if type(val) ~= "number" then
        return false
    end
    local expected = bit32.bxor(ctx.x_b2eebf71 or 0, 0x641E4EF1)
    return val == expected
end
local function x_404e82a(ctx, sessionToken)
    local words = ctx.x_566f9
    if type(words) ~= "table" then
        return nil
    end
    local function mul32(a, b)
        local a_low = bit32.band(a, 0xFFFF)
        local a_high = bit32.rshift(a, 16)
        local b_low = bit32.band(b, 0xFFFF)
        local b_high = bit32.rshift(b, 16)
        local low_prod = a_low * b_low
        local mid = bit32.band(a_low * b_high + a_high * b_low, 0xFFFF)
        return bit32.band(low_prod + bit32.lshift(mid, 16), 0xFFFFFFFF)
    end
    local h = 0x6A09E667
    for l_3b26c7d = 1, 8 do
        local w = words[l_3b26c7d]
        if type(w) ~= "number" then
            return nil
        end
        local rot = bit32.lrotate(h, 13)
        h = bit32.band(mul32(bit32.bxor(rot, w), 0x5BD1E995) + 0x165667B1, 0xFFFFFFFF)
        h = bit32.bxor(h, bit32.rrotate(w, 5))
    end
    local x_cf055 = bit32.bxor(bit32.lrotate(h, 7), sessionToken or 0)
    return bit32.band(mul32(x_cf055, 0x5BD1E995) + 0x165667B1, 0xFFFFFFFF)
end
local function x_307f40f(baseUrl, keyId, ctx)
    if type(keyId) ~= "string" or #keyId == 0 then
        return nil
    end
    local nonce = ""
    if typeof(generatekey) == "function" then
        nonce = tostring(generatekey())
    else
        local r = tostring(os.clock()) .. tostring(tick()) .. tostring(gcinfo())
        local z_399b1d = 0
        for l_3b26c7d = 1, #r do
            z_399b1d = bit32.band(bit32.bxor(bit32.lrotate(z_399b1d, 5), string.byte(r, l_3b26c7d)), 0xFFFFFFFF)
        end
        nonce = string.format("%08x", z_399b1d)
    end
    local place = "0"
    pcall(function() place = tostring(game.PlaceId) end)
    local bnonce = ""
    if ctx then
        bnonce = tostring(ctx.z_66c80bd9 or "")
    end
    local url = baseUrl .. "/key?id=" .. keyId .. "&place=" .. place .. "&nonce=" .. nonce
    if #bnonce > 0 then
        url = url .. "&bn=" .. bnonce
    end
    local httpGet = nil
    if ctx then
        local fromCtx = ctx.l_7795f460
        if type(fromCtx) == "function" then
            httpGet = fromCtx
        end
    end
    if type(httpGet) ~= "function" and type(l_7795f460) == "function" then
        httpGet = l_7795f460
    end
    if type(httpGet) ~= "function" then
        return nil
    end
    local raw = httpGet(url)
    if type(raw) ~= "string" or #raw == 0 then
        return nil
    end
    local decoded = nil
    pcall(function()
        decoded = game:GetService("HttpService"):JSONDecode(raw)
    end)
    if type(decoded) ~= "table" or type(decoded.key) ~= "string" then
        return nil
    end
    local hexKey = decoded.key:gsub("^0[xX]", "")
    if #hexKey ~= 64 then
        return nil
    end
    local jobId = ""
    pcall(function() jobId = tostring(game.JobId) end)
    if #jobId == 0 then
        return nil
    end
    local function __mul32m(a, b)
        local a_low = bit32.band(a, 0xFFFF)
        local a_high = bit32.rshift(a, 16)
        local b_low = bit32.band(b, 0xFFFF)
        local b_high = bit32.rshift(b, 16)
        local low_prod = a_low * b_low
        local mid = bit32.band(a_low * b_high + a_high * b_low, 0xFFFF)
        return bit32.band(low_prod + bit32.lshift(mid, 16), 0xFFFFFFFF)
    end
    local function __fnv1a32(s)
        local h = 0x811C9DC5
        for l_3b26c7d = 1, #s do
            h = bit32.bxor(h, string.byte(s, l_3b26c7d))
            h = __mul32m(h, 0x01000193)
        end
        return h
    end
    local _5c670 = __fnv1a32(jobId .. "|" .. place .. "|" .. keyId)
    local maskBytes = {}
    local h = _5c670
    for l_3b26c7d = 0, 7 do
        h = bit32.band(__mul32m(bit32.bxor(bit32.lrotate(h, 13), __mul32m(l_3b26c7d + 1, 0x9E3779B9)), 0x5BD1E995) + 0x165667B1, 0xFFFFFFFF)
        h = bit32.bxor(h, bit32.lrotate(_5c670, (l_3b26c7d % 7) + 3))
        maskBytes[l_3b26c7d * 4 + 1] = bit32.band(h, 0xFF)
        maskBytes[l_3b26c7d * 4 + 2] = bit32.band(bit32.rshift(h, 8), 0xFF)
        maskBytes[l_3b26c7d * 4 + 3] = bit32.band(bit32.rshift(h, 16), 0xFF)
        maskBytes[l_3b26c7d * 4 + 4] = bit32.band(bit32.rshift(h, 24), 0xFF)
    end
    local _7aae0 = {}
    for l_3b26c7d = 1, 8 do
        local word = tonumber(hexKey:sub((l_3b26c7d - 1) * 8 + 1, l_3b26c7d * 8), 16)
        if word == nil then
            return nil
        end
        local m = (maskBytes[(l_3b26c7d - 1) * 4 + 1] or 0) * 0x1000000
            + (maskBytes[(l_3b26c7d - 1) * 4 + 2] or 0) * 0x10000
            + (maskBytes[(l_3b26c7d - 1) * 4 + 3] or 0) * 0x100
            + (maskBytes[(l_3b26c7d - 1) * 4 + 4] or 0)
        _7aae0[l_3b26c7d] = bit32.bxor(word, bit32.band(m, 0xFFFFFFFF))
    end
    if ctx then
        ctx.x_566f9 = _7aae0
    end
    local function __mul32x(a, b)
        local a_low = bit32.band(a, 0xFFFF)
        local a_high = bit32.rshift(a, 16)
        local b_low = bit32.band(b, 0xFFFF)
        local b_high = bit32.rshift(b, 16)
        local low_prod = a_low * b_low
        local mid = bit32.band(a_low * b_high + a_high * b_low, 0xFFFF)
        return bit32.band(low_prod + bit32.lshift(mid, 16), 0xFFFFFFFF)
    end
    local h = 0x6A09E667
    for l_3b26c7d = 1, 8 do
        local w = _7aae0[l_3b26c7d]
        h = bit32.band(__mul32x(bit32.bxor(bit32.lrotate(h, 13), w), 0x5BD1E995) + 0x165667B1, 0xFFFFFFFF)
        h = bit32.bxor(h, bit32.rrotate(w, 5))
    end
    local t = bit32.band(__mul32x(bit32.bxor(bit32.lrotate(h, 11), 0x9E3779B9), 0x27D4EB2D) + 0x85EBCA6B, 0xFFFFFFFF)
    local token = bit32.band(t, 0x7FFFFFFF)
    if token == 0 then
        token = 1
    end
    if ctx then
        ctx.sessionToken = token
        ctx.v_51dfa490 = token
        ctx.__derived_session_token = true
    end
    return _7aae0
end
local function _0xf9f0d5c(z_2d48c7a)
    return function(ctx)
local __live = ctx.x_b2eebf71 or 0
local shards = ctx.x_9da737d
        if type(shards) ~= "table" then
            return
        end
        local len = 0
        for __ord = 0, 99 do
            local s = shards[((bit32.rrotate(__live, 5) + __ord * 63) % 100) + 1]
            if type(s) == "table" then
                len = len + #s
            else
                return
            end
        end
        if len == 0 then return end
        local rawBuf = buffer.create(len)
        local _5c670 = bit32.band(z_2d48c7a, 0xFFFFFFFF)
        local counter = 0
        local block = table.create(64)
        local blockIdx = 65
        local function __qr(st, a, b, c, d)
            st[a] = bit32.band(st[a] + st[b], 0xFFFFFFFF)
            st[d] = bit32.lrotate(bit32.bxor(st[d], st[a]), 16)
            st[c] = bit32.band(st[c] + st[d], 0xFFFFFFFF)
            st[b] = bit32.lrotate(bit32.bxor(st[b], st[c]), 12)
            st[a] = bit32.band(st[a] + st[b], 0xFFFFFFFF)
            st[d] = bit32.lrotate(bit32.bxor(st[d], st[a]), 8)
            st[c] = bit32.band(st[c] + st[d], 0xFFFFFFFF)
            st[b] = bit32.lrotate(bit32.bxor(st[b], st[c]), 7)
        end
        local function __gen_block()
            local st = {
                0x61707865, 0x3320646e, 0x79622d32, 0x6b206574,
                _5c670, bit32.bxor(_5c670, 0x5A5A5A5A), bit32.band(_5c670 + 0x12345678, 0xFFFFFFFF), bit32.bxor(_5c670, 0xA5A5A5A5),
                bit32.band(_5c670 + 0x9E3779B9, 0xFFFFFFFF), bit32.bxor(_5c670, 0xDEADBEEF), bit32.band(_5c670 + 0x85EBCA6B, 0xFFFFFFFF), bit32.bxor(_5c670, 0xC2B2AE35),
                counter, 0, 0x1337BEEF, 0xCAFEBABE
            }
            counter = counter + 1
            local w = table.create(16)
            for l_3b26c7d = 1, 16 do w[l_3b26c7d] = st[l_3b26c7d] end
            for r = 1, 10 do
                __qr(w, 1, 5, 9, 13)
                __qr(w, 2, 6, 10, 14)
                __qr(w, 3, 7, 11, 15)
                __qr(w, 4, 8, 12, 16)
                __qr(w, 1, 6, 11, 16)
                __qr(w, 2, 7, 12, 13)
                __qr(w, 3, 8, 9, 14)
                __qr(w, 4, 5, 10, 15)
            end
            local bIdx = 1
            for l_3b26c7d = 1, 16 do
                local word = bit32.band(w[l_3b26c7d] + st[l_3b26c7d], 0xFFFFFFFF)
                block[bIdx] = bit32.band(word, 0xFF)
                block[bIdx + 1] = bit32.band(bit32.rshift(word, 8), 0xFF)
                block[bIdx + 2] = bit32.band(bit32.rshift(word, 16), 0xFF)
                block[bIdx + 3] = bit32.band(bit32.rshift(word, 24), 0xFF)
                bIdx = bIdx + 4
            end
            blockIdx = 1
        end
local writePos = 0
        for __ord = 0, 99 do
            local s = shards[((bit32.rrotate(__live, 5) + __ord * 63) % 100) + 1]
            for j = 1, #s do
                if blockIdx > 64 then
                    __gen_block()
                end
                local keyByte = block[blockIdx]
                blockIdx = blockIdx + 1
                local encByte = s[j]
                buffer.writeu8(rawBuf, writePos, bit32.bxor(encByte, keyByte))
                writePos = writePos + 1
            end
        end
        if type(table.clear) == "function" then
            table.clear(shards)
        end
        ctx.x_9da737d = nil
        local _55afda2 = 2
        local constCount = buffer.readu16(rawBuf, _55afda2); _55afda2 = _55afda2 + 2
        local constants = table.create(constCount)
        for l_3b26c7d = 1, constCount do
            local ctype = buffer.readu8(rawBuf, _55afda2); _55afda2 = _55afda2 + 1
            if ctype == 0 then
                constants[l_3b26c7d] = nil
            elseif ctype == 1 then
                constants[l_3b26c7d] = false
            elseif ctype == 2 then
                constants[l_3b26c7d] = true
            elseif ctype == 3 then
                constants[l_3b26c7d] = buffer.readf64(rawBuf, _55afda2); _55afda2 = _55afda2 + 8
            elseif ctype == 4 then
                local slen = buffer.readu16(rawBuf, _55afda2); _55afda2 = _55afda2 + 2
                constants[l_3b26c7d] = buffer.readstring(rawBuf, _55afda2, slen); _55afda2 = _55afda2 + slen
            else
                return
            end
        end
        local bcCount = buffer.readu16(rawBuf, _55afda2); _55afda2 = _55afda2 + 2
        if bcCount < 1 or bcCount > 65535 then return end
        local bytecode = table.create(bcCount)
        for l_3b26c7d = 1, bcCount do
            bytecode[l_3b26c7d] = buffer.readu16(rawBuf, _55afda2); _55afda2 = _55afda2 + 2
        end
        local subCount = buffer.readu16(rawBuf, _55afda2); _55afda2 = _55afda2 + 2
        if subCount > 4096 then return end
        local subRoutines = table.create(subCount)
        for s = 1, subCount do
            local subId = buffer.readu16(rawBuf, _55afda2); _55afda2 = _55afda2 + 2
            local nameIdx = buffer.readu16(rawBuf, _55afda2); _55afda2 = _55afda2 + 2
            local paramCount = buffer.readu16(rawBuf, _55afda2); _55afda2 = _55afda2 + 2
            if paramCount > 256 then return end
            local params = table.create(paramCount)
            for p = 1, paramCount do
                local pIdx = buffer.readu16(rawBuf, _55afda2); _55afda2 = _55afda2 + 2
                params[p] = constants[pIdx]
            end
            local subBcCount = buffer.readu16(rawBuf, _55afda2); _55afda2 = _55afda2 + 2
            if subBcCount > 65535 then return end
            local subBc = table.create(subBcCount)
            for b = 1, subBcCount do
                subBc[b] = buffer.readu16(rawBuf, _55afda2); _55afda2 = _55afda2 + 2
            end
            subRoutines[subId] = {
                id = subId,
                name = constants[nameIdx],
                params = params,
                bytecode = subBc,
            }
        end
        buffer.fill(rawBuf, 0, 0, len)
        local executor = ctx.v_732c9 or ctx["v_732c9"]
        if type(executor) == "function" then
            local env = table.create(16)
            executor(bytecode, constants, subRoutines, env, 1, #bytecode)
        end
    end
end
local z_a516627 = 274.31
local function _0xe090ac3(a, b)
    local x = bit32.bxor(a or 3849, 0x3FBB9818)
    local y = bit32.band(b or 0, 0xFFFF)
    local z = bit32.bor(x, y) + bit32.band(x, y)
    if z == 0x6FC5064A then
        return bit32.lrotate(z, 5)
    end
    return bit32.bxor(z, 0x5A5A)
end
local v_0db6f093 = {
    0x09, 0x6e, 0x72, 0x62, 0x9b, 0x13, 0x11, 0xb8, 0x40, 0x27, 0x81, 0x1b, 0x06, 0xc6, 0x34,
}
local z_bbdf5a = 173.23
local _8d17c = 496.94
local function _0x5ed387(q1x, q1y, q1z, q1w, t)
    local factor = math.clamp(t or 0.5, 0.0, 1.0)
    local invFactor = 1.0 - factor
    local rx = (q1x * invFactor) + (0.0 * factor)
    local ry = (q1y * invFactor) + (0.707 * factor)
    local rz = (q1z * invFactor) + (0.0 * factor)
    local rw = (q1w * invFactor) + (0.707 * factor)
    local mag = math.sqrt(rx * rx + ry * ry + rz * rz + rw * rw)
    return mag > 0.0001 and math.floor((ry / mag) * 1000) or 76
end
local function _0x2e7877(ox, oy, dx, dy)
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
local function _0x007afa5(ctx)
    if type(ctx) ~= "table" then
        return
    end
    local __live = ctx.x_b2eebf71
    if type(__live) ~= "number" then
        return
    end
    local keyWords = ctx.x_566f9
    if true then
        if type(keyWords) ~= "table" then
            local fetched = x_307f40f(ctx.z_e7885, (ctx._6978ce0 or ""), ctx)
            if type(fetched) ~= "table" then
                return
            end
            keyWords = fetched
        end
    end
    local remoteToken = ctx.sessionToken or ctx.v_51dfa490
    if type(remoteToken) ~= "number" or remoteToken == 0 then
        return
    end
    local verified = z_e8da85c(ctx)
    if not verified then
        return
    end
    l_618bf(ctx, 1369001398, 863460901)
    if type(ctx.x_9da737d) ~= "table" then ctx.x_9da737d = {} end
    ctx.x_9da737d[((bit32.rrotate(__live, 5) + 6237) % 100) + 1] = v_0db6f093
    local collected = 0
    for s = 1, 100 do
        if type(ctx.x_9da737d[s]) == "table" then
            collected = collected + 1
        end
    end
    if collected < 100 then
        return
    end
    local z_2d48c7a
    if true then
        z_2d48c7a = x_404e82a(ctx, remoteToken)
        if type(z_2d48c7a) ~= "number" then
            return
        end
    else
        local mixedKey = bit32.bxor(bit32.lrotate(ctx.z_6c996, 7), remoteToken)
        z_2d48c7a = bit32.band(_0xcff095f4(mixedKey, 0x5BD1E995) + 0x165667B1, 0xFFFFFFFF)
    end
    local v_e5c4665 = _0xf9f0d5c(z_2d48c7a)
    if type(v_e5c4665) == "function" then
        pcall(v_e5c4665, ctx)
    end
    z_2d48c7a = 0
    ctx.sessionToken = nil
    ctx.v_51dfa490 = nil
    ctx.x_b2eebf71 = nil
    ctx.l_b77f5cef = 0x7ADA70E0
end
return function(ctx)
    local __state = ctx.l_b77f5cef or 0x52A1992F
    if __state == 0x4AAA29C0 then
        _0x007afa5(ctx)
    end
    return ctx
end