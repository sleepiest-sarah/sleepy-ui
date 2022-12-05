SleepyTreeMixin = CreateFromMixins(SleepyCustomizableItemMixin)

local function buildChildList(items, depth)
  local res = {}
  depth = depth or 0
  
  for k,v in pairs(items) do
    if (type(v) == "table") then
      local subitems = buildChildList(v, depth+1)
      for i,j in pairs(subitems) do
        table.insert(res, j)
      end
      
    else
      table.insert(res, {text=v,depth=depth})
    end
  end
  
  return res
end

function SleepyTreeMixin:RefreshTree()
  if (not self.children or #self.children == 0) then
    return
  end  
  
  for i, child in ipairs(self.children) do
    if (child.header) then
      self:OnAcquire(child)
      
      local j = i + 1
      local item = self.children[j]
      while (item and item.depth > child.depth) do
        if (child.expanded) then
          item:Show()
        else
          item:Hide()
        end
        j = j + 1
        item = self.children[j]
      end
        
    end
  end  
  
  self:DoLayout(self.children)
end

function SleepyTreeMixin:SetTreeItems(items)
  if (not self.pool) then
    self.pool = CreateFontStringPool(self, "BACKGROUND", nil, self.font)
    self.header_pool = CreateFramePool("BUTTON", self, "SleepyExpandableHeaderTemplate")
  end
  
  self.children = {}
  
  self.pool:ReleaseAll()
  
  local flattened_items = buildChildList(items)

  for i,v in ipairs(flattened_items) do
    local item
    if (flattened_items[i+1] and flattened_items[i+1].depth > v.depth) then
      item = self.header_pool:Acquire()
      item.header = true
      item.expanded = false
    else
      item = self.pool:Acquire()
    end

    item:SetText(v.text)
    item.depth = v.depth
    
    self:OnAcquire(item)
    
    item:Show()
    table.insert(self.children, item)
  end
  
  self:RefreshTree()
end

function SleepyTreeMixin:Header_OnClick(button)
  button.expanded = not button.expanded
  self:RefreshTree()
end