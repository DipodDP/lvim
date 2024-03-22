local present, webdevicons = pcall(require, "nvim-web-devicons")
if not present then
  return
end

webdevicons.set_icon {
  astro = {
    --  󱓟 
    icon = "󰑣",
    color = "#FF7E33",
    name = "astro",
  },
  properties = {
    --     
    icon = "",
    color = "#6B7D83",
    name = "properties",
  },
  http = {
    icon = "",
    color = "#6B7D83",
    name = "properties",
  },
  gradle = {
    icon = "",
    color = "#6B7D83",
    name = "properties",
  },
  norg = {
    -- 
    icon = "",
    color = "#FFFFFF",
    name = "properties",
  },
puml = {
    -- 
    icon = "",
    color = "#FFFFFF",
    name = "properties",
  },
}
