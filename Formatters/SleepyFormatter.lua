local f = {}
SleepyUI.Formatters.SleepyFormatter = f

function f:new(o)
  o.buffer = {}
  
  setmetatable(o, self)
  self.__index = self
  return o
end

function f:format()
  return self.buffer
end

function f:append(s)
  table.insert(self.buffer, s)
end

function f:prepend(s)
  table.insert(self.buffer, 1, s)
end

function f:insert(s, i)
  table.insert(self.buffer, i, s)
end

return f