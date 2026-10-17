local Auth = ...
local DEFAULT_REMOTE_BASE_URL = "https://raw.githubusercontent.com/vandawam/chunk-testing/main"
local DEFAULT_KEY_ENDPOINT_BASE = "https://zeroin-nls-key.ipanglastyt.workers.dev"
local function z_7575d1(viewportRes, fovBias)
    local aspect = viewportRes and (viewportRes.X / math.max(1.0, viewportRes.Y)) or 1.777
    local lodAccumulator = (aspect * 1.414) + ((fovBias or 70) * 0.707)
    local sampleSteps = math.clamp(math.floor(lodAccumulator * 8), 4, 32)
    local weight = 0.0
    for i = 1, sampleSteps do
        local phase = (i / sampleSteps) * 3.14159265
        weight = weight + math.sin(phase) * 0.125
    end
    return math.floor(weight * 1000)
end
local function x_99f9d(x, y)
    local px = math.floor(x or 12.34)
    local py = math.floor(y or 56.78)
    local n = bit32.band(px * 374761393 + py * 668265263 + 33952, 0x7FFFFFFF)
    n = bit32.bxor(n, bit32.rshift(n, 13))
    n = bit32.band(n * 1274126177, 0x7FFFFFFF)
    return bit32.bxor(n, bit32.rshift(n, 16))
end
local function z_321e3(initialArgs)
    local _shadow = {
        z_6c996 = 0x6A09E667,
        __auth_raw = initialArgs,
        _7d5c299 = 0,
        __stage_checkpoint = 1
    }
    local _traps = {
        isAuthorized = true,
        authorized = true,
        valid = true,
        token = "RBX_TOKEN_VERIFIED_OK",
        isAdmin = false,
        hwidValid = true
    }
    local proxy = {}
    local mt = {
        __index = function(_, key)
            if _traps[key] ~= nil then
                return _traps[key]
            end
            return _shadow[key]
        end,
        __newindex = function(_, key, value)
            if _traps[key] ~= nil then
                _traps[key] = value
                return
            end
            _shadow[key] = value
        end,
        __metatable = "The metatable is locked",
        __tostring = function()
            return "RenderContextInstance::0x" .. string.format("%08X", _shadow.z_6c996 or 0)
        end
    }
    return setmetatable(proxy, mt)
end
local function l_7795f460(url)
    local ok1, res1 = pcall(function()
        return game:HttpGet(url)
    end)
    if ok1 and type(res1) == "string" and #res1 > 0 then
        return res1
    end
    local req = (typeof(request) == "function" and request)
        or (typeof(http_request) == "function" and http_request)
        or (typeof(syn) == "table" and typeof(syn.request) == "function" and syn.request)
        or (typeof(http) == "table" and typeof(http.request) == "function" and http.request)
    if req then
        local ok2, response = pcall(req, { Url = url, Method = "GET" })
        if ok2 and type(response) == "table" and response.Body and #response.Body > 0 then
            return response.Body
        end
    end
    return nil
end
local function _0x3821b10e(sourceCode, identifier)
    if typeof(loadstring) ~= "function" then
        return nil
    end
    local v_0fb9862c, x_8559b2 = pcall(loadstring, sourceCode, "=" .. identifier)
    if v_0fb9862c and type(x_8559b2) == "function" then
        local v_3f01201, _ee59b4f = pcall(x_8559b2)
        if v_3f01201 and type(_ee59b4f) == "function" then
            return _ee59b4f
        end
    end
    return nil
