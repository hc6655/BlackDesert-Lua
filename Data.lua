registerEvent("Event_ManufactureResultList", "Global_ManuRespose")
registerEvent("FromClient_AlchemyFailAck", "Global_AlchemyResponse")
registerEvent("addDamage", "Global_AddDamageProcess")
registerEvent("EventChattingMessageUpdate", "G_EventChattingMessageUpdate")

function G_EventChattingMessageUpdate(isShow, currentPanelIndex)
	--table.insert(item, {itemWhereType = 1, itemName = name})
	local msg
	local totalSize = getNewChatMessageCount()
	local msgList = {}
	for index = 0, totalSize - 1 do
		msg = getNewChatMessage(index)
		if nil ~= msg and CppEnums.ChatType.System ~= msg.chatType then
			local chatType = msg.chatType
			local isGameManager = msg.isGameManager
			local sender = msg:getSender(1)
			local message = msg:getContent()
			local isMe = msg.isMe
			table.insert(msgList, {["sender"] = sender, ["chatType"] = chatType, ["isGameManager"] = isGameManager, ["message"] = message, ["isMe"] = isMe})
		end
	end
	
	if 0 ~= table_leng(msgList) then
		local js = JSON:encode(msgList)
		SendMessagePkg(js)
	end
end

function Global_AddDamageProcess(attakeeKeyRaw, effectNumber, effectType, additionalDamageType, posFloat3, isTribeAttack, attackerActorKeyRaw)
	local attackerActorWrapper = getCharacterActor(attackerActorKeyRaw)
	if nil ~= attackerActorWrapper then
		if false == attackerActorWrapper:get():isSelfPlayer() and attackerActorWrapper:get():isPlayer() then
			SetAttacked()
		end
	end
end

function OpenFarm(isShow, isMyHouse)
	Proc_ShowMessage_Ack("IsSelfPlayerWaitAction")
	if not IsSelfPlayerWaitAction() and not IsSelfPlayerBattleWaitAction() then
		--Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_ONLYWAITSTENCE"))
		return
	end
	Proc_ShowMessage_Ack("housing_getHouseholdActor_CurrentPosition")
	local houseWrapper = housing_getHouseholdActor_CurrentPosition()
	if nil == houseWrapper then
		--Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_GOTO_NEAR_HOUSEHOLD"))
		return
	end
	Proc_ShowMessage_Ack("houseInstallationMode")
	local houseInstallationMode = houseWrapper:getStaticStatusWrapper():getObjectStaticStatus():isFixedHouse() or houseWrapper:getStaticStatusWrapper():getObjectStaticStatus():isInnRoom()
	if true == houseInstallationMode then
		audioPostEvent_SystemUi(1, 32)
		_AudioPostEvent_SystemUiForXBOX(1, 32)
	else
		audioPostEvent_SystemUi(1, 32)
		_AudioPostEvent_SystemUiForXBOX(1, 32)
	end
	Proc_ShowMessage_Ack("_isShow")
	if isShow == false then
		Proc_ShowMessage_Ack("_isShow == false")
		Proc_ShowMessage_Ack("housing_changeHousingMode")
		local rv = housing_changeHousingMode(true, isMyHouse)
		Proc_ShowMessage_Ack("_ContentsGroup_NewUI_InstallMode_All")
		if true == _ContentsGroup_NewUI_InstallMode_All then
			Proc_ShowMessage_Ack("PaGlobal_House_Installation_All_Open")
			PaGlobal_House_Installation_All_Open()
		elseif false == _ContentsGroup_RenewUI_Housing then
			Proc_ShowMessage_Ack("FGlobal_House_InstallationMode_Open")
			FGlobal_House_InstallationMode_Open()
		else
			Proc_ShowMessage_Ack("PaGlobalFunc_InstallationMode_Manager_Show")
			PaGlobalFunc_InstallationMode_Manager_Show()
		end
	else
		Proc_ShowMessage_Ack("_isShow == true")
		Proc_ShowMessage_Ack("housing_changeHousingMode")
		housing_changeHousingMode(false, isMyHouse)
		Proc_ShowMessage_Ack("_ContentsGroup_NewUI_InstallMode_All")
		if true == _ContentsGroup_NewUI_InstallMode_All then
			Proc_ShowMessage_Ack("PaGlobal_House_Installation_All_Close")
			PaGlobal_House_Installation_All_Close()
		elseif false == _ContentsGroup_RenewUI_Housing then
			Proc_ShowMessage_Ack("FGlobal_House_InstallationMode_Close")
			FGlobal_House_InstallationMode_Close()
		else
			Proc_ShowMessage_Ack("PaGlobalFunc_InstallationMode_Manager_Exit")
			PaGlobalFunc_InstallationMode_Manager_Exit()
		end
	end
	Proc_ShowMessage_Ack("_ContentsGroup_NewUI_InstallMode_All")
	if false == _ContentsGroup_NewUI_InstallMode_All and false == _ContentsGroup_RenewUI_Housing then
		if false == houseInstallationMode then
			FGlobal_FarmGuide_Open()
		else
			FGlobal_FarmGuide_Close()
		end
	end
end

function Test()
	--PaGlobal_House_Installation_All_Close()
	Interaction_ButtonPushed(CppEnums.InteractionType.InteractionType_SeedHavest)
	--housing._isMyHouse = true
	--Panel_Housing_Mode_Click()
	--housing_changeHousingMode(true, true)
	--PaGlobal_House_Installation_All_Open()
	--FGlobal_FarmGuide_Open()
	--OpenFarm(false, true)
	--PaGlobal_InstallationModeWar_All_Open()
	--PaGlobal_House_Installation_All_Open()
	--local data = ToClient_GetFurniture(0)
	--if nil ~= data then
		--Proc_ShowMessage_Ack("not null")
		--HandleEventOn_House_InstallationList_All_NormalItemTooltip(data._invenType, data._invenSlotNo, 0)
		--HandleEventLUp_House_InstallationList_All_InstallFurniture(data._invenType, data._invenSlotNo, false, 0)
		--housing_selectInstallationItem(data._invenType, data._invenSlotNo)
		--PaGlobal_House_InstallationMode_ObjectControl_All_Confirm()
		--PaGlobal_House_InstallationMode_ObjectControl_All_Open(installMode, posX, posY, isShow, isShowMove, isShowFix, isShowDelete, isShowCancel)
		--housing_selectInstallationItem(data._invenType, data._invenSlotNo)
		--HandleEventLUp_House_InstallationList_All_InstallFurniture(data._invenType, data._invenSlotNo, false, 0)
		--PaGlobal_House_Installation_All._value.isCanMove = false
		--PaGlobal_House_Installation_All._value.isCanDelete = false
		--PaGlobal_House_Installation_All._value.isCanCancel = true
		--PaGlobal_House_InstallationMode_ObjectControl_All_Open(3, 955, 451, true, false, true, false, true)
		--PaGlobal_House_InstallationMode_ObjectControl_All_Confirm()
		--if true == PaGlobal_House_InstallationList_All_GetShowPanel() then
			--PaGlobal_House_InstallationList_All_UpdateCart()
		--end
		--housing:ShowInstallationMenu(true, 1152, 619, true, false, true, false, true)
		--local sizeX = PaGlobal_House_Installation_All._screenGapSize.x
		--local sizeY = PaGlobal_House_Installation_All._screenGapSize.y
		--Proc_ShowMessage_Ack("Size: x: " .. tostring(sizeX) .. ", y: ".. tostring(sizeY))
		--local size = GetFarmSize()
		--Proc_ShowMessage_Ack("Size: x: " .. tostring(size.x) .. ", y: ".. tostring(size.y))
	--else
		--Proc_ShowMessage_Ack("is null")
	--end
	
	--Panel_HarvestList_ShowAni()
	--Panel_HarvestList_Update()
end

function GetFarmSize()
	local size = {x = 0, y = 0}
	local houseWrapper = housing_getHouseholdActor_CurrentPosition()
	if nil == houseWrapper then
		Proc_ShowMessage_Ack("houseWrapper is null")
		return size
	end
	local houseSSW = houseWrapper:getStaticStatusWrapper()
	if nil == houseSSW then
		Proc_ShowMessage_Ack("houseSSW is null")
		return size
	end
	local actorKeyRaw = houseWrapper:getActorKey()
	local buildingInfo = ToClient_getBuildingInfo(actorKeyRaw)
	if nil == buildingInfo then
		Proc_ShowMessage_Ack("buildingInfo is null")
		return size
	end
	local posX = buildingInfo:GetPosX() + 50
	local posY = buildingInfo:GetPosY() + 50
	local sizeX = Panel_House_InstallationMode_WarInfomation_All:GetSizeX()
	local sizeY = Panel_House_InstallationMode_WarInfomation_All:GetSizeY()
	Proc_ShowMessage_Ack("Size: x: " .. tostring(sizeX) .. ", y: ".. tostring(sizeY))
	size.x = sizeX
	size.y = sizeY
	
	return size
