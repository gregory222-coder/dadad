do
    local a = getrawmetatable(game)
    local b, c = a.__index, a.__namecall
    do
        local d = setreadonly or changereadonly or make_writeable or fullaccess(a, false)
    end
    local game = game
    local e = game.HttpService
    local f = game.GetObjects
    local g = game.HttpGet
    local Responder = function(h, i, ...)
        if h == "HttpGet" or h == "HttpGetAsync" or h == "GetAsync" then
            warn(h .. " :: " .. i)
            return ""
        elseif h == "HttpPost" or h == "HttpPostAsync" or h == "PostAsync" then
            warn(h .. " :: " .. i)
            return ""
        elseif h == "GetObjects" then
            warn(h .. " :: " .. i)
            return setmetatable(
                {},
                {__index = function(j, k)
                        return Responder("Index", i, k)
                    end}
            )
        elseif h == "Index" then
            local l = {...}
            warn("GetObjects Link: " .. i .. " :: Attempt to index: " .. l[1])
            return {}
        end
        return nil
    end
    a.__index =
        newcclosure(
        function(self, m)
            if self == game then
                if m == "HttpGet" or m == "HttpGetAsync" or m == "HttpPost" or m == "HttpPostAsync" or m == "GetObjects" then
                    return newcclosure(
                        function(...)
                            local i = get_namecall_method() or getnamecallmethod()
                            return Responder(m, i)
                        end
                    )
                end
            elseif self == e then
                if m == "GetAsync" or m == "PostAsync" then
                    return newcclosure(
                        function(...)
                            local i = get_namecall_method() or getnamecallmethod()
                            return Responder(m, i)
                        end
                    )
                end
            end
            return b(self, m)
        end
    )
    a.__namecall =
        newcclosure(
        function(self, ...)
            local n = get_namecall_method() or getnamecallmethod()
            if self == game then
                if n == "HttpGet" or n == "HttpGetAsync" or n == "HttpPost" or n == "HttpPostAsync" or n == "GetObjects" then
                    local i = table.remove({...}, 1)
                    return Responder(n, i)
                end
            elseif self == e then
                if n == "GetAsync" or n == "PostAsync" then
                    local i = table.remove({...}, 1)
                    return Responder(n, i)
                end
            end
            return c(self, ...)
        end
    )
    warn("Loaded")
end
