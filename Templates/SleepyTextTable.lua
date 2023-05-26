SleepyTextTableMixin = CreateFromMixins(SleepyTableMixin,SleepyCustomizableItemMixin)

SleepyTextTableMixin.font = "GameFontNormal"    

local function fontStringResetter(pool, fs)
  fs:SetText(nil)
  fs.y = nil
  fs.x = nil
  fs.colspan = nil
  fs:SetWordWrap(false)
  fs:SetJustifyH("CENTER")
  FramePool_HideAndClearAnchors(pool, fs)
end

--[[
  items = {
    {{text = "row 1", colspan=2, font = "GameFontNormal"}},
    {{text = "row 2a"}, {text = "row 2b"}}
  }
--]]
function SleepyTextTableMixin:SetTextTableItems(table_def)
  if (not self._fs_pool) then
    self._fs_pool = CreateFontStringPool(self, "BACKGROUND", nil, self.font, fontStringResetter)
  end
  self._fs_pool:ReleaseAll()
  
  if (table_def and #table_def > 0) then
    local item_widgets = {}
    for i,row in ipairs(table_def) do
      local x_coord = 0
      for j,col in ipairs(row) do
        local fc = self._fs_pool:Acquire()
        
        --TODO clean up the resetters and use a pool collection instead of polluting the pool
        fc:SetFontObject(self.font)
        fc:SetText(col.text)
        self:SetFontStringOptions(fc, col)
        
        self:OnAcquire(fc)
        col.obj = fc
      end
    end
    
    self:SetTableItems(table_def)
  end
end