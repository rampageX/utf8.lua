return function(utf8)

function utf8.util.copy(obj, deep)
  if type(obj) == 'table' then
    local result = {}
    if deep then
      for k,v in pairs(obj) do
        result[k] = utf8.util.copy(v, true)
      end
    else
      for k,v in pairs(obj) do
        result[k] = v
      end
    end
    return result
  else
    return obj
  end
end

local function dump(val, tab)
  tab = tab or ''

  if type(val) == 'table' then
    for k,v in pairs(val) do
      utf8.config.logger(tab .. tostring(k))
      dump(v, tab .. '\t')
    end
  else
    utf8.config.logger(tab .. tostring(val))
  end
end

function utf8.util.debug(...)
  local t = {...}
  for _, v in ipairs(t) do
    if type(v) == "table" then
      return dump(t)
    end
  end

  return utf8.config.logger(...)
end

function utf8.debug(...)
  if utf8.config.debug then
    utf8.config.debug(...)
  end
end

function utf8.util.next(str, bs)
  local nbs1 = utf8.next(str, bs)
  local nbs2 = utf8.next(str, nbs1)
  return utf8.raw.sub(str, nbs1, nbs2 - 1), nbs1
end

return utf8.util

end