end

--[[function WorkerRecovery()
	if 0 >= ToClient_getNpcRecoveryItemList()
		return
	end
	local recoveryItem = ToClient_getNpcRecoveryItemByIndex(0)
	local recoveryItemCount = Int64toInt32(recoveryItem._itemCount_s64)
	local restorePoint = recoveryItem._contentsEventParam1
	local slotNo = recoveryItem._slotNo
	local currentItemCount = recoveryItemCount
	for idx = 1, workerCount do
		local workerNoRaw = self._workerArray[idx]--
		if nil == workerNoRaw then
			return
		end
		local workerWrapperLua = getWorkerWrapper(workerNoRaw, false)
		local maxPoint = workerWrapperLua:getMaxActionPoint()
		local currentPoint = workerWrapperLua:getActionPoint()
		local restoreActionPoint = maxPoint - currentPoint
		local itemNeedCount = math.floor(restoreActionPoint / restorePoint)
		if currentItemCount < itemNeedCount then
			itemNeedCount = currentItemCount
		end
		if itemNeedCount >= 1 then
			requestRecoveryWorker(WorkerNo(workerNoRaw), slotNo, itemNeedCount)
			currentItemCount = currentItemCount - itemNeedCount
		end
	end
end--]]

function table_leng(t)
  local leng=0
  for k, v in pairs(t) do
    leng=leng+1
  end
  return leng;
end

function ChattingSendMessage(target, message, chatType, chatNameType)
	if nil == target or nil == message then
		return
	end
	
	ToClient_setChatNameType(chatNameType)
	chatting_sendMessage(target, message, chatType)
	chatting_saveMessageHistory(target, message)
end

function GetClassTypeCheckEquipType(classType, equipType)
  local isAwakenWeaponContentsOpen = PaGlobal_AwakenSkill.awakenWeapon[classType]
  if 13 == equipType or 9 == equipType or 11 == equipType or 12 == equipType or isAwakenWeaponContentsOpen and 57 == equipType then
    return classType
  end
  if __eClassType_Warrior == classType or __eClassType_Valkyrie == classType then
    if 1 == equipType or 8 == equipType then
      return classType
    end
  elseif __eClassType_Giant == classType then
    if 29 == equipType or 34 == equipType then
      return classType
    end
  elseif __eClassType_ElfRanger == classType or __eClassType_RangerMan == classType then
    if 31 == equipType or 32 == equipType or 73 == equipType or 74 == equipType then
      return classType
    end
  elseif __eClassType_Sorcerer == classType then
    if 28 == equipType or 33 == equipType then
      return classType
    end
  elseif __eClassType_Tamer == classType then
    if 2 == equipType or 37 == equipType then
      return classType
    end
  elseif __eClassType_Kunoichi == classType or __eClassType_NinjaMan == classType then
    if 2 == equipType or 56 == equipType or 55 == equipType then
      return classType
    end
  elseif __eClassType_BladeMaster == classType or __eClassType_BladeMasterWoman == classType then
    if 3 == equipType or 36 == equipType then
      return classType
    end
  elseif __eClassType_WizardMan == classType or __eClassType_WizardWoman == classType then
    if 6 == equipType or 32 == equipType then
      return classType
    end
  elseif __eClassType_DarkElf == classType then
    if 63 == equipType or 34 == equipType then
      return classType
    end
  elseif __eClassType_Combattant == classType or __eClassType_Mystic == classType then
    if 65 == equipType or 66 == equipType then
      return classType
    end
  elseif __eClassType_Lhan == classType then
    if 67 == equipType or 70 == equipType then
      return classType
    end
  elseif __eClassType_ShyWaman == classType then
    if 78 == equipType or 79 == equipType then
      return classType
    end
  elseif __eClassType_Guardian == classType and (83 == equipType or 8 == equipType) then
    return classType
  end
  return __eClassType_Count
end

function CheckMainHand()
	local RightHand = ToClient_getEquipmentItem(CppEnums.EquipSlotNo.rightHand)
	local classType = getSelfPlayer():getClassType()
	if nil ~= RightHand then
		local Type = RightHand:getStaticStatus():getEquipType()
		if classType == GetClassTypeCheckEquipType(classType, Type) then
			return
		end
	else
		return
	end
	
	local inventory = getSelfPlayer():get():getInventoryByType(CppEnums.ItemWhereType.eInventory)
	local invenSize = inventory:size()
	local useStartSlot = inventorySlotNoUserStart()

	for i = useStartSlot, invenSize do
		local itemSWW = getInventoryItem(i)
		if nil ~= itemSWW then
			local isEquip = itemSWW:getStaticStatus():isEquipable()
			local equipSlot = itemSWW:getStaticStatus():getEquipSlotNo()
			if CppEnums.EquipSlotNo.rightHand == equipSlot and isEquip then
				local equipType = itemSWW:getStaticStatus():getEquipType()
				local endurance = itemSWW:get():getEndurance()
				if classType == GetClassTypeCheckEquipType(classType, equipType) and 0 < endurance then
					inventoryUseItem(CppEnums.ItemWhereType.eInventory, i, 0, true)
					return
				end
			end
		end
	end
	
	HandleEventRUp_Equipment_All_EquipSlotRClick(CppEnums.EquipSlotNo.rightHand)
	
	--AddReturn("false")
end

function CheckEquipEndurance()
	for i = 0, 12 do
		local itemWrapper = ToClient_getEquipmentItem(i)
		if itemWrapper ~= nil then
			local endurance = itemWrapper:get():getEndurance()
			if 0 >= endurance then
				return
			end
		end
	end
	
	local itemWrapper = ToClient_getEquipmentItem(CppEnums.EquipSlotNoClient.eEquipSlotNoAwakenWeapon)
	if itemWrapper ~= nil then
		local endurance = itemWrapper:get():getEndurance()
		if 0 >= endurance then
			return
		end
	end
	
	AddReturn("true")
end

function ChangeChannel(channelNo)
	if 0 <= channelNo and 30 >= channelNo then
		local worldServerData = getGameWorldServerDataByIndex(0)
		if nil ~= worldServerData then
			local changeChannelTime = getChannelMoveableRemainTime(worldServerData._worldNo)
			if toInt64(0, 0) >= changeChannelTime then
				local serverData = getGameChannelServerDataByIndex(0, channelNo)
				local currentChannel = getCurrentChannelServerData()
				if nil ~= serverData then
					local channelName = getChannelName(worldServerData._worldNo, serverData._serverNo)
					if "阿勒沙" == channelName or "血之祭壇" == channelName or string.find(channelName, "奧爾比亞") or string.find(channelName, "夏季伺服器") or string.find(channelName, "阿勒沙") or currentChannel._serverNo == serverData._serverNo then
						while 1 do
							if 30 <= channelNo then
								channelNo = 0
							else
								channelNo = channelNo + 1
							end
							local tmpData = getGameChannelServerDataByIndex(0, channelNo)
							local channelName = getChannelName(worldServerData._worldNo, tmpData._serverNo)
							if "阿勒沙" ~= channelName and "血之祭壇" ~= channelName and nil == string.find(channelName, "奧爾比亞") and nil == string.find(channelName, "夏季伺服器") and nil == string.find(channelName, "阿勒沙") and currentChannel._serverNo ~= tmpData._serverNo then
								break
							end
						end
					end
					PaGlobal_GameExit_ALL_SaveCurrentData()
					gameExit_MoveChannel(channelNo)
					return true
				end
			end
		end
	end
	
	AddReturn("false")
	return false
end

function CheckRepairMoney()
	local invenMoney = getSelfPlayer():get():getInventory():getMoney_s64()
	local warehouseMoney = warehouse_moneyFromNpcShop_s64()
	if invenMoney > warehouseMoney then
		PaGlobal_RepairFunc_All._otherPanel._uiRepairInvenMoney:SetCheck(true)
		PaGlobal_RepairFunc_All._otherPanel._uiRepairWareHouseMoney:SetCheck(false)
	else
		PaGlobal_RepairFunc_All._otherPanel._uiRepairInvenMoney:SetCheck(false)
		PaGlobal_RepairFunc_All._otherPanel._uiRepairWareHouseMoney:SetCheck(true)
	end
end

function IsNpcDialogShow()
	if false == Panel_Npc_Dialog_All:IsShow() then
		AddReturn("false")
		return false
	end
	
	return true
