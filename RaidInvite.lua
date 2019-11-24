RaidInvite = LibStub("AceAddon-3.0"):NewAddon("RaidInvite", "AceConsole-3.0", "AceEvent-3.0")
local AceGUI = LibStub("AceGUI-3.0")
RaidInviteIcon = LibStub("LibDBIcon-1.0")


local textStore = ''
local registeredEvents = {}
local nameList

local RaidInviteLDB = LibStub("LibDataBroker-1.1"):NewDataObject("RaidInvite", {
type = "data source",
text = "RaidInvite",
icon = "Interface\\Addons\\RaidInvite\\RaidInviteIconON",
OnClick = function() RaidInvite:ToggleWindow() end,
})


function RaidInvite:ToggleWindow()
	if frame:IsShown() then
		frame:Hide()
		RaidInviteLDB.icon = "Interface\\Addons\\RaidInvite\\RaidInviteIconOFF"
		-- RaidInviteIcon:Refresh()
	else
		frame:Show()
		RaidInviteLDB.icon = "Interface\\Addons\\RaidInvite\\RaidInviteIconON"
		
	end
end


function RaidInvite:OnInitialize()
	RaidInvite:Print(ChatFrame4, "Hello, world!")
	-- PARTY_MEMBERS_CHANGED
	-- RaidInvite:RegisterEvent("GROUP_ROSTER_UPDATE", "partyEvent", event)
	RaidInvite.db = LibStub("AceDB-3.0"):New("RaidInviteDB", { profile = { minimap = { hide = false, }, }, }) 
	RaidInviteIcon:Register("RaidInvite", RaidInviteLDB, RaidInvite.db.profile.minimap) 
end


function RaidInvite:OnEnable()
    -- Called when the addon is enabled
end

function RaidInvite:OnDisable()
    -- Called when the addon is disabled
end


function RaidInvite:InviteNames(name)
	-- function to itterate through names
	RaidInvite:Print(ChatFrame4, "Inviting: " .. name)
	InviteUnit(name);	
end 


function RaidInvite:partyEvent(event)
	-- function to itterate through names
	RaidInvite:Print(ChatFrame4, event)
end 




frame = AceGUI:Create("Frame")
frame:SetTitle("Raid Invite")
frame:SetStatusText("Super Duper Beta of RaidInvite")
-- frame:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)
frame:SetLayout("Flow")
-- frame:RegisterAsContainer(widget)


local invitebox = AceGUI:Create("MultiLineEditBox")
invitebox:SetLabel("Insert text:")
invitebox:SetRelativeWidth(.45)
invitebox:SetHeight(400)
invitebox:SetCallback("OnEnterPressed", function(widget, event, text) textStore = text end)
frame:AddChild(invitebox)

local padding = AceGUI:Create("Label")
padding:SetText("")
padding:SetHeight(400)
padding:SetRelativeWidth(.1)
frame:AddChild(padding)

local failedbox = AceGUI:Create("MultiLineEditBox")
failedbox:SetLabel("Failed Invites:")
failedbox:SetRelativeWidth(.45)
failedbox:SetHeight(400)
frame:AddChild(failedbox)


local button = AceGUI:Create("Button")
button:SetText("Click Me!")
button:SetRelativeWidth(1)
button:SetCallback("OnClick", function() for name in textStore:gmatch("[^\r\n]+") do RaidInvite:InviteNames(name) end end)
frame:AddChild(button)




