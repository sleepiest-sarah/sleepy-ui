SleepyTableMixin = CreateFromMixins(SleepyContainerMixin)
      
SleepyTableMixin.layout = "Table"
SleepyTableMixin.numColumns = 2
SleepyTableMixin.rowPadding = 0

--[[
  items = {
    {{obj = "row 1", colspan=2}},
    {{obj = "row 2a"}, {obj = "row 2b"}}
  }
--]]
function SleepyTableMixin:SetTableItems(table_def)  
  
  if (table_def and #table_def > 0) then
    local item_widgets = {}
    for i,row in ipairs(table_def) do
      local x_coord = 0
      for j,col in ipairs(row) do
        local obj = col.obj
        obj.y = i - 1
        obj.x = x_coord
        obj.colspan = col.colspan or 1
        x_coord = x_coord + obj.colspan
        
        table.insert(item_widgets, obj)
      end
    end
    
    self:DoLayout(item_widgets)
  end
end