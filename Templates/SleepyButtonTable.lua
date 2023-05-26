SleepyButtonTableMixin = CreateFromMixins(SleepyTableMixin)

SleepyButtonTableMixin.template = "UIPanelButtonTemplate"    

--[[
  items = {
    {{text = "row 1", key = 1, colspan=2, font = "GameFontNormal"}},
    {{text = "row 2a"}, {text = "row 2b"}}
  }
--]]
function SleepyButtonTableMixin:SetButtonTableItems(table_def, cb)
  if (not self._button_pool) then
    self._button_pool = CreateFramePool("BUTTON", self, self.template)
  end
  self._button_pool:ReleaseAll()
  
  if (table_def and #table_def > 0) then
    local item_widgets = {}
    for i,row in ipairs(table_def) do
      local x_coord = 0
      for j,col in ipairs(row) do
        local button = self._button_pool:Acquire()
        button:SetText(col.text)
        button.key = col.key or col.text
        button:SetScript("OnClick",cb)
        col.obj = button
      end
    end
    
    self:SetTableItems(table_def)
  end
end