end

function CheckCollectTool(itemName)
	if nil == itemName or 0 == string.len(itemName) then
		return
	end
	local itemWrapper = ToClient_getEquipmentItem(CppEnums.EquipSlotNoClient.eEquipSlotNoSubTool)
    if itemWrapper ~= nil then
		local name = itemWrapper:getStaticStatus():getName()
		local endurance = itemWrapper:get():getEndurance()
		if itemName == name and 0 < endurance then
			return
		end
    end

	local inventory = getSelfPlayer():get():getInventoryByType(CppEnums.ItemWhereType.eInventory)
	local invenSize = inventory:size()
	local useStartSlot = inventorySlotNoUserStart()

	for i = useStartSlot, invenSize do
		local _itemSWW = getInventoryItem(i)
		if nil ~= _itemSWW then
			local name = _itemSWW:getStaticStatus():getName()
			local endurance = _itemSWW:get():getEndurance()
			if name == itemName and 0 < endurance then
				inventoryUseItem(CppEnums.ItemWhereType.eInventory, i, 0, true)
				return
			end
		end
	end
	
	AddReturn("noEquip")
	
end

function StartRandomBox()
	PaGlobal_RandomBoxSelect_All:checkSelectMode()
	PaGlobal_RandomBoxSelect_All:close(PaGlobal_RandomBoxSelect_All._ePanelType._modeSelect)
	InventoryWindow_Close()
	RandomBoxPanelOpen()
end

function AlchemyResponse(isSuccess, hint, alchemyType, str, bDoingMassProduction)
	if isSuccess then
		SetAlchemySuccess()
	else
		SetAlchemyRes(hint)
	end
	--[[
	hint:0 == 太重了
	hint:1 == 此組合好像無法獲得任何東西
	hint:4 == 設備工具的耐久度不足
	--]]
end

function Global_AlchemyResponse(isSuccess, hint, alchemyType, str, bDoingMassProduction)
	return AlchemyResponse(isSuccess, hint, alchemyType, str, bDoingMassProduction)
end

function Global_AlchemyStart(countProduction)
	if ToClient_AlchemyGetCountSlotWithMaterial() <= 0 then
		return false
	end
	ToClient_AlchemyStart(PaGlobal_Alchemy_All._isCook, countProduction)
	local progressBarTimeSec = ToClient_AlchemyGetAlchemyTime(PaGlobal_Alchemy_All._isCook) / 1000
	if 0 == progressBarTimeSec then
		return false
	end
	EventProgressBarShow(true, progressBarTimeSec, true == PaGlobal_Alchemy_All._isCook and 7 or 9)
	audioPostEvent_SystemUi(1, 0)
	_AudioPostEvent_SystemUiForXBOX(1, 0)
	PaGlobalFunc_Alchemy_All_Close()
	
	return true
end

function StartAlchemy(isMass)
	if false == Panel_Window_Alchemy_All:GetShow() then
		AddReturn("請打開料理/煉金台")
		return false
	end
	
	local slotcount = ToClient_AlchemyGetCountSlotWithMaterial()
	if 0 >= slotcount then
		AddReturn("沒有料理/煉金道具")
		return false
	end
	local maxMass = ToClient_AlchemyGetMaxMassProductionCount()
	if isMass then
		if false == Global_AlchemyStart(maxMass) then
			AddReturn("false")
			return false
		end
	else
		if false == Global_AlchemyStart(1) then
			AddReturn("false")
			return false
		end
	end
	
	return true
end

function AlchemyPush(name, count)
	if false == Panel_Window_Alchemy_All:GetShow() then
		AddReturn("請打開料理/煉金台")
		return false
	end
	
	local slot = GetInventorySlotByName(name)
	local iCount = GetInventoryItemCount(name)
	
	if -1 == slot or 0 == iCount or count > Int64toInt32(iCount) then
		AddReturn("找不到道具")
		return false
	end
	
	PaGlobal_Alchemy_All:pushItemFromInventory(count, slot)
	
	return true
	
end

function GetStaticActorName(CharacterKey)
	if 0 == CharacterKey then
		return
	end
	local actor = ToClient_GetCharacterStaticStatusWrapper(CharacterKey)
	if nil == actor then
		return
	end
	local name = actor:getName()
	AddReturn(name)
end

function Global_ManuRespose(itemDynamicListWrapper, failReason)
	return Manufacture_ResponseResultItem(itemDynamicListWrapper, failReason)
end

function Manufacture_ResponseResultItem(itemDynamicListWrapper, failReason)
	local size = itemDynamicListWrapper:getSize()
	if size <= 0 then
		SetManuRes(failReason)
	else
		SetManuSuccess()
	end
	--Proc_ShowMessage_Ack("加工結果:" .. tostring(failReason))
	--[[local size = itemDynamicListWrapper:getSize()
	if size <= 0 then
		Proc_ShowMessage_Ack("加工結果:" .. tostring(failReason))
	else
		Proc_ShowMessage_Ack("加工已完成")
	end--]]
	
end

function StartManufacture(ActionName, IsMassManufacture)
	if true == IsMassManufacture or 1 <= IsMassManufacture and nil ~= ActionName then
		local actionIndex = GetManufactureActionIndex(ActionName)
		local isManufactureMassItemEquip = false
		local itemWrapper = ToClient_getEquipmentItem(CppEnums.EquipSlotNoClient.eEquipSlotNoSubTool)
		if nil ~= itemWrapper and -1 ~= actionIndex then
			local itemSSW = itemWrapper:getStaticStatus()
			if __ePlayerLifeStatType_Manufacture == itemSSW:getLifeStatMainType() and actionIndex + 1 == itemSSW:getLifeStatSubType() then
				isManufactureMassItemEquip = true
			end
		end
		if true == isManufactureMassItemEquip then
			HandleEventLUp_Manufacture_All_RepeatAction(true)
		else
			HandleEventLUp_Manufacture_All_RepeatAction(false)
		end
	else
		HandleEventLUp_Manufacture_All_RepeatAction(false)
	end
end

function PushItemToManufacture(ItemName, IsWarehouse)
	if true == IsWarehouse or 1 <= IsWarehouse then
		if false == Panel_Window_Warehouse:GetShow() then
			Proc_ShowMessage_Ack("Ice-->請打開倉庫")
			AddReturn("false")
			return
		end
		local warehouseWrapper = PaGlobal_Warehouse_All_GetWarehouseWarpper()
		local itemCount = warehouseWrapper:getSize()
		for i = 1, itemCount do
			local itemWrapper = PaGlobal_WareHouse_All:getWarehouse():getItem(i)
			if nil ~= itemWrapper then
				local name = itemWrapper:getStaticStatus():getName()
				if name == ItemName then
					PaGlobal_Manufacture_All_PushItemFromWarehouse(i, itemWrapper, itemWrapper:get():getCount_s64())
					return
				end
			end
		end
	else
		local inventory = getSelfPlayer():get():getInventoryByType(CppEnums.ItemWhereType.eInventory)
		local invenSize = inventory:size()
		local useStartSlot = inventorySlotNoUserStart()

		for i = useStartSlot, invenSize do
			local itemSWW = getInventoryItem(i)
			if nil ~= itemSWW then
				local name = itemSWW:getStaticStatus():getName()
				if name == ItemName then
					PaGlobal_Manufacture_All_PushItemFromInventory(i, itemSWW, itemSWW:get():getCount_s64(), CppEnums.ItemWhereType.eInventory)
					return
				end
			end
		end
	end
	
	AddReturn("no item")
end

function ChangeManufactureEqiupment(ActionName)
	if nil == ActionName then
		return false
	end
	
	local actionIndex = GetManufactureActionIndex(ActionName)
	if -1 == actionIndex then
		return false
	end
	
	local itemWrapper = ToClient_getEquipmentItem(CppEnums.EquipSlotNoClient.eEquipSlotNoSubTool)
    if itemWrapper ~= nil then
		local itemSSW = itemWrapper:getStaticStatus()
		if __ePlayerLifeStatType_Manufacture == itemSSW:getLifeStatMainType() and actionIndex + 1 == itemSSW:getLifeStatSubType() then
			return true
		end
    end
	
	local inventory = getSelfPlayer():get():getInventoryByType(CppEnums.ItemWhereType.eInventory)
	local invenSize = inventory:size()
	local useStartSlot = inventorySlotNoUserStart()

	for i = useStartSlot, invenSize do
		local _itemSWW = getInventoryItem(i)
		if nil ~= _itemSWW then
			local LifeStatMain = _itemSWW:getStaticStatus():getLifeStatMainType()
			local LifeStatSub = _itemSWW:getStaticStatus():getLifeStatSubType()
			if __ePlayerLifeStatType_Manufacture == LifeStatMain and actionIndex + 1 == LifeStatSub then
				inventoryUseItem(CppEnums.ItemWhereType.eInventory, i, 0, true)
				return true
			end
		end
	end
	
	return false
