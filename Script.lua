local DecalService = {}

function DecalService:GetImageFromId(id)
  return "https://www.roblox.com/asset-thumbnail/image?assetId=" .. id .. "&width=432&height=432&format=png"
end

function DecalService:GetAssetFromLink(link, filetype)
  local success, response = pcall(function()
 return game:HttpGet(link)
   end)
   
   if success then
local Icon = "Image.png"
writefile(Icon, response)
return getcustomasset(Icon)
  else
warn("Failed to load asset: ", response)
   end
end

function DecalService:FindPartWithId(id)
 local isdeaca = nil
  for _, part in ipairs(workspace:GetDescendants()) do
    if part:IsA("BasePart") then
       local cdecal = part:FindFirstChildOfClass("Decal") or part:FindFirstChildOfClass("Texture") or nil
      if cdecal and cdecal.Texture == id then
     isdeaca = part
        break
      end
    end
  end
 if isdeaca == nil then
warn("Part with image with such id not found")
return nil
 end
  return isdeaca
end

function DecalService:AssetType(assetId)
 if not assetId or typeof(assetId) ~= "string" then
warn("Non supported format")
  return nil
 end

 if assetId:sub(1, 13) == "rbxassetid://" then
  return "RobloxAsset"
    elseif assetId:sub(1, 11) == "rbxasset://" then
        return "File"
    else
  return "Unknown"
 end
end

function DecalService:DependentWith(decal, instance) 
  if not decal or typeof(instance) ~= "Instance" then return end
    if instance:IsA("Decal") or instance:IsA("Texture") then
return instance.Changed:Connect(function(property)
 decal.Texture = instance.Texture
 decal.Color3 = instance.Color3
 decal.Transparency = instance.Transparency
 decal.ZIndex = instance.ZIndex
 decal.LocalTransparencyModifier = instance.LocalTransparencyModifier
end)
  elseif instance:IsA("BasePart") then
return instance.Changed:Connect(function(property)
 decal.Color3 = instance.Color
 decal.Transparency = instance.Transparency
 decal.LocalTransparencyModifier = instance.LocalTransparencyModifier
end)
 elseif instance:IsA("GuiObject") or decal:IsA("GuiObject") then
error("Instances must be in 3D dimensions")
   end
end

function DecalService:CanLoad(decalId)
  if not decalId or type(decalId) ~= "number" then return false end
  local assetId = "rbxassetid://".. decalId

 local success, erro = pcall(function()
     game:GetService("ContentProvider"):PreloadAsync({assetId})
  end)

  if not success then
    return false
  end

  return true
end

function DecalService:ImageChanged(decal, callback)
  if not decal or not decal["Texture"] or typeof(callback) ~= "function" then return end

  local function onTextureChanged()
    local texture = decal.Texture
      if texture then
        callback(texture)
      end
    end

 return decal:GetPropertyChangedSignal("Texture"):Connect(onTextureChanged)
end

return DecalService
