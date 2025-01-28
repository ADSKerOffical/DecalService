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
isdeaca = part
 break
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

return DecalService