end

function GetManufactureActionIndex(ActionName)
	if "混合" == ActionName then
		return 0
	elseif "研磨" == ActionName then
		return 1
	elseif "砍柴" == ActionName then
		return 2
	elseif "曬乾" == ActionName then
		return 3
	elseif "過濾" == ActionName then
		return 4
	elseif "加熱" == ActionName then
		return 5
	elseif "裝雨水" == ActionName then
		return 6
	elseif "修理" == ActionName then
		return 7
	elseif "簡易煉金" == ActionName then
		return 8
	elseif "簡易料理" == ActionName then
		return 9
	elseif "包裝皇室料理" == ActionName then
		return 10
	elseif "包裝皇室煉金" == ActionName then
		return 11
	elseif "工會合作" == ActionName then
		return 12
	elseif "製作" == ActionName then
		return 13
	else
		return -1
	end
end

function SetManufactureAction(ActionName)
	local index = GetManufactureActionIndex(ActionName)
	if -1 == index then
		AddReturn("false")
		return false
	end
	
	PaGlobal_Manufacture_All_SelectManufactureAction(index, true)
end

function OpenManufacture(IsWarehouse)
	if true == IsWarehouse or 1 <= IsWarehouse then
		if false == Panel_Window_Warehouse:GetShow() then
			Proc_ShowMessage_Ack("Ice-->請打開倉庫")
			AddReturn("false")
			return
		end
		HandleEventLUp_Warehouse_All_ManufactureOpen()
	else
		PaGlobalFunc_Manufacture_All_Open(nil, CppEnums.ItemWhereType.eInventory, true, nil, getCurrentWaypointKey())
	end
end

function MoveItemToInventoryFromVehicle(ItemName, Count, IsWarehouse)
	if true == IsWarehouse and false == Panel_Window_Warehouse:GetShow() or nil == ItemName then
		Proc_ShowMessage_Ack("Ice-->請打開倉庫")
		return
	end
	
	local temporaryWrapper = getTemporaryInformationWrapper()
    local vehicleWrapper = temporaryWrapper:getUnsealVehicle(CppEnums.ServantType.Type_Vehicle)
	local vehicleInven = vehicleWrapper:getInventory()
	if nil ~= temporaryWrapper and nil ~= vehicleWrapper and nil ~= vehicleInven then
		local capacity = vehicleInven:size()
		for idx = 0, capacity - 1 do
			local itemWrapper = getServantInventoryItemBySlotNo(vehicleWrapper:getActorKeyRaw(), idx)
			if nil ~= itemWrapper then
				local name = itemWrapper:getStaticStatus():getName()
				if name == ItemName then
					local iCount = itemWrapper:get():getCount_s64()
					if 0 == Count or Count >= iCount then
						moveInventoryItemFromActorToActor(vehicleWrapper:getActorKeyRaw(), getSelfPlayer():getActorKey(), CppEnums.ItemWhereType.eServantInventory, idx, iCount)
					else
						moveInventoryItemFromActorToActor(vehicleWrapper:getActorKeyRaw(), getSelfPlayer():getActorKey(), CppEnums.ItemWhereType.eServantInventory, idx, Count)
					end
				end
			end
		end
	end
end

function MoveItemToVehicleFromInventory(ItemName, Count, IsWarehouse)
	if true == IsWarehouse and false == Panel_Window_Warehouse:GetShow() or nil == ItemName then
		Proc_ShowMessage_Ack("Ice-->請打開倉庫")
		return
	end
	local temporaryWrapper = getTemporaryInformationWrapper()
    local vehicleWrapper = temporaryWrapper:getUnsealVehicle(CppEnums.ServantType.Type_Vehicle)
	local vehiclePos = vehicleWrapper:getPosition()
	local distance = GetDistanceBySelfPlayer(vehiclePos)
	if 700 < distance then
		Proc_ShowMessage_Ack("Ice-->沒有坐騎或坐騎太遠")
		AddReturn("false")
		return
	end
	local vehicleInven = vehicleWrapper:getInventory()
	if nil ~= temporaryWrapper and nil ~= vehicleWrapper and nil ~= vehicleInven then
		local freecount = vehicleInven:getFreeCount()
		local size = vehicleInven:size() - 2
		if freecount ~= size then
			Proc_ShowMessage_Ack("Ice-->請清空坐騎背包")
			AddReturn("false")
			return
		end
		local slot = GetInventorySlotByName(ItemName)
		if -1 == slot then
			Proc_ShowMessage_Ack("Ice-->背包沒有該道具")
			AddReturn("false")
			return
		end
		if 0 == Count then
			moveInventoryItemFromActorToActor(getSelfPlayer():getActorKey(), vehicleWrapper:getActorKeyRaw(), CppEnums.ItemWhereType.eInventory, slot, GetInventoryItemCount(ItemName))
		else
			moveInventoryItemFromActorToActor(getSelfPlayer():getActorKey(), vehicleWrapper:getActorKeyRaw(), CppEnums.ItemWhereType.eInventory, slot, Count)
		end
	end
end

function GetWarehouseItemData(ItemName)
	--if false == Panel_Window_Warehouse:GetShow() then
		--Proc_ShowMessage_Ack("Ice-->請打開倉庫")
		--return
	--end
	
	local warehouseWrapper = PaGlobal_Warehouse_All_GetWarehouseWarpper()
	local itemCount = warehouseWrapper:getSize()
	
	for i = 1, itemCount do
		local itemWrapper = PaGlobal_WareHouse_All:getWarehouse():getItem(i)
		if nil ~= itemWrapper then
			local name = itemWrapper:getStaticStatus():getName()
			if name == ItemName then
				local count = itemWrapper:get():getCount_s64()
				local weight = itemWrapper:getStaticStatus():get()._weight / 10000
				local itemData = {["name"] = name, ["weight"] = weight, ["count"] = Int64toInt32(count)}
				local js = JSON:encode(itemData)
				--Proc_ShowMessage_Ack(js)
				AddReturn(js)
			end
		end
	end
end

function WarehousePopToSomewhere(slot, count)
	if PaGlobal_WareHouse_All:isNpc() then
		warehouse_requestInfo(getCurrentWaypointKey())
		warehouse_popToInventoryByNpc(slot, count, getSelfPlayer():getActorKey())
    elseif PaGlobal_WareHouse_All:isInstallation() then
		warehouse_popToInventoryByInstallation(PaGlobal_WareHouse_All._installationActorKeyRaw, slot, count, getSelfPlayer():getActorKey())
    elseif PaGlobal_WareHouse_All:isGuildHouse() then
		warehouse_popToInventoryByGuildHouse(slot, count, getSelfPlayer():getActorKey())
    elseif PaGlobal_WareHouse_All:isFurnitureWareHouse() then
		ToClient_popToInventoryByFurnitureWarehouse(slot)
    elseif PaGlobal_WareHouse_All:isMaid() then
		local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
		if nil == regionInfo then
			return
		end
		local warehouseOutMaid = checkMaid_WarehouseOut(true)
		if warehouseOutMaid then
			warehouse_requestInfo(PaGlobal_WareHouse_All._currentWaypointKey)
			warehouse_popToInventoryByMaid(slot, count, getSelfPlayer():getActorKey())
		else
			Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_COOLTIME"))
		end
    end
end

function StorePop(ItemName, Count, IsSelf)
	if nil == ItemName then
		return
	end
	
	if false == Panel_Window_Warehouse:GetShow() then
		AddReturn("請打開倉庫")
		return false
	end
	
	local warehouseWrapper = PaGlobal_Warehouse_All_GetWarehouseWarpper()
	local itemCount = warehouseWrapper:getSize()
	
	for i = 1, itemCount do
		local itemWrapper = PaGlobal_WareHouse_All:getWarehouse():getItem(i)
		if nil ~= itemWrapper then
			local name = itemWrapper:getStaticStatus():getName()
			if name == ItemName then
				local _count = GetInventoryItemCount(ItemName)
				local need = Count - Int64toInt32(_count)
				local whCount = itemWrapper:get():getCount_s64()
				if 0 < need then
					if need >= Int64toInt32(whCount) then
						WarehousePopToSomewhere(i, whCount)
					else
						WarehousePopToSomewhere(i, toInt64(0, need))
					end
				end
				return true
			end
		end
	end
	
	AddReturn("倉庫沒有該道具")
	return false
