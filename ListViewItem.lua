------------------------------------------------------
-- listView元素
-- listViewItem.lua
-- created by haibo 2015/07/02
-- sean.ma@juhuiwan.cn
-- Copyright (c) 2014-2015 TengChong Co.,Ltd.
------------------------------------------------------

local UIScrollView = import(".ScrollView")

local UIListViewItem = class("UIListViewItem", function()
	return cc.Node:create()
end)

UIListViewItem.BG_TAG = 1
UIListViewItem.BG_Z_ORDER = 1
UIListViewItem.CONTENT_TAG = 11
UIListViewItem.CONTENT_Z_ORDER = 11
UIListViewItem.ID_COUNTER = 0

function UIListViewItem:ctor(item)
	local itemSize=item:getContentSize()
	self.width = itemSize.width
	self.height = itemSize.height
	self.margin_ = {left = 0, right = 0, top = 0, bottom = 0}
	UIListViewItem.ID_COUNTER = UIListViewItem.ID_COUNTER + 1
	self.id = UIListViewItem.ID_COUNTER
	self:setTag(self.id)
	self:addContent(item)
end

function UIListViewItem:getItemName( ... )
	return "UIListViewItem"
end

function UIListViewItem:addContent(content)
	print("UIListViewItem:addContent")
	if not content then
		return
	end

	self:addChild(content, UIListViewItem.CONTENT_Z_ORDER, UIListViewItem.CONTENT_TAG)
end

function UIListViewItem:getContent()
	return self:getChildByTag(UIListViewItem.CONTENT_TAG)
end

function UIListViewItem:setItemSize(w, h, bNoMargin)
	if not bNoMargin then
		if UIScrollView.DIRECTION_VERTICAL == self.lvDirection_ then
			h = h + self.margin_.top + self.margin_.bottom
		else
			w = w + self.margin_.left + self.margin_.right
		end
	end

	-- print("UIListViewItem - setItemSize w:" .. w .. " h:" .. h)

	local oldSize = {width = self.width, height = self.height}
	local newSize = {width = w, height = h}

	self.width = w or 0
	self.height = h or 0
	self:setContentSize(cc.size(w, h))

	local bg = self:getChildByTag(UIListViewItem.BG_TAG)
	if bg then
		bg:setContentSize(cc.size(w, h))
		bg:setPosition(cc.p(w/2, h/2))
	end

	self.listener(self, newSize, oldSize)
end

function UIListViewItem:getItemSize()
	return self.width, self.height
end

function UIListViewItem:setMargin(margin)
	self.margin_ = margin

	-- dump(self.margin_, "set margin:")
end

function UIListViewItem:getMargin()
	return self.margin_
end

function UIListViewItem:onSizeChange(listener)
	self.listener = listener

	return self
end

-- just for listview invoke
function UIListViewItem:setDirction(dir)
	self.lvDirection_ = dir
end

return UIListViewItem
