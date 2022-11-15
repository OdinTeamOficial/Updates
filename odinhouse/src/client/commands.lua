

--if Config.CreateHouses then
  RegisterCommand(Config.Command_create , function(...)
    local plyPed  = GetPlayerPed(-1)
    local plyJob  = vRPUtils.getPlayerJob(Config.PermiAdmin)

    if not plyJob then return end

    ShowNotification(Labels["AcceptDrawText"]..Labels["SetEntry"])

    while not IsControlJustPressed(0,Config.Controles.Aceitar)  do Wait(0); end
    while     IsControlPressed(0,Config.Controles.Aceitar)      do Wait(0); end

    local entryPos = GetEntityCoords(plyPed)
    local entryHead = GetEntityHeading(plyPed)
    local entryLocation = vector4(entryPos.x,entryPos.y,entryPos.z,entryHead)

    ShowNotification(Labels["AcceptDrawText"]..Labels["SetGarage"].."\n"..Labels["CancelDrawText"]..Labels["CancelGarage"])

    while not IsControlJustPressed(0,Config.Controles.Aceitar) and not IsControlJustPressed(0,Config.Controles.Cancelar) do Wait(0); end    
    while     IsControlPressed(0,Config.Controles.Aceitar)          or IsControlPressed(0,Config.Controles.Cancelar)     do Wait(0); end

    local garageLocation = false
    if IsControlJustReleased(0,Config.Controles.Aceitar) then
      local garagePos = GetEntityCoords(plyPed)
      local garageHead = GetEntityHeading(plyPed)
      garageLocation = vector4(garagePos.x,garagePos.y,garagePos.z,garageHead)
    end

    ShowNotification(Labels["SetSalePrice"])
    exports["input"]:Open(Labels['SetSalePrice'],(Config.UsingESX and Config.UsingESXMenu and "ESX" or "Native"),function(data)
      local salePrice = math.max(1,(tonumber(data) and tonumber(data) > 0 and tonumber(data) or 0))

        local is_interior,is_shell = false,false
        if Config.UsandoMLO then
          if Config.UsingESX and Config.UsingESXMenu then
            local elements = {
              [1] = {label = Labels["UseInterior"],value="interior"},
              [2] = {label = Labels["UseShell"],value="shell"}
            }
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), "select_int_type",{
                title    = Labels["InteriorType"],
                align    = 'center',
                elements = elements,
              }, 
              function(data,menu)
                menu.close()
                if data.current.value == "interior" then
                  ShowNotification(Labels['AcceptDrawText']..Labels['SetInterior'])
                  while true do
                    local ped = GetPlayerPed(-1)
                    local pos = GetEntityCoords(ped)
                    local int = GetInteriorAtCoords(pos.x,pos.y,pos.z)
                    ShowHelpNotification(Labels['Interior']..": "..int)
                    if IsControlJustReleased(0,Config.Controles.Aceitar) then
                      if int and int >= 1 then
                        is_interior = int
                        ShowNotification(Labels['Interior']..": "..int)
                        return
                      end
                    end
                    Wait(0)
                  end
                elseif data.current.value == "shell" then            
                  ShowNotification(Labels["SelectDefaultShell"])
                    local elements = {}
                    for k,v in pairs(ShellModels) do
                      table.insert(elements,{label = k})
                    end
                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), "create_house_shell",{
                        title    = Labels["SelectDefaultShell"],
                        align    = 'center',
                        elements = elements,
                      }, 
                      function(submitData,submitMenu)
                        is_shell = submitData.current.label
                        submitMenu.close()
                      end,
                      function(data,menu)
                        menu.close()
                      end
                    )
                end
              end
            )
          else
            local get_int = CreateNativeUIMenu(Labels["InteriorType"],"")
            local interior = NativeUI.CreateItem(Labels["Interior"],"")
            interior.Activated = function(...)
              _Pool:CloseAllMenus()
              ShowNotification(Labels['AcceptDrawText']..Labels['SetInterior'])
              while true do
                local ped = GetPlayerPed(-1)
                local pos = GetEntityCoords(ped)
                local int = GetInteriorAtCoords(pos.x,pos.y,pos.z)
                ShowHelpNotification(Labels['Interior']..": "..int)
                if IsControlPressed(0,Config.Controles.Aceitar) then
                  if int and int >= 1 then
                    is_interior = int
                    ShowNotification(Labels['Interior']..": "..int)
                    return
                  end
                end
                Wait(0)
              end
            end

            local shells = NativeUI.CreateItem(Labels["Shell"],"")
            shells.Activated = function(...)
              _Pool:CloseAllMenus()
              local shell = CreateNativeUIMenu(Labels["SelectDefaultShell"],"")
              for key,price in pairs(ShellModels) do
                local _item = NativeUI.CreateItem(key,"")
                _item.Activated = function(...) 
                  is_shell = key
                  _Pool:CloseAllMenus()
                end
                shell:AddItem(_item)
              end    
              shell:RefreshIndex()
              shell:Visible(true)  
            end
          end
        else
          ShowNotification(Labels["SelectDefaultShell"])
          if Config.UsingESX and Config.UsingESXMenu then
            local elements = {}
            for k,v in pairs(ShellModels) do
              table.insert(elements,{label = k})
            end
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), "create_house_shell",{
                title    = Labels["SelectDefaultShell"],
                align    = 'center',
                elements = elements,
              }, 
              function(submitData,submitMenu)
                is_shell = submitData.current.label
                submitMenu.close()
              end,
              function(data,menu)
                menu.close()
              end
            )
          else
            local shell = CreateNativeUIMenu(Labels["SelectDefaultShell"],"")
            for key,price in pairs(ShellModels) do
              local _item = NativeUI.CreateItem(key,"")
              _item.Activated = function(...) 
                is_shell = key
                _Pool:CloseAllMenus()
              end
              shell:AddItem(_item)
            end    
            shell:RefreshIndex()
            shell:Visible(true)  
          end
        end

        while not is_interior and not is_shell do Wait(0); end

        local shells,doors = {},{}
        if is_shell then
          ShowNotification(Labels['ToggleShells'])
          if Config.UsingESX and Config.UsingESXMenu then
            local elements = {}
            for k,v in pairs(ShellModels) do
              table.insert(elements,{label = k})
            end
            table.insert(elements,{label = "Done"})
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), "create_house_shell",{
                title    = Labels['SetDefaultShell'],
                align    = 'center',
                elements = elements,
              }, 
              function(submitData,submitMenu)
                if submitData.current.label == "Done" then
                  ShowNotification(Labels['CreationComplete'])
                  submitMenu.close()
  
                  TriggerServerEvent("Allhousing:CreateHouse",{Bau = 0,Price = salePrice,Entry = entryLocation,Garage = garageLocation,Shell = is_shell,Interior = is_interior,Shells = shells,Doors = doors})
                else
                  shells[submitData.current.label] = (not shells[submitData.current.label])
                  ShowNotification(submitData.current.label..": "..(shells[submitData.current.label] == true and Labels['Enabled'] or Labels['Disabled']))
                end
              end,
              function(data,menu)
                menu.close()
              end
            )
          else
            local shell = CreateNativeUIMenu(Labels['AvailableShells'],"")
            for k,v in pairs(ShellModels) do
              shells[k] = false
              local _item = NativeUI.CreateCheckboxItem(k,false,"")
              _item.CheckboxEvent = function(a,b,checked) 
                shells[k] = checked
              end
              shell:AddItem(_item)  
            end 
            local _item = NativeUI.CreateItem(Labels['Done'],"")
            _item.Activated = function(...) 
              ShowNotification(Labels['CreationComplete'])
              _Pool:CloseAllMenus()
              
              TriggerServerEvent("Allhousing:CreateHouse",{Bau = 0,Price = salePrice,Entry = entryLocation,Garage = garageLocation,Shell = is_shell,Interior = is_interior,Shells = shells,Doors = doors})
            end
            shell:AddItem(_item)
            shell:RefreshIndex()
            shell:Visible(true)     
          end
        else
          TriggerServerEvent("Allhousing:CreateHouse",{Bau = 0,Price = salePrice,Entry = entryLocation,Garage = garageLocation,Shell = is_shell,Interior = is_interior,Shells = shells,Doors = doors})
        end
    end)
  end)
--end



CreateDoors = function(house)
  local elements = {
    [1] = {label = Labels['NewDoor'],value = "new"},
    [2] = {label = Labels["Done"],value="done"}
  }
  ESX.UI.Menu.Open('default', GetCurrentResourceName(), "create_house_doors",{
      title    = Labels['Doors'],
      align    = 'center',
      elements = elements,
    }, 
    function(data,menu)
      menu.close()
      if data.current.value == "done" then
        
        TriggerServerEvent("Allhousing:CreateHouse",house)
      else
        Wait(500)
        TriggerEvent("Doors:CreateDoors",function(creation)
          table.insert(house.Doors,creation)
          CreateDoors(house)
        end)        
      end
    end
  )
  end