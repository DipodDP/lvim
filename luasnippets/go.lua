local fileName = function()
  return vim.fn.expand("%:t"):match "(.+)%..+$"
end

local fileContent = function()
  local bufId = vim.api.nvim_get_current_buf()
  return vim.api.nvim_buf_get_lines(bufId, 0, -1, false)
end

local structAttributes = function()
  local str = fileContent()
  local result = {}
  for i = 1, #str, 1 do
    if string.find(str[i], "{") then
      for j = i + 1, #str, 1 do
        if string.find(str[j], "}") then
          break
        end
        table.insert(result, str[j]:match "^%s*(.-)%s*$")
      end
      break
    end
  end
  return result
end

local structConstructorParameter = function()
  local attributes = structAttributes()
  local result = attributes[1]:sub(1, 1):lower() .. attributes[1]:sub(2)
  for i = 2, #attributes, 1 do
    result = result .. ", " .. attributes[i]:gsub("^[a-zA-Z]", string.lower)
  end
  return result
end

local fileNameUpperCamelCase = function()
  local str = fileName()
  return str:gsub("^[a-zA-Z]", string.upper)
end

return {
  s("testP", {
    f(structConstructorParameter, {}, {}),
  }),
  s("testF", {
    f(structAttributes, {}, {}),
  }),
  s("test", {
    f(fileContent, {}, {}),
  }),
  s("iferr", {
    t { "if err != nil {" },
    c(1, {
      { i(1), t { "", "  panic(" },  i(2, "err"), t ")" },
      { i(1), t { "", "  return " }, i(2, "err") },
    }),
    t { "", "}" },
  }),
  s("newC", {
    t { "func New" },
    f(fileNameUpperCamelCase, {}, {}),
    t { "(" },
    f(structConstructorParameter,{},{}),
    t { " )*" },
    f(fileNameUpperCamelCase, {}, {}),
    t { " {" },
    t { "", "  return  &" },
    f(fileNameUpperCamelCase, {}, {}),
    t { "{" },
    f(structAttributes, {}, {}),
    t { "", "  }", "}" },
  }),
}