end

function StorePush(ItemName, Count)
	if nil == ItemName then
		return
	end
	
	if false == Panel_Window_Warehouse:GetShow() then
		AddReturn("請打開倉庫")
		return false
	end
	
	local inventory = getSelfPlayer():get():getInventoryByType(CppEnums.ItemWhereType.eInventory)
	local invenSize = inventory:size()
	local useStartSlot = inventorySlotNoUserStart()

	for i = useStartSlot, invenSize do
		local itemSWW = getInventoryItem(i)
		if nil ~= itemSWW then
			local name = itemSWW:getStaticStatus():getName()
			if name == ItemName then
				if 0 == Count then
					local _count = itemSWW:get():getCount_s64()
					PaGlobal_Warehouse_All_PushFromInventoryItemXXX(_count, i, CppEnums.ItemWhereType.eInventory)
				else
					PaGlobal_Warehouse_All_PushFromInventoryItemXXX(Count, i, CppEnums.ItemWhereType.eInventory)
				end
				return true
			end
		end
	end
	
	AddReturn("背包沒有該道具")
	return false
end

function QuickSlotClick(slot)
	if 19 < slot then
		return
	end
	if isUseNewQuickSlot() then
		HandleClicked_NewQuickSlot_Use(slot)
	else
		if 9 < slot then
			return
		end
		QuickSlot_Click(tostring(slot))
	end
end

function UseAlchemyStone()
	local itemWrapper = ToClient_getEquipmentItem(CppEnums.EquipSlotNo.alchemyStone)
	if nil ~= itemWrapper and 0 < itemWrapper:get():getEndurance() then
		useAlchemyStone()
	end
end

function FinishMilkGame()
	PaGlobal_PowerControl_All:gameSuccess()
end

function StartMilkGame()
	local lastUI = GetUIMode()
	ActionMiniGame_Main(14)
	SetUIMode(lastUI)
end

function MassPin(pos_x, pos_y, pos_z)
	worldmapNavigatorStart(float3(pos_x, pos_y, pos_z), NavigationGuideParam(), false, false, true)
end

function MoveTo(pos_x, pos_y, pos_z, IsAuto)
	local pos = float3(pos_x, pos_y, pos_z)
	ToClient_DeleteNaviGuideByGroup(0)
	ToClient_WorldMapNaviStart(pos, NavigationGuideParam(), IsAuto, true)
	--worldmap_addNavigationBeam(pos, NavigationGuideParam(), true)
end

function Login(pwd2, channel, role, ghostMode)
	if nil == pwd2 and nil == channel then
		return
	end
	
	if nil ~= Panel_Lobby_Login_All and Panel_Lobby_Login_All:GetShow() and false == Panel_TermsofGameUse:GetShow() and false == Panel_Login_Password_All:GetShow() then
		FGlobal_TermsofGameUse_Open()
	elseif nil ~= Panel_TermsofGameUse and Panel_TermsofGameUse:GetShow() then
		HandleClicked_TermsofGameUse_Next()
	elseif nil ~= Panel_Login_Password_All and Panel_Login_Password_All:GetShow() then
		for i = 1, #pwd2 do
			local index = GetLoginSuffle(pwd2:sub(i, i))
			if -1 == index then
				return
			end
			HandleEventLUp_LoginPassword_All_NumBtnInput(index)
		end
		HandleEventLUp_LoginPassword_All_Apply()
	elseif nil ~= Panel_Lobby_ServerSelect_All and Panel_Lobby_ServerSelect_All:GetShow() then
		local index = GetChannelIndex(channel)
		if -1 ~= index then 
			PaGlobal_ServerSelect_All:enterMemorizedChannel(index + 1)
		else
			HandleEventLUp_ServerSelect_All_EnterLastJoinedServer()
		end
	elseif nil ~= Panel_CharacterSelect_All and Panel_CharacterSelect_All:GetShow() then
		if 0 < ghostMode then
			PaGlobal_CharacterSelect_All._ui.chk_Ghost:SetCheck(true)
		else
			PaGlobal_CharacterSelect_All._ui.chk_Ghost:SetCheck(false)
		end
		if PaGlobal_CharacterSelect_All._ui._btn_EnterTable[0]._enter:IsEnable() then
			HandleEventLUp_CharacterSelect_All_PrepareEnterToField(role)
		end
		--SetStartUpFinish()
	end
end

function GetLoginSuffle(text)
	for i = 0, 9 do
		if PaGlobal_LoginPassword_All._ui._btn_numSlots[i].baseText == text then
			return i
		end
	end
	
	return -1
end

function GetChannelIndex(ChannelName)
	if nil == ChannelName then
		return -1
	end
	local worldServerData = getGameWorldServerDataByIndex(0)
	if nil == worldServerData then
		return -1
	end
	local changeChannelTime = getChannelMoveableRemainTime(worldServerData._worldNo)
	if changeChannelTime > toInt64(0, 0) then
		return -1
	end
	local channelCount = getGameChannelServerDataCount(worldServerData._worldNo)
	for i = 0, channelCount - 1 do
		local serverData = getGameChannelServerDataByIndex(0, i)
		if nil == serverData then
			break
		end
		local channelName = getChannelName(worldServerData._worldNo, serverData._serverNo)
		if nil ~= channelName then
			if channelName == ChannelName then
				return i
			end
		end
	end
	
	return -1
end

function FishRodFilter()
	local inventory = getSelfPlayer():get():getInventoryByType(CppEnums.ItemWhereType.eInventory)
	local invenSize = inventory:size()
	local useStartSlot = inventorySlotNoUserStart()
	
	for i = useStartSlot, invenSize do
		local itemSWW = getInventoryItem(i)
		if nil ~= itemSWW then
			local Type = itemSWW:getStaticStatus():getEquipType()
			local endurance = itemSWW:get():getEndurance()
			if Type == 44 and 0 == endurance then
				DeleteInventoryItem(i, 0)
			end
		end
	end
end

function CollectToolFilter()
	local inventory = getSelfPlayer():get():getInventoryByType(CppEnums.ItemWhereType.eInventory)
	local invenSize = inventory:size()
	local useStartSlot = inventorySlotNoUserStart()
	
	for i = useStartSlot, invenSize do
		local itemSWW = getInventoryItem(i)
		if nil ~= itemSWW then
			local Type = itemSWW:getStaticStatus():getEquipType()
			local lifeType = itemSWW:getStaticStatus():getLifeStatMainType()
			local endurance = itemSWW:get():getEndurance()
			if Type == 46 and 15 == lifeType and 0 >= endurance then
				DeleteInventoryItem(i, 0)
			end
		end
	end
end

function ItemFilter(ItemName)
	if nil == ItemName then return end
	DeleteInventoryItemByName(ItemName, 0)
end

local function FishSort(a, b)
	if a.grade == b.grade then
		return a.TimePercent < b.TimePercent
	else
		return a.grade < b.grade
	end
end

function FishFilter(FishGrade)
	local inventory = getSelfPlayer():get():getInventoryByType(CppEnums.ItemWhereType.eInventory)
	local invenSize = inventory:size()
	local useStartSlot = inventorySlotNoUserStart()
	local FishList = {}

	for i = useStartSlot, invenSize do
		local itemSWW = getInventoryItem(i)
		if nil ~= itemSWW then
			local Type = itemSWW:getStaticStatus():getItemClassify()
			if 16 == Type then
				local Grade = itemSWW:getStaticStatus():getGradeType()
				if Grade <= FishGrade then
					DeleteInventoryItem(i, 0)
				else
					local itemExpiration = itemSWW:getExpirationDate()
					local s64_Time = itemExpiration:get_s64()
					local s64_remainTime = getLeftSecond_s64(itemExpiration)
					local remainTimePercent = Int64toInt32(s64_remainTime) / (itemSWW:getStaticStatus():get()._expirationPeriod * 60) * 100
					table.insert(FishList, {SlotNo = i, grade = Grade, TimePercent = remainTimePercent})
					table.sort(FishList, FishSort)
				end
			end
		end
	end
	
	local invenfreecount = inventory:getFreeCount()
	if 2 >= invenfreecount then
		for i = 1, 2 do
			local Fish = FishList[i]
			if nil ~= Fish then
				local itemWrapper = getInventoryItem(Fish.SlotNo)
				if nil ~= itemWrapper then
					local Type = itemWrapper:getStaticStatus():getItemClassify()
					if 16 == Type then
						DeleteInventoryItem(Fish.SlotNo, 0)
					end
				end
			end
		end
	end
end