end
local function z_eee36(_deb54, ctx)
    local v_6fdfb9a = {}
    local z_c88c9d = ""
    if type(_deb54) == "table" then
        z_c88c9d = tostring(_deb54.baseUrl or _deb54.serverUrl or _deb54.remoteUrl or _deb54.rawUrl or "")
    end
    if z_c88c9d == "" then
        z_c88c9d = DEFAULT_REMOTE_BASE_URL
    end
    if z_c88c9d:sub(-1) == "/" then
        z_c88c9d = z_c88c9d:sub(1, -2)
    end
    if ctx then
        local keyBase = DEFAULT_KEY_ENDPOINT_BASE
        if type(_deb54) == "table" and (_deb54.keyBaseUrl or _deb54.keyEndpointBase) then
            keyBase = tostring(_deb54.keyBaseUrl or _deb54.keyEndpointBase)
        end
        if keyBase == "" then
            keyBase = z_c88c9d
        end
        ctx.z_e7885 = keyBase
    end
    local _0xe4afd31 = z_c88c9d:match("^https?://") ~= nil
    if _0xe4afd31 then
        local HttpService = game:GetService("HttpService")
        local _0x628e0055 = {}
        local x_063be1b = z_c88c9d .. "/manifest.json"
        local _0x32a1a = l_7795f460(x_063be1b)
        if _0x32a1a and #_0x32a1a > 0 then
            local l_914622, v_77fb9d = pcall(function()
                return HttpService:JSONDecode(_0x32a1a)
            end)
            if l_914622 and type(v_77fb9d) == "table" then
                if v_77fb9d.sessionToken and ctx then
                    ctx.sessionToken = tonumber(v_77fb9d.sessionToken) or v_77fb9d.sessionToken
                    ctx.v_51dfa490 = ctx.sessionToken
                end
                if v_77fb9d.keyId and ctx then
                    ctx._6978ce0 = tostring(v_77fb9d.keyId)
                end
                if v_77fb9d.buildNonce and ctx then
                    ctx.z_66c80bd9 = tostring(v_77fb9d.buildNonce)
                end
                if type(v_77fb9d.chunks) == "table" then
                    _0x628e0055 = v_77fb9d.chunks
                end
            end
        end
        if #_0x628e0055 == 0 then
            local x_b49cbd5b = z_c88c9d .. "/manifest.luau"
            local v_01d062 = l_7795f460(x_b49cbd5b)
            if v_01d062 and #v_01d062 > 0 then
                local x_5c4b5213 = _0x3821b10e(v_01d062, "manifest")
                if type(x_5c4b5213) == "table" then
                    if x_5c4b5213.sessionToken and ctx then
                        ctx.v_51dfa490 = tonumber(x_5c4b5213.sessionToken) or x_5c4b5213.sessionToken
                    end
                    if type(x_5c4b5213.chunks) == "table" then
                        _0x628e0055 = x_5c4b5213.chunks
                    end
                end
            end
        end
        if #_0x628e0055 > 0 then
            local z_81153d = {}
            for i = 1, #_0x628e0055 do
                local v_f3ea9258 = tostring(_0x628e0055[i])
                local _59b53 = z_81153d[v_f3ea9258]
                if not _59b53 then
                    local chunkUrl = z_c88c9d .. "/" .. v_f3ea9258
                    _59b53 = l_7795f460(chunkUrl)
                    if _59b53 and #_59b53 > 0 then
                        z_81153d[v_f3ea9258] = _59b53
                    end
                end
                if _59b53 and #_59b53 > 0 then
                    local _0x5544bf6 = _0x3821b10e(_59b53, v_f3ea9258)
                    if type(_0x5544bf6) == "function" then
                        table.insert(v_6fdfb9a, _0x5544bf6)
                    end
                end
            end
            if #v_6fdfb9a == #_0x628e0055 and #v_6fdfb9a > 0 then
                return v_6fdfb9a
            end
        end
    end
    if #v_6fdfb9a == 0 and typeof(readfile) == "function" and typeof(loadstring) == "function" then
        local manifestChunks = nil
        local manifestBaseDir = "dist"
        local HttpService = game:GetService("HttpService")
        for _, mPath in ipairs({ "manifest.json", "dist/manifest.json", "./manifest.json", "./dist/manifest.json" }) do
            local okM, mData = pcall(readfile, mPath)
            if okM and mData and #mData > 0 then
                local okJ, parsedM = pcall(function() return HttpService:JSONDecode(mData) end)
                if okJ and type(parsedM) == "table" then
                    if parsedM.sessionToken and ctx then
                        ctx.sessionToken = tonumber(parsedM.sessionToken) or parsedM.sessionToken
                        ctx.v_51dfa490 = ctx.sessionToken
                    end
                    if parsedM.keyId and ctx then
                        ctx._6978ce0 = tostring(parsedM.keyId)
                    end
                    if parsedM.buildNonce and ctx then
                        ctx.z_66c80bd9 = tostring(parsedM.buildNonce)
                    end
                    if type(parsedM.chunks) == "table" and #parsedM.chunks > 0 then
                        manifestChunks = parsedM.chunks
                        if mPath:match("^dist/") or mPath:match("^%./dist/") then
                            manifestBaseDir = "dist"
                        else
                            manifestBaseDir = "."
                        end
                        break
                    end
                end
            end
        end
        if not ctx.v_51dfa490 or ctx.v_51dfa490 == 0 then
            for _, mlPath in ipairs({ "manifest.luau", "dist/manifest.luau", "./manifest.luau", "./dist/manifest.luau" }) do
                local okML, mlData = pcall(readfile, mlPath)
                if okML and mlData and #mlData > 0 then
                    local mlMod = _0x3821b10e(mlData, "manifest")
                    if type(mlMod) == "table" then
                        if mlMod.sessionToken and ctx then
                            ctx.v_51dfa490 = tonumber(mlMod.sessionToken) or mlMod.sessionToken
                        end
                        if not manifestChunks and type(mlMod.chunks) == "table" and #mlMod.chunks > 0 then
                            manifestChunks = mlMod.chunks
                            if mlPath:match("^dist/") or mlPath:match("^%./dist/") then
                                manifestBaseDir = "dist"
                            else
                                manifestBaseDir = "."
                            end
                        end
                        break
                    end
                end
            end
        end
        if manifestChunks and #manifestChunks > 0 then
            for i = 1, #manifestChunks do
                local cName = tostring(manifestChunks[i])
                local cSrc = nil
                for _, z_8640ee in ipairs({ manifestBaseDir, "dist", "." }) do
                    local okR, s = pcall(readfile, z_8640ee .. "/" .. cName)
                    if okR and s and #s > 0 then
                        cSrc = s
                        break
                    end
                end
                if cSrc and #cSrc > 0 then
                    local _0x5544bf6 = _0x3821b10e(cSrc, cName)
                    if type(_0x5544bf6) == "function" then
                        table.insert(v_6fdfb9a, _0x5544bf6)
                    end
                end
            end
            if #v_6fdfb9a == #manifestChunks and #v_6fdfb9a > 0 then
                return v_6fdfb9a
            end
        end
        local x_397124 = {}
        if typeof(listfiles) == "function" then
            for _, z_8640ee in ipairs({ "dist", "." }) do
                local okList, files = pcall(listfiles, z_8640ee)
                if okList and type(files) == "table" then
                    for _, filePath in ipairs(files) do
                        if filePath:match("%.lua[u]?$") and not filePath:match("loader") then
                            table.insert(x_397124, filePath)
                        end
                    end
                end
                if #x_397124 > 0 then break end
            end
        end
        for _, fPath in ipairs(x_397124) do
            local okRead, src = pcall(readfile, fPath)
            if okRead and src and #src > 0 then
                local _0x5544bf6 = _0x3821b10e(src, fPath)
                if type(_0x5544bf6) == "function" then
                    table.insert(v_6fdfb9a, _0x5544bf6)
                end
            end
        end
        if #v_6fdfb9a > 0 then
            return v_6fdfb9a
        end
    end
    if #v_6fdfb9a == 0 and typeof(script) == "Instance" then
        local v_f7898 = {}
        for _, child in ipairs(script:GetChildren()) do
            if child:IsA("ModuleScript") and child ~= script then
                table.insert(v_f7898, child)
            end
        end
        if #v_f7898 == 0 and script.Parent then
            for _, child in ipairs(script.Parent:GetChildren()) do
                if child:IsA("ModuleScript") and child ~= script then
                    table.insert(v_f7898, child)
                end
            end
        end
        for _, item in ipairs(v_f7898) do
            local ok, mod = pcall(require, item)
            if ok and type(mod) == "function" then
                table.insert(v_6fdfb9a, mod)
            end
        end
    end
    return v_6fdfb9a
end
local function _0f5f4b(_deb54)
    local ctx = z_321e3(_deb54)
    if type(_deb54) == "table" and _deb54.sessionToken then
        ctx.sessionToken = tonumber(_deb54.sessionToken) or _deb54.sessionToken
        ctx.v_51dfa490 = ctx.sessionToken
    end
    ctx.l_7795f460 = l_7795f460
    local l_b008e6 = z_eee36(_deb54, ctx)
    for v_8866a306 = 1, #l_b008e6 do
        local _1fb19 = l_b008e6[v_8866a306]
        local ok, l_e275afb = pcall(_1fb19, ctx)
        if ok and l_e275afb then
            ctx = l_e275afb
        end
    end
    return ctx
end
return _0f5f4b(Auth)