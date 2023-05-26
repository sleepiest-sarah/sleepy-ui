SleepyListMixin = CreateFromMixins(SleepyContainerMixin)

SleepyListMixin.layout = "List"

function SleepyListMixin:SetListItems(items)
  if (items) then
    local item_widgets = {}
    for i,item in ipairs(items) do
      item:SetWidth(self:GetWidth())
      item.index = i
      item:SetParent(self)
      item:Show()
      
      table.insert(item_widgets, item)
    end
    
    self:DoLayout(item_widgets)
  end
end