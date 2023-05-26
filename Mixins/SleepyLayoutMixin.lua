SleepyLayoutMixin = {}

SleepyLayoutMixin.topPadding = 0
SleepyLayoutMixin.bottomPadding = 0
SleepyLayoutMixin.leftPadding = 0
SleepyLayoutMixin.rightPadding = 0

function SleepyLayoutMixin:SetLayout(layout)
  self.layout = layout
end

function SleepyLayoutMixin:DoLayout(children, layoutFunc)
  if (self.layout) then
    layoutFunc = SleepyLayout[self.layout]
  end
  
  layoutFunc(self, children)
end

--will only work if children are laid out vertically with no overlapping
function SleepyLayoutMixin:ResizeToFitChildren()
  local height = 0
  for _,child in ipairs({self:GetChildren()}) do
    height = height + child:GetHeight()
  end
  self:SetHeight(height)
end

