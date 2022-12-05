function SleepyLayout.Tree(content, children)
  content.rowPadding = content.rowPadding or 0

  local width = content:GetWidth() or 0
  local content_height = 0
  
  for i = 1, #children do
    local child = children[i]
    
    child:ClearAllPoints()
    if i == 1 then
      child:SetPoint("TOPLEFT", content, "TOPLEFT", content.leftPadding, -content.topPadding)
      if (content.rightPadding > 0) then
        child:SetPoint("TOPRIGHT", content, "TOPRIGHT", -content.rightPadding, -content.topPadding)
      end
    else
      local elder_sibling = children[i-1]
      local ident = child.depth * content.ident
      if (elder_sibling:IsShown()) then
        child:SetPoint("TOP", children[i-1], "BOTTOM", 0, -content.rowPadding)
        child:SetPoint("LEFT", content, "LEFT", ident, -content.rowPadding)
        if (content.rightPadding > 0) then
          child:SetPoint("RIGHT", content, "RIGHT", ident, -content.rowPadding)
        end
      else
        child:SetPoint("TOP", children[i-1], "TOP", 0, 0)
        child:SetPoint("LEFT", content, "LEFT", ident, -content.rowPadding)
        if (content.rightPadding > 0) then
          child:SetPoint("RIGHT", content, "RIGHT", ident, -content.rowPadding)
        end
      end
    end
    
    if (child:IsShown()) then
      content_height = content_height + child:GetHeight()
    end
    
  end

  local height = content_height + content.bottomPadding + content.topPadding
  content:SetHeight(height)
  
  if (content.OnLayoutFinished) then
    content:OnLayoutFinished(height)
  end
end