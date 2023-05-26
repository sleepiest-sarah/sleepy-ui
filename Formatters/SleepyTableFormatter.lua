local f = {}
SleepyUI.Formatters.SleepyTableFormatter = f

function f:new(o)
  o = SleepyUI.Formatters.SleepyFormatter:new(o)
    
  o.__index.appendToCurrentRow = self.appendToCurrentRow
  o.__index.appendCurrentRow = self.appendCurrentRow
  o.__index.appendRow = self.appendRow
    
  return o
end

function f:appendToCurrentRow(text, colspan)
  self.row = self.row or {}
  
  table.insert(self.row, {text = text, colspan = colspan})
end

function f:appendCurrentRow()
  self:append(self.row)
  self.row = nil
end

function f:appendRow(...)
  self:append({...})
end

return f