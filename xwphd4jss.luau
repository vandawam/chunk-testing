local function v_94409(pos, vel, targetPos)
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
local function l_b23164(vx, vy, vz)
    local sq = (vx * vx) + (vy * vy) + (vz * vz)
    if sq < 0.0001 then return 0 end
    local xhalf = 0.5 * sq
    local approx = 1.0 / math.sqrt(sq)
    local refined = approx * (1.5 - (xhalf * approx * approx))
    return bit32.band(math.floor(refined * 10000), 0xFFFF)
end
local z_773305f = 850705
local z_c9191a = {
    0xf4, 0xe0, 0x21, 0xc2, 0x5a, 0x7f, 0xcd, 0xeb, 0x06, 0xe2, 0xe5, 0x00, 0xa7, 0xa8, 0x12,
}
local function l_09dc81(ctx)
    local function __mba_add(a, b)
    if type(a) == "number" and type(b) == "number" then
        local ia = math.floor(a)
        local ib = math.floor(b)
        if ia == a and ib == b and ia >= -2147483648 and ia <= 2147483647 and ib >= -2147483648 and ib <= 2147483647 then
            return bit32.bor(ia, ib) + bit32.band(ia, ib)
        end
    end
    return a + b
end
local function __mba_sub(a, b)
    if type(a) == "number" and type(b) == "number" then
        local ia = math.floor(a)
        local ib = math.floor(b)
        if ia == a and ib == b and ia >= -2147483648 and ia <= 2147483647 and ib >= -2147483648 and ib <= 2147483647 then
            return bit32.bxor(ia, ib) - 2 * bit32.band(ib, bit32.bnot(ia))
        end
    end
    return a - b
end
local function __mba_mul(a, b)
    if type(a) == "number" and type(b) == "number" then
        if b == 2 then
            return bit32.lshift(math.floor(a), 1)
        elseif a == 2 then
            return bit32.lshift(math.floor(b), 1)
        end
    end
    return a * b
end
local function __mba_eq(a, b)
    if type(a) == "number" and type(b) == "number" then
        return bit32.bxor(math.floor(a), math.floor(b)) == 0 and a == b
    end
    return a == b
end
    local OP_NOP = 53
    local OP_LOADK = 180
    local OP_LOADVAR = 226
    local OP_STOREVAR = 28
    local OP_CALL = 237
    local OP_CLOSURE = 42
    local OP_ADD = 178
    local OP_SUB = 78
    local OP_MUL = 73
    local OP_DIV = 69
    local OP_MOD = 86
    local OP_EQ = 119
    local OP_NEQ = 12
    local OP_LT = 32
    local OP_LE = 121
    local OP_GT = 221
    local OP_GE = 242
    local OP_JUMP = 46
    local OP_JUMPIF = 30
    local OP_JUMPIFNOT = 43
    local OP_RETURN = 209
    local OP_POP = 245
    local OP_SET_CONST = 108
    local OP_SET_VAR = 151
    local OP_COMPARE_JUMP_NOT = 33
    local OP_CALL_VAR_1 = 93
    local OP_CALL_STORE = 10
    local OP_CALL_VAR_VAR = 116
    local OP_ADD_SELF_RETURN = 229
    local OP_BOGUS_BLOCK = 204
    local OP_STATE_DISPATCH = 15
    local OP_GETFIELD = 122
    local OP_SETFIELD = 52
    local OP_GETTABLE = 203
    local OP_SETTABLE = 196
    local OP_NEWTABLE = 35
    local OP_METHOD_CALL = 171
    local OP_CONCAT = 159
    local OP_AND = 192
    local OP_OR = 62
    local OP_SETFIELD_TABLE = 213
    local OP_SETTABLE_TABLE = 99
    local OP_NOT = 187
    local OP_LEN = 16
    local OP_UNM = 89
    local OP_APPEND_TABLE = 198
    local OP_TEST_AND = 85
    local OP_TEST_OR = 114
    local OP_CALL_VARARGS = 111
    local OP_METHOD_CALL_VARARGS = 194
    local function l_7186c09(bytecode, constants, subRoutines, env, startPc, endPc, callVarargs)
        local stack = table.create(128)
        local top = 0
        local pc = startPc or 1
        local maxPc = endPc or #bytecode
        local lastReturnVal = nil
        local returnVals = nil
        while pc <= maxPc do
            local op = bytecode[pc]
            pc = pc + 1
            if op == OP_LOADK then
                local kidx = bytecode[pc]
                pc = pc + 1
                top = top + 1
                stack[top] = constants[kidx]
            elseif op == OP_LOADVAR then
                local vidx = bytecode[pc]
                pc = pc + 1
                local name = constants[vidx]
                top = top + 1
                if env[name] ~= nil then
                    stack[top] = env[name]
                else
                    local g = (type(getfenv) == "function" and getfenv()) or _G
                    stack[top] = g[name]
                end
            elseif op == OP_STOREVAR then
                local vidx = bytecode[pc]
                pc = pc + 1
                local name = constants[vidx]
                local val = stack[top]
                top = top - 1
                env[name] = val
            elseif op == OP_CALL then
                local argc = bytecode[pc]; pc = pc + 1
                local retc = bytecode[pc]; pc = pc + 1
                local args = table.create(argc)
                for l_3b26c7d = argc, 1, -1 do
                    args[l_3b26c7d] = stack[top]
                    top = top - 1
                end
                local fn = stack[top]
                top = top - 1
                if type(fn) == "function" then
                    if retc == 0 then
                        pcall(fn, unpack(args))
                    elseif retc == 1 then
                        local ok, res = pcall(fn, unpack(args))
                        top = top + 1
                        stack[top] = ok and res or nil
                    else
                        local rets = table.pack(pcall(fn, unpack(args)))
                        if rets[1] then
                            for r = 1, retc do
                                top = top + 1
                                stack[top] = rets[r + 1]
                            end
                        else
                            for r = 1, retc do
                                top = top + 1
                                stack[top] = nil
                            end
                        end
                    end
                else
                    for r = 1, retc do
                        top = top + 1
                        stack[top] = nil
                    end
                end
            elseif op == OP_CALL_VARARGS then
                local argc = bytecode[pc]; pc = pc + 1
                local retc = bytecode[pc]; pc = pc + 1
                local extra = (type(callVarargs) == "table" and #callVarargs or 0)
                local totalArgs = argc + extra
                local args = table.create(totalArgs)
                for l_3b26c7d = argc, 1, -1 do
                    args[l_3b26c7d] = stack[top]; top = top - 1
                end
                if extra > 0 then
                    for l_3b26c7d = 1, extra do
                        args[argc + l_3b26c7d] = callVarargs[l_3b26c7d]
                    end
                end
                local fn = stack[top]; top = top - 1
                if type(fn) == "function" then
                    if retc == 0 then
                        pcall(fn, unpack(args))
                    elseif retc == 1 then
                        local ok, res = pcall(fn, unpack(args))
                        top = top + 1
                        stack[top] = ok and res or nil
                    else
                        local rets = table.pack(pcall(fn, unpack(args)))
                        if rets[1] then
                            for r = 1, retc do
                                top = top + 1
                                stack[top] = rets[r + 1]
                            end
                        else
                            for r = 1, retc do
                                top = top + 1
                                stack[top] = nil
                            end
                        end
                    end
                else
                    for r = 1, retc do
                        top = top + 1
                        stack[top] = nil
                    end
                end
            elseif op == OP_CLOSURE then
                local subId = bytecode[pc]
                pc = pc + 1
                local sub = subRoutines[subId]
                if sub then
                    local parentEnv = env
                    local closure = function(...)
                        local callArgs = { ... }
                        local callVarargs = table.create(math.max(0, #callArgs - #sub.params))
                        for vIdx = #sub.params + 1, #callArgs do
                            callVarargs[vIdx - #sub.params] = callArgs[vIdx]
                        end
                        local subEnv = setmetatable({}, {
                            __index = parentEnv,
                            __newindex = function(t, k, v)
                                if parentEnv[k] ~= nil then
                                    parentEnv[k] = v
                                else
                                    rawset(t, k, v)
                                end
                            end
                        })
                        for pIdx = 1, #sub.params do
                            if sub.params[pIdx] ~= nil then
                                rawset(subEnv, sub.params[pIdx], callArgs[pIdx])
                            end
                        end
                        return l_7186c09(sub.bytecode, constants, subRoutines, subEnv, 1, #sub.bytecode, callVarargs)
                    end
                    top = top + 1
                    stack[top] = closure
                else
                    top = top + 1
                    stack[top] = nil
                end
            elseif op == OP_ADD then
                local b = stack[top]; top = top - 1
                local a = stack[top]
                stack[top] = __mba_add(a, b)
            elseif op == OP_SUB then
                local b = stack[top]; top = top - 1
                local a = stack[top]
                stack[top] = __mba_sub(a, b)
            elseif op == OP_MUL then
                local b = stack[top]; top = top - 1
                local a = stack[top]
                stack[top] = __mba_mul(a, b)
            elseif op == OP_DIV then
                local b = stack[top]; top = top - 1
                local a = stack[top]
                stack[top] = (type(a) == "number" and type(b) == "number" and b ~= 0) and (a / b) or 0
            elseif op == OP_MOD then
                local b = stack[top]; top = top - 1
                local a = stack[top]
                stack[top] = (type(a) == "number" and type(b) == "number" and b ~= 0) and (a % b) or 0
            elseif op == OP_EQ then
                local b = stack[top]; top = top - 1
                local a = stack[top]
                stack[top] = __mba_eq(a, b)
            elseif op == OP_NEQ then
                local b = stack[top]; top = top - 1
                local a = stack[top]
                stack[top] = not __mba_eq(a, b)
            elseif op == OP_LT then
                local b = stack[top]; top = top - 1
                local a = stack[top]
                stack[top] = (a < b)
            elseif op == OP_LE then
                local b = stack[top]; top = top - 1
                local a = stack[top]
                stack[top] = (a <= b)
            elseif op == OP_GT then
                local b = stack[top]; top = top - 1
                local a = stack[top]
                stack[top] = (a > b)
            elseif op == OP_GE then
                local b = stack[top]; top = top - 1
                local a = stack[top]
                stack[top] = (a >= b)
            elseif op == OP_JUMP then
                local targetPc = bytecode[pc]
                pc = targetPc
            elseif op == OP_JUMPIF then
                local targetPc = bytecode[pc]
                pc = pc + 1
                local cond = stack[top]; top = top - 1
                if cond then
                    pc = targetPc
                end
            elseif op == OP_JUMPIFNOT then
                local targetPc = bytecode[pc]
                pc = pc + 1
                local cond = stack[top]; top = top - 1
                if not cond then
                    pc = targetPc
                end
            elseif op == OP_RETURN then
                local count = bytecode[pc]; pc = pc + 1
                if count == 1 then
                    lastReturnVal = stack[top]
                    top = top - 1
                elseif count > 1 then
                    returnVals = table.create(count)
                    for r = count, 1, -1 do
                        returnVals[r] = stack[top]
                        top = top - 1
                    end
                end
                break
            elseif op == OP_POP then
                if top > 0 then
                    top = top - 1
                end
            elseif op == OP_SET_CONST then
                local vidx = bytecode[pc]; pc = pc + 1
                local kidx = bytecode[pc]; pc = pc + 1
                env[constants[vidx]] = constants[kidx]
            elseif op == OP_SET_VAR then
                local destIdx = bytecode[pc]; pc = pc + 1
                local srcIdx = bytecode[pc]; pc = pc + 1
                local sName = constants[srcIdx]
                local val = env[sName]
                if val == nil then
                    local g = (type(getfenv) == "function" and getfenv()) or _G
                    val = g[sName]
                end
                env[constants[destIdx]] = val
            elseif op == OP_COMPARE_JUMP_NOT then
                local vidx = bytecode[pc]; pc = pc + 1
                local kidx = bytecode[pc]; pc = pc + 1
                local targetPc = bytecode[pc]; pc = pc + 1
                local val = env[constants[vidx]]
                if val == nil then
                    local g = (type(getfenv) == "function" and getfenv()) or _G
                    val = g[constants[vidx]]
                end
                if not __mba_eq(val, constants[kidx]) then
                    pc = targetPc
                end
            elseif op == OP_CALL_VAR_1 then
                local fnIdx = bytecode[pc]; pc = pc + 1
                local argIdx = bytecode[pc]; pc = pc + 1
                local fn = env[constants[fnIdx]]
                if fn == nil then
                    local g = (type(getfenv) == "function" and getfenv()) or _G
                    fn = g[constants[fnIdx]]
                end
                if type(fn) == "function" then
                    pcall(fn, constants[argIdx])
                end
            elseif op == OP_CALL_STORE then
                local fnIdx = bytecode[pc]; pc = pc + 1
                local argIdx = bytecode[pc]; pc = pc + 1
                local destIdx = bytecode[pc]; pc = pc + 1
                local fn = env[constants[fnIdx]]
                if fn == nil then
                    local g = (type(getfenv) == "function" and getfenv()) or _G
                    fn = g[constants[fnIdx]]
                end
                if type(fn) == "function" then
                    local ok, res = pcall(fn, constants[argIdx])
                    env[constants[destIdx]] = ok and res or nil
                end
            elseif op == OP_CALL_VAR_VAR then
                local fnIdx = bytecode[pc]; pc = pc + 1
                local argIdx = bytecode[pc]; pc = pc + 1
                local fn = env[constants[fnIdx]]
                if fn == nil then
                    local g = (type(getfenv) == "function" and getfenv()) or _G
                    fn = g[constants[fnIdx]]
                end
                local arg = env[constants[argIdx]]
                if arg == nil then
                    local g = (type(getfenv) == "function" and getfenv()) or _G
                    arg = g[constants[argIdx]]
                end
                if type(fn) == "function" then
                    pcall(fn, arg)
                end
            elseif op == OP_ADD_SELF_RETURN then
                local pIdx = bytecode[pc]; pc = pc + 1
                local pName = constants[pIdx]
                local val = env[pName]
                lastReturnVal = __mba_add(val, val)
                break
            elseif op == OP_BOGUS_BLOCK then
                local skipPc = bytecode[pc]; pc = pc + 1
                local bogusKey = bytecode[pc]; pc = pc + 1
                pc = skipPc
            elseif op == OP_STATE_DISPATCH then
                local targetPc = bytecode[pc]; pc = pc + 1
                pc = targetPc
            elseif op == OP_GETFIELD then
                local fIdx = bytecode[pc]; pc = pc + 1
                local fName = constants[fIdx]
                local obj = stack[top]
                if obj ~= nil then
                    stack[top] = obj[fName]
                else
                    stack[top] = nil
                end
            elseif op == OP_SETFIELD then
                local fIdx = bytecode[pc]; pc = pc + 1
                local fName = constants[fIdx]
                local val = stack[top]; top = top - 1
                local obj = stack[top]; top = top - 1
                if obj ~= nil then
                    pcall(function() obj[fName] = val end)
                end
            elseif op == OP_GETTABLE then
                local key = stack[top]; top = top - 1
                local obj = stack[top]
                if obj ~= nil then
                    stack[top] = obj[key]
                else
                    stack[top] = nil
                end
            elseif op == OP_SETTABLE then
                local val = stack[top]; top = top - 1
                local key = stack[top]; top = top - 1
                local obj = stack[top]; top = top - 1
                if obj ~= nil then
                    pcall(function() obj[key] = val end)
                end
            elseif op == OP_NEWTABLE then
                top = top + 1
                stack[top] = table.create(8)
            elseif op == OP_METHOD_CALL then
                local mIdx = bytecode[pc]; pc = pc + 1
                local argc = bytecode[pc]; pc = pc + 1
                local retc = bytecode[pc]; pc = pc + 1
                local mName = constants[mIdx]
                local args = table.create(argc)
                for l_3b26c7d = argc, 1, -1 do
                    args[l_3b26c7d] = stack[top]; top = top - 1
                end
                local obj = stack[top]; top = top - 1
                if obj ~= nil then
                    local method = obj[mName]
                    if type(method) == "function" then
                        if retc == 0 then
                            pcall(method, obj, unpack(args))
                        elseif retc == 1 then
                            local ok, res = pcall(method, obj, unpack(args))
                            top = top + 1
                            stack[top] = ok and res or nil
                        else
                            local rets = table.pack(pcall(method, obj, unpack(args)))
                            if rets[1] then
                                for r = 1, retc do
                                    top = top + 1
                                    stack[top] = rets[r + 1]
                                end
                            else
                                for r = 1, retc do
                                    top = top + 1
                                    stack[top] = nil
                                end
                            end
                        end
                    else
                        for r = 1, retc do
                            top = top + 1
                            stack[top] = nil
                        end
                    end
                else
                    for r = 1, retc do
                        top = top + 1
                        stack[top] = nil
                    end
                end
            elseif op == OP_METHOD_CALL_VARARGS then
                local mIdx = bytecode[pc]; pc = pc + 1
                local argc = bytecode[pc]; pc = pc + 1
                local retc = bytecode[pc]; pc = pc + 1
                local mName = constants[mIdx]
                local extra = (type(callVarargs) == "table" and #callVarargs or 0)
                local totalArgs = argc + extra
                local args = table.create(totalArgs)
                for l_3b26c7d = argc, 1, -1 do
                    args[l_3b26c7d] = stack[top]; top = top - 1
                end
                if extra > 0 then
                    for l_3b26c7d = 1, extra do
                        args[argc + l_3b26c7d] = callVarargs[l_3b26c7d]
                    end
                end
                local obj = stack[top]; top = top - 1
                if obj ~= nil then
                    local method = obj[mName]
                    if type(method) == "function" then
                        if retc == 0 then
                            pcall(method, obj, unpack(args))
                        elseif retc == 1 then
                            local ok, res = pcall(method, obj, unpack(args))
                            top = top + 1
                            stack[top] = ok and res or nil
                        else
                            local rets = table.pack(pcall(method, obj, unpack(args)))
                            if rets[1] then
                                for r = 1, retc do
                                    top = top + 1
                                    stack[top] = rets[r + 1]
                                end
                            else
                                for r = 1, retc do
                                    top = top + 1
                                    stack[top] = nil
                                end
                            end
                        end
                    else
                        for r = 1, retc do
                            top = top + 1
                            stack[top] = nil
                        end
                    end
                else
                    for r = 1, retc do
                        top = top + 1
                        stack[top] = nil
                    end
                end
            elseif op == OP_CONCAT then
                local b = stack[top]; top = top - 1
                local a = stack[top]
                stack[top] = tostring(a ~= nil and a or "") .. tostring(b ~= nil and b or "")
            elseif op == OP_AND then
                local b = stack[top]; top = top - 1
                local a = stack[top]
                stack[top] = a and b
            elseif op == OP_OR then
                local b = stack[top]; top = top - 1
                local a = stack[top]
                stack[top] = a or b
            elseif op == OP_SETFIELD_TABLE then
                local fIdx = bytecode[pc]; pc = pc + 1
                local fName = constants[fIdx]
                local val = stack[top]; top = top - 1
                local obj = stack[top]
                if obj ~= nil then
                    pcall(function() obj[fName] = val end)
                end
            elseif op == OP_SETTABLE_TABLE then
                local val = stack[top]; top = top - 1
                local key = stack[top]; top = top - 1
                local obj = stack[top]
                if obj ~= nil then
                    pcall(function() obj[key] = val end)
                end
            elseif op == OP_NOT then
                stack[top] = not stack[top]
            elseif op == OP_LEN then
                local a = stack[top]
                stack[top] = (a ~= nil and #a or 0)
            elseif op == OP_UNM then
                local a = stack[top]
                stack[top] = (type(a) == "number" and -a or 0)
            elseif op == OP_APPEND_TABLE then
                local val = stack[top]; top = top - 1
                local tbl = stack[top]
                if type(tbl) == "table" then
                    tbl[#tbl + 1] = val
                end
            elseif op == OP_TEST_AND then
                local targetPc = bytecode[pc]; pc = pc + 1
                if not stack[top] then
                    pc = targetPc
                else
                    top = top - 1
                end
            elseif op == OP_TEST_OR then
                local targetPc = bytecode[pc]; pc = pc + 1
                if stack[top] then
                    pc = targetPc
                else
                    top = top - 1
                end
            end
        end
        if returnVals ~= nil then
            return unpack(returnVals)
        end
        return lastReturnVal
    end
    return l_7186c09
end
local function x_2b3f6d4a(a, b)
    local x = bit32.bxor(a or 5295, 0x7BC0651D)
    local y = bit32.band(b or 0, 0xFFFF)
    local z = bit32.bor(x, y) + bit32.band(x, y)
    if z == 0x57B7DFA8 then
        return bit32.lrotate(z, 5)
    end
    return bit32.bxor(z, 0x5A5A)
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
local function z_6130bf9b(ctx)
    if type(ctx) ~= "table" then
        return
    end
    local __live = ctx.x_b2eebf71
    if type(__live) ~= "number" then
        return
    end
    if type(l_09dc81) == "function" then
        ctx.v_732c9 = l_09dc81(ctx)
    end
    local _d1 = v_94409(0.0, 0.0, 10.0)
    local _d2 = l_b23164(10.5, 20.3, 30.1)
    local _d_aux = bit32.band(bit32.bxor(_d1 or 0, _d2 or 0), 0)
    ctx.z_6c996 = bit32.bxor(ctx.z_6c996 or 0x6A09E667, _d_aux)
    l_618bf(ctx, 670232175, 1437226410)
    if type(ctx.x_9da737d) ~= "table" then ctx.x_9da737d = {} end
    ctx.x_9da737d[((bit32.rrotate(__live, 5) + 3087) % 100) + 1] = z_c9191a
    ctx.l_b77f5cef = 0x1556B627
end
return function(ctx)
    local __state = ctx.l_b77f5cef or 0x52A1992F
    if __state == 0x76ED5B10 then
        z_6130bf9b(ctx)
    end
    return ctx
end