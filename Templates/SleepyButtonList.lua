SleepyButtonListMixin = CreateFromMixins(SleepyListMixin,SleepyCustomizableItemMixin)

function SleepyButtonListMixin:SetButtonListItems(items, cb)
  if (not self._buttonPool) then
    self._buttonPool = CreateFramePool("Button", self, self._itemTemplate)
  end
  
  self._buttonPool:ReleaseAll()
  
  local children = {}
  for _,item in ipairs(items) do
    local button = self._buttonPool:Acquire()
    button:SetText(item)
    button.key = item
    button:SetScript("OnClick",cb)
    table.insert(children, button)
  end

  self:SetListItems(children)
end