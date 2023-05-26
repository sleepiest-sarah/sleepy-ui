SleepyTabbedContainerMixin = CreateFromMixins(SleepyContainerMixin)

local function initialize(self)
  local tab_container = Mixin(CreateFrame("Frame", nil, self), SleepyLayoutMixin)
  tab_container:SetWidth(self:GetWidth())
  tab_container:SetHeight(20)
  tab_container:SetPoint(self._tabRelativePoint or "TOPLEFT", self, self._tabAnchor or "BOTTOMLEFT")
  tab_container:Show()
  
  self._tabContainer = tab_container
  
  self._tabFrameMap = {}
  self._tabs = {}
  

  self._initialized = true
end

local function acquireTab(self)
  if (not self.tabPool) then
    self._tabPool = CreateFramePool("Button", self._tabContainer, self._tabTemplate or "UIPanelButtonTemplate")
  end
  
  return self._tabPool:Acquire()
end

function SleepyTabbedContainerMixin:Tab_OnClick(tab)
  if (self._activeTab) then
    self._activeTab:UnlockHighlight()
    self._activeFrame:Hide()
  end
  
  self._activeTab = tab
  self._activeTab:LockHighlight()
  self._activeFrame = self._tabFrameMap[tab.name]
  self._activeFrame:Show()
end

function SleepyTabbedContainerMixin:SelectTab(tab_name)
  for _,tab in ipairs(self._tabs) do
    if (tab.name == tab_name) then
      self:Tab_OnClick(tab)
      break
    end
  end
end

function SleepyTabbedContainerMixin:AddTab(name, frame)
  if (not self._initialized) then
    initialize(self)
  end
  
  frame:SetParent(self)
  frame:Hide()
  frame:SetPoint("TOPLEFT", self)
  frame:SetPoint("BOTTOMRIGHT", self)
  
  local tab = acquireTab(self)
  tab.name = name
  tab:SetText(name)
  tab:SetScript("OnClick", function (tab) self:Tab_OnClick(tab) end)
  tab:SetWidth(100)
  tab:Show()
  
  self._tabFrameMap[name] = frame
  table.insert(self._tabs, tab)
  
  self._tabContainer:DoLayout(self._tabs, SleepyLayout.HorizontalList)
end

function SleepyTabbedContainerMixin:SetTabTemplate(template)
  self._tabTemplate = template
end

function SleepyTabbedContainerMixin:SetTabAnchor(anchor, relativePoint)
  self._tabAnchor = anchor
  self._tabRelativePoint = relativePoint
end