function DeleteInventoryItem(SlotNo, ItemCount)
	if 0 < ItemCount then
		deleteItem(getSelfPlayer():getActorKey(), CppEnums.ItemWhereType.eInventory, SlotNo, ItemCount)
	else
		local itemWrapper = getInventoryItem(SlotNo)
		if nil ~= itemWrapper then
			deleteItem(getSelfPlayer():getActorKey(), CppEnums.ItemWhereType.eInventory, SlotNo, itemWrapper:get():getCount_s64())
		end
	end
end

function DeleteInventoryItemByName(ItemName, ItemCount)
	if nil == ItemName then
		return
	end
	
	local inventory = getSelfPlayer():get():getInventoryByType(CppEnums.ItemWhereType.eInventory)
	local invenSize = inventory:size()
	local useStartSlot = inventorySlotNoUserStart()
	
	for i = useStartSlot, invenSize do
		local itemSWW = getInventoryItem(i)
		if nil ~= itemSWW then
			local name = itemSWW:getStaticStatus():getName()
			if name == ItemName then
				if 0 < ItemCount then
					deleteItem(getSelfPlayer():getActorKey(), CppEnums.ItemWhereType.eInventory, i, ItemCount)
				else
					deleteItem(getSelfPlayer():getActorKey(), CppEnums.ItemWhereType.eInventory, i, itemSWW:get():getCount_s64())
				end
			end
		end
	end
end

function CheckLoot()
	if PaGloabl_Looting_All_GetShowPanel() then
		HandleEventLUp_Looting_All_LootAll(true)
	end
end

function CheckFishSit()
	local subTool = ToClient_getEquipmentItem(CppEnums.EquipSlotNoClient.eEquipSlotNoSubTool)
	if nil ~= subTool then
		local Type = subTool:getStaticStatus():getEquipType()
		local lifeType = subTool:getStaticStatus():getLifeStatMainType()
		local endurance = subTool:get():getEndurance()
		local res = true
		local inventory = getSelfPlayer():get():getInventoryByType(CppEnums.ItemWhereType.eInventory)
		if 46 ~= Type or 1 ~= lifeType or 0 >= endurance then
			if ToClient_SelfPlayerCheckAction("WAIT_SIT") then
				AddReturn("Q")
				return false
			end
			res = ChangeLifeSubTool(46, 1)
			if false == res then
				local invenfreecount = inventory:getFreeCount()					
					if 46 == Type and 1 == lifeType then
						if 1 < invenfreecount then
							HandleEventRUp_Equipment_All_EquipSlotRClick(CppEnums.EquipSlotNoClient.eEquipSlotNoSubTool)
						else
							AddReturn("背包沒有空格拆除椅子")
						end
					end
				return res
			else
				return res
			end
		end
	else
		res = ChangeLifeSubTool(46, 1)
		if false == res then
			return res
		end
	end
end
		
function CheckFishRod()
	local res = true
	local RightHand = ToClient_getEquipmentItem(CppEnums.EquipSlotNo.rightHand)
	if nil ~= RightHand then
		local Type = RightHand:getStaticStatus():getEquipType()
		local endurance = RightHand:get():getEndurance()
		if 44 ~= Type or 0 >= endurance then
			if ToClient_SelfPlayerCheckAction("WAIT_SIT") then
				AddReturn("Q")
				return false
			end
			res = ChangeEqiupment(44)
			if false == res then
				AddReturn("false")
				return res
			end
		end
	else
		res = ChangeEqiupment(44)
		if false == res then
			AddReturn("false")
			return res
		end
	end
	local LeftHand = ToClient_getEquipmentItem(CppEnums.EquipSlotNo.leftHand)
	if nil ~= LeftHand then
		local Type = RightHand:getStaticStatus():getEquipType()
		local endurance = RightHand:get():getEndurance()
		if 59 ~= Type or 0 >= endurance then
			if ToClient_SelfPlayerCheckAction("WAIT_SIT") then
				AddReturn("Q")
				return false
			end
			ChangeEqiupment(59)
		end
	else
		ChangeEqiupment(59)
	end
	
	return res
end

function ChangeLifeSubTool(EquipType, LifeMainType)
	local inventory = getSelfPlayer():get():getInventoryByType(CppEnums.ItemWhereType.eInventory)
	local invenSize = inventory:size()
	local useStartSlot = inventorySlotNoUserStart()

	for i = useStartSlot, invenSize do
		local itemSWW = getInventoryItem(i)
		if nil ~= itemSWW then
			local Type = itemSWW:getStaticStatus():getEquipType()
			local lifeType = itemSWW:getStaticStatus():getLifeStatMainType()
			local endurance = itemSWW:get():getEndurance()
			if Type == EquipType and lifeType == LifeMainType and 0 < endurance then
				inventoryUseItem(CppEnums.ItemWhereType.eInventory, i, 0, true)
				return true
			end
		end
	end
	
	return false
end

function ChangeEqiupment(EqiupType)
	local inventory = getSelfPlayer():get():getInventoryByType(CppEnums.ItemWhereType.eInventory)
	local invenSize = inventory:size()
	local useStartSlot = inventorySlotNoUserStart()

	for i = useStartSlot, invenSize do
		local itemSWW = getInventoryItem(i)
		if nil ~= itemSWW then
			local Type = itemSWW:getStaticStatus():getEquipType()
			local endurance = itemSWW:get():getEndurance()
			if Type == EqiupType and 0 < endurance then
				inventoryUseItem(CppEnums.ItemWhereType.eInventory, i, 0, true)
				return true
			end
		end
	end
	
	return false
end

function GetSinGaugeValue()
	local v = PaGlobal_SinGauge_All._progressValue
	AddReturn(tostring(v))
end

function GetFishingCommand()
	local command = {}
	local count = PaGlobal_Command_All._fishCount
	local currentIndex = PaGlobal_Command_All._currentCommandIndex
	local k = 1
	for i = currentIndex, count do
		command[k] = PaGlobal_Command_All._commands[i]
		k = k + 1
		--Proc_ShowMessage_Ack(tostring(command[i]))
		--PaGlobal_Command_All:commandInput(command[i])
	end
	local json = JSON:encode(command)
	--Proc_ShowMessage_Ack(json)
	AddReturn(json)
end

function FishingMiniGame()
	if ToClient_SelfPlayerCheckAction("FISHING_HOOK_ING_HARDER") or ToClient_SelfPlayerCheckAction("FISHINGSIT_HOOK_ING_HARDER") then
		getSelfPlayer():get():SetMiniGameResult(2)
		PaGlobal_Command_All._isCommandFinished = true
		PaGlobal_Command_All:endGame()
	end
end

function CatchFish(IsPerfect)
	if ToClient_SelfPlayerCheckAction("FISHING_HOOK_START") or ToClient_SelfPlayerCheckAction("FISHINGSIT_HOOK_START") then
		if true == IsPerfect then
			getSelfPlayer():get():SetMiniGameResult(3)
			PaGlobal_SinGauge_All:finishState()
			PaGlobal_SinGauge_All:prepareClose()
		else
			getSelfPlayer():get():SetMiniGameResult(11)
		end
	end
end

function DoAction(ActionName)
	getSelfPlayer():setActionChart(ActionName)
end

function GetDistanceBySelfPlayer(TargetPos)
	local selfPos = getSelfPlayer():get():getPosition()
	local Distance = -1
	selfPos.x = selfPos.x - TargetPos.x
    selfPos.y = selfPos.y - TargetPos.y
    selfPos.z = selfPos.z - TargetPos.z
    Distance = math.sqrt(selfPos.x * selfPos.x + selfPos.y * selfPos.y + selfPos.z * selfPos.z)
	return Distance
end

function IsSafeZone()
	local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
	local isSafeZone = regionInfo:get():isSafeZone()
	return isSafeZone
end

function SetNavigation(Position, IsAuto)
	if nil ~= Position then
		ToClient_DeleteNaviGuideByGroup(0)
		ToClient_WorldMapNaviStart(Position, NavigationGuideParam(), IsAuto, true)
	end
end

function FindAreaLocation(AreaName)
	local regionInfoCount = getRegionInfoCount()
	for index = 0, regionInfoCount - 1 do
		local regionInfo = getRegionInfo(index)
		local areaName = regionInfo:getAreaName()
		if areaName == AreaName then
			return regionInfo:getPosition()
		end
	end
end


function FindNpcLocation(NpcName, NpcType)
	local npcData = GetNpcInfo(NpcName, NpcType)
	if nil ~= npcData then
		return npcData:getPosition()
	end
end

function ToClient_GetNpcInfo(NpcName, NpcType)
	local npcData = GetNpcInfo(NpcName, NpcType)
	local info = {}
	if nil ~= npcData then
		local _name = npcData:getName()
		local _posX = npcData:getPosition().x
		local _posY = npcData:getPosition().y
		local _posZ = npcData:getPosition().z
		local _type = npcData:hasSpawnType(CppEnums.SpawnType.eSpawnType_WareHouse)
		info["name"] = _name
		info["posX"] = _posX
		info["posY"] = _posY
		info["posZ"] = _posZ
		info["type"] = _type
		local js = JSON:encode(info)
		AddReturn(js)
	end
end

function GetNpcInfo(NpcName, NpcType)
	if nil ~= NpcName and "" ~= NpcName then
		local regionInfoCount = getRegionInfoCount()
		local regionInfoList = {}
		for index = 0, regionInfoCount - 1 do
			local regionInfo = getRegionInfo(index)
			regionInfoList[index + 1] = {}
			local _npcNavi_TargetInfo = regionInfoList[index + 1]
			_npcNavi_TargetInfo.areaName = regionInfo:getAreaName()
			_npcNavi_TargetInfo.territoryKey = regionInfo:getTerritoryKeyRaw()
			_npcNavi_TargetInfo.regionKey = regionInfo:getRegionKey()
			_npcNavi_TargetInfo.isAccessible = regionInfo:get():isAccessibleArea()
			_npcNavi_TargetInfo.territoryName = regionInfo:getTerritoryName()
		end
		for index = 1, regionInfoCount do
			local regionInfo = regionInfoList[index]
			local count = npcList_getNpcCount(regionInfo.regionKey)
			for idx = 0, count - 1 do
				local npcData = npcList_getNpcInfo(idx)
				local name = npcData:getName()
				if NpcName == name then
					return npcData
				end
			end
		end
	else
		local NpcData = getNearNpcInfoByType(NpcType, getSelfPlayer():get3DPos())
		if nil ~= NpcData then
			return NpcData
		end
	end
end


function NpcInteraction()
	local actor = interaction_getInteractable()
	if actor:get():isNpc() then
		Interaction_ButtonPushed(CppEnums.InteractionType.InteractionType_Talk)
	end
end

function OpenWarehouse(IsOpen)
	if IsOpen then
      PaGlobal_Warehouse_All_OpenPanelFromDialog()
	  --PaGlobal_WareHouse_All._buttonData.marketRegist = true
    else
      PaGlobal_Warehouse_All_Close()
	  FromClient_DialogMain_All_HideDialog(false)
    end
end

function Skill()
	local cellTable = {
    [0] = nil,
    [1] = nil
  }
  local classType = getSelfPlayer():getClassType()
  if classType >= 0 then
    cellTable[0] = getAwakeningWeaponSkillTree(classType)
    cellTable[1] = getCombatSkillTree(classType)
  else
    return
  end
  local cols = cellTable[1]:capacityX()
  local rows = cellTable[1]:capacityY()
  for row = 0, rows - 1 do
      for col = 0, cols - 1 do
		local cell = cellTable[1]:atPointer(col, row)
		local skillNo = cell._skillNo
		if cell:isSkillType() then
			local skillLevelInfo = getSkillLevelInfo(skillNo)
			if skillLevelInfo._usable then
				local skillStaticWrapper = getSkillStaticStatus(skillNo, 1)
				local skillName = skillStaticWrapper:getName()
				--ToClient_LearnSkillCameraStartSkillAction(skillStaticWrapper:get())
				--AddReturn(skillName)
				Proc_ShowMessage_Ack(tostring(skillNo) .. ", " .. skillName)
			end
		end
	  end
  end
end

function ToClient_GetInventory()
	local inventory = getSelfPlayer():get():getInventoryByType(CppEnums.ItemWhereType.eInventory)
	local invenSize = inventory:size()
	local useStartSlot = inventorySlotNoUserStart()
	local item = {}

	for i = useStartSlot, invenSize do
		local itemSWW = getInventoryItem(i)
		if nil ~= itemSWW then
			local name = itemSWW:getStaticStatus():getName()
			table.insert(item, {itemWhereType = 0, itemName = name})
		end
	end
	
	table.insert(item, {itemWhereType = -1, itemName = "------------------------------------------------------------"})
	
	local inventory = getSelfPlayer():get():getInventoryByType(CppEnums.ItemWhereType.eCashInventory)
	local invenSize = inventory:size()
	local useStartSlot = inventorySlotNoUserStart()

	for i = useStartSlot, invenSize do
		local itemSWW = getInventoryItemByType(CppEnums.ItemWhereType.eCashInventory, i)
		if nil ~= itemSWW then
			local name = itemSWW:getStaticStatus():getName()
			table.insert(item, {itemWhereType = 1, itemName = name})
		end
	end
	
	js = JSON:encode(item)
	AddReturn(js)
	
end

function ToClient_GetBuff()
	local selfPlayer = getSelfPlayer()
	local appliedBuff = selfPlayer:getAppliedBuffBegin(false)
	local buff = {}
	while nil ~= appliedBuff do
		local strBuffName = appliedBuff:getBuffDesc():gsub("<[^%s]->","")
		table.insert(buff, {buffType = 0, buffName = strBuffName})
		appliedBuff = selfPlayer:getAppliedBuffNext(false)
	end
	
	appliedBuff = selfPlayer:getAppliedBuffBegin(true)
	while nil ~= appliedBuff do
		local strBuffName = appliedBuff:getBuffDesc():gsub("<[^%s]->","")
		table.insert(buff, {buffType = 1, buffName = strBuffName})
		appliedBuff = selfPlayer:getAppliedBuffNext(true)
	end
	
	js = JSON:encode(buff)
	AddReturn(js)
end

function OpenWorkerRecover()
	if nil == Panel_Window_WorkerManager_All then
		return
	end
	if true == workerManager_CheckWorkingOtherChannel() then
		local workingServerNo = getSelfPlayer():get():getWorkerWorkingServerNo()
		local temporaryWrapper = getTemporaryInformationWrapper()
		local worldNo = temporaryWrapper:getSelectedWorldServerNo()
		local channelName = getChannelName(worldNo, workingServerNo)
		Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORKERMANAGER_WORKERWORKINGOTHERCHANNEL", "channelName", channelName), nil, CppEnums.ChatType.System, CppEnums.ChatSystemType.Undefine)
		return
	end
	if false == ToClient_IsGrowStepOpen(__eGrowStep_worker) then
		return
	end
	PaGlobal_WorkerManager_All._ui.list2_worker:moveTopIndex()
	PaGlobal_WorkerManager_All._ui.list2_advence:moveTopIndex()
	HandleEventLUp_WorkerManager_All_RestoreGroupClose()
	HandleEventLUp_WorkerManager_All_SelectTabMenu(PaGlobal_WorkerManager_All._TAB.WORKER)
	PaGlobal_WorkerManager_All._ui_console.stc_detailMenu:SetShow(false)
	PaGlobalFunc_WorkerManager_All_ComboBoxResetAdd()
	Panel_Window_WorkerManager_All:RegisterUpdateFunc("PaGlobalFunc_WorkerManagerRestore_All_FrameUpdate")
	PaGlobal_WorkerManager_All:resize()
	if true == ToClient_WorldMapIsShow() then
		WorldMapPopupManager:increaseLayer(true)
		WorldMapPopupManager:push(Panel_Window_WorkerManager_All, true, nil, PaGlobalFunc_WorkerManager_All_Close)
	end
end

function Worker_RestoreAll()
	local self = PaGlobal_WorkerManagerRestore_All
	HandleEventOnOut_WorkerManager_WorkerInfoTooltip(false)
	if nil == Panel_Window_WorkerManagerRestore_All then
		return
	end
	self._workerListCount = PaGlobal_WorkerManager_All._totalWorkerCount
	self._workerArray = PaGlobal_WorkerManager_All._filteredArray
	self._sliderStartIdx = 0
	if nil ~= self._workerArray then
		self._ui.txt_itemlistGuide:SetText(self._guideText.All)
		self._ui.txt_titleName:SetText(self._titleText.All)
	elseif true == self._isConsole then
		self._ui.txt_itemlistGuide:SetText(self._guideText.CONSOLE)
		self._ui.txt_titleName:SetText(self._titleText.CONSOLE)
	else
		self._ui.txt_itemlistGuide:SetText(self._guideText.PC)
		self._ui.txt_titleName:SetText(self._titleText.PC)
	end
	self._ui.stc_slider:SetControlPos(0)
	PaGlobal_WorkerManagerRestore_All:update()
	--PaGlobal_WorkerManagerRestore_All:open()
	PaGlobal_WorkerManagerRestore_All:resize()
	HandleEventLUp_WorkerManagerRestore_All_SelectItem(0)
end

function WorkerRecover(Redo)
	local Item = ToClient_getNpcRecoveryItemList()
	if Item > 0 then
		OpenWorkerRecover()
		Worker_RestoreAll()
		--PaGlobalFunc_WorkerManager_All_ShowToggle()
		--HandleEventLUp_WorkerManager_All_RestoreAll()
		HandleEventLUp_WorkerManagerRestore_All_SelectItem(0)
		HandleEventLUp_WorkerManagerRestore_All_Confirm(0)
		PaGlobal_WorkerManager_All:update()
		PaGlobal_WorkerManager_All:prepareClose()
		if true == Redo then
			HandleEventLUp_WorkerManager_All_RepeatAll()
		end
		return
	end
	
	AddReturn("Ice_Error")
	Proc_ShowMessage_Ack("Ice-->請補充啤酒")
end

function GetInventorySlotByName(ItemName)
	if nil == ItemName then
		return -1
	end
	
	local inventory = getSelfPlayer():get():getInventoryByType(CppEnums.ItemWhereType.eInventory)
	local invenSize = inventory:size()
	local useStartSlot = inventorySlotNoUserStart()
	
	for i = useStartSlot, invenSize do
		local itemSWW = getInventoryItem(i)
		if nil ~= itemSWW then
			local name = itemSWW:getStaticStatus():getName()
			if name == ItemName then
				return i
			end
		end
	end
	
	return -1
end

function GetInventoryItemCount(ItemName)
	if nil == ItemName then
		return -1
	end
	
	local inventory = getSelfPlayer():get():getInventoryByType(CppEnums.ItemWhereType.eInventory)
	local invenSize = inventory:size()
	local useStartSlot = inventorySlotNoUserStart()
	local k = 1
	local countTable = {}
	local fCount = 0
	
	for i = useStartSlot, invenSize do
		local itemSWW = getInventoryItem(i)
		if nil ~= itemSWW then
			local name = itemSWW:getStaticStatus():getName()
			if name == ItemName then
				countTable[k] = itemSWW:get():getCount_s64()
				k = k + 1
			end
		end
	end
	
	
	if (1 == #countTable) then
		fCount = countTable[1]
	else
		fCount = #countTable
	end
	
	return fCount
end

function ToClient_GetInventoryItemCount(ItemName)
	if nil == ItemName then
		AddReturn("0")
		return -1
	end
	
	local itemCount = GetInventoryItemCount(ItemName)
	
	if 0 ~= itemCount then
		AddReturn(tostring(itemCount))
		return itemCount
	else
		AddReturn("0")
		return 0
	end
end

function ToClient_HaveInventoryItem(ItemName)
	local count = GetInventoryItemCount(ItemName)
	if 0 == Count then
		AddReturn("noitem")
		return false
	else
		return true
	end
end

function HasItemByKey(ItemKey)
	local inventory = getSelfPlayer():get():getInventoryByType(CppEnums.ItemWhereType.eInventory)
	local invenSize = inventory:size()
	local useStartSlot = inventorySlotNoUserStart()
	
	for i = useStartSlot, invenSize do
		local itemSWW = getInventoryItem(i)
		if nil ~= itemSWW then
			local key = itemSWW:getStaticStatus():get()._key:get()
			if key == ItemKey then
				return true
			end
		end
	end
	
	return false
end

function UseItem(ItemName)
	local inventory = getSelfPlayer():get():getInventoryByType(CppEnums.ItemWhereType.eInventory)
	local invenSize = inventory:size()
	local useStartSlot = inventorySlotNoUserStart()
	
	for i = useStartSlot, invenSize do
		local itemSWW = getInventoryItem(i)
		if nil ~= itemSWW then
			local name = itemSWW:getStaticStatus():getName()
			if name == ItemName then
				local remainTime = getItemCooltime(CppEnums.ItemWhereType.eInventory, i)
				if remainTime == 0 then
					inventoryUseItem(CppEnums.ItemWhereType.eInventory, i, 0, true)
					return
				end
			end
		end
	end
	
	local inventory = getSelfPlayer():get():getInventoryByType(CppEnums.ItemWhereType.eCashInventory)
	local invenSize = inventory:size()
	local useStartSlot = inventorySlotNoUserStart()

	for i = useStartSlot, invenSize do
		local itemSWW = getInventoryItemByType(CppEnums.ItemWhereType.eCashInventory, i)
		if nil ~= itemSWW then
			local name = itemSWW:getStaticStatus():getName()
			if name == ItemName then
				local remainTime = getItemCooltime(CppEnums.ItemWhereType.eCashInventory, i)
				if remainTime == 0 then
					inventoryUseItem(CppEnums.ItemWhereType.eCashInventory, i, 0, true)
					return
				end
			end
		end
	end
end

function RefillHP(Persent, ItemName, IsQuickSlot)
	local selfPlayer = getSelfPlayer()
	local currentHp = selfPlayer:get():getHp()
	local maxHp = selfPlayer:get():getMaxHp()
	local rate = (currentHp / maxHp) * 100
	
	if rate < Persent then
		if false == IsQuickSlot then
			if "使用煉金石" == ItemName then
				UseAlchemyStone()
			else
				UseItem(ItemName)
			end
		else
			QuickSlotClick(ItemName)
		end
	end
end

function RefillMP(Persent, ItemName, IsQuickSlot)
	local selfPlayer = getSelfPlayer()
	local currentMp = selfPlayer:get():getMp()
	local maxMp = selfPlayer:get():getMaxMp()
	local rate = (currentMp / maxMp) * 100
	
	if rate < Persent then
		if false == IsQuickSlot then
			if "使用煉金石" == ItemName then
				UseAlchemyStone()
			else
				UseItem(ItemName)
			end
		else
			QuickSlotClick(ItemName)
		end
	end
end

function FindBuff(BuffName)
	local selfPlayer = getSelfPlayer()
	local appliedBuff = selfPlayer:getAppliedBuffBegin(false)
	local findit = false
	while nil ~= appliedBuff do
		local buffName = appliedBuff:getBuffDesc():gsub("<[^%s]->","")
		if buffName == BuffName then
			return true
		end
		appliedBuff = selfPlayer:getAppliedBuffNext(false)
	end
	
	appliedBuff = selfPlayer:getAppliedBuffBegin(true)
	while nil ~= appliedBuff do
		local buffName = appliedBuff:getBuffDesc():gsub("<[^%s]->","")
		if buffName == BuffName then
			return true
		end
		appliedBuff = selfPlayer:getAppliedBuffNext(true)
	end
	
	return false
end

function RefillBuff(IsExist, BuffName, ItemName, IsQuickSlot)
	if 0 == IsExist then
		if false == FindBuff(BuffName) then
			if false == IsQuickSlot then
				if "使用煉金石" == ItemName then
					UseAlchemyStone()
				else
					UseItem(ItemName)
				end
			else
				QuickSlotClick(ItemName)
			end
		end
	else
		if true == FindBuff(BuffName) then
			if false == IsQuickSlot then
				if "使用煉金石" == ItemName then
					UseAlchemyStone()
				else
					UseItem(ItemName)
				end
			else
				QuickSlotClick(ItemName)
			end
		end
	end
end

function UseFeedItem(PetNo, ItemName)
	local userFeedItemCount = ToClient_Pet_GetFeedItemCount()
	if not userFeedItemCount then
		return
	end
	local staticItemCount = ToClient_Pet_GetFeedStaticItemCount()
	for i = 0, staticItemCount - 1 do
		local feedItem = ToClient_Pet_GetFeedItemByIndex(i)
		if not feedItem then
			return
		end
		local feedItemName = feedItem:getStaticStatus():getName()
		if ItemName == feedItemName then
			ToClient_Pet_UseFeedItemByIndex(i, PetNo)
		end
	end
end

function PetFeed(Persent, ItemName)
	local petCountUnseal = ToClient_getPetUnsealedList()
	if 0 == petCountUnseal then
		return
	end
	for index = 0, petCountUnseal - 1 do
		local PcPetData = ToClient_getPetUnsealedDataByIndex(index)
		if nil == PcPetData then
			return
		end
		local petStaticStatus = PcPetData:getPetStaticStatus()
		local petNo = PcPetData:getPcPetNo()
		local petHungry = PcPetData:getHungry()
		local petMaxHungry = petStaticStatus._maxHungry
		local petHungryPercent = petHungry / petMaxHungry * 100
		if petHungryPercent <= Persent then
			UseFeedItem(petNo, ItemName)
		end
    end
end