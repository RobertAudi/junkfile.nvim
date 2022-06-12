-- Module junkfile.utils

local utils = {}
local next = next

--- Determine if a value of any type is empty
--- @param item any
--- @return boolean
utils.is_empty = function(item)
  local thing_type = type(item)

  return not item or (thing_type == "string" and item == "") or (thing_type == "table" and next(item) == nil)
end

--- Determine if a value of any type is blank.
--- Strings with only whitespace are considered blank.
--- @param item any
--- @return boolean
utils.is_blank = function(item)
  if type(item) == "string" and string.match(item, "%S") == nil then
    return true
  else
    return utils.is_empty(item)
  end
end

utils.is_directory = function(path)
  return vim.fn.isdirectory(path) > 0
end

utils.file_exists = function(path)
  return vim.fn.filereadable(path) > 0
end

utils.to_string = function(value)
  if value == nil then
    return ""
  end

  if type(value) == "function" then
    value = value()
  end

  return tostring(value)
end

utils.resolve_default_directory = function()
  local xdg_cache_home = os.getenv("XDG_CACHE_HOME")

  if utils.is_blank(xdg_cache_home) then
    xdg_cache_home = "~/.cache"
  end

  return xdg_cache_home .. "/nvim/junkfile"
end

utils.resolve_directory = function(directory)
  if utils.is_blank(directory) then
    return utils.resolve_default_directory()
  elseif type(directory) == "function" then
    return utils.resolve_directory(directory())
  else
    return utils.to_string(directory)
  end
end

utils.generate_options = function(new_options, existing_options, default_options)
  new_options = new_options or {}
  existing_options = existing_options or {}

  local options = {}

  for opt, value in pairs(default_options) do
    if utils.is_blank(new_options[opt]) then
      options[opt] = existing_options[opt] or value
    else
      options[opt] = new_options[opt]
    end
  end

  return options
end

utils.get_filename = function(filename)
  local prefix = ""
  local postfix = ""

  if utils.is_blank(filename) then
    prefix = os.date("%H-%M-%S") .. ".junkfile"
    postfix = vim.fn.expand("%:e", false, false)
  else
    prefix = vim.fn.fnamemodify(filename, ":r")
    postfix = vim.fn.fnamemodify(filename, ":e")

    if utils.is_blank(postfix) then
      postfix = vim.fn.expand("%:e", false, false)
    end
  end

  if utils.is_blank(postfix) then
    postfix = "txt"
  end

  return vim.fn.input("Junkfile: ", prefix .. "." .. postfix)
end

utils.make_junk_tree = function(directory)
  local junk_dir = vim.fn.expand(utils.resolve_directory(directory), false, false)
  junk_dir = junk_dir .. os.date("/%Y/%m/%d")

  if not utils.is_directory(junk_dir) then
    vim.fn.mkdir(junk_dir, "p")
  end

  return junk_dir
end

utils.open_junkfile = function(filename, edit_command)
  vim.api.nvim_command(edit_command .. " " .. vim.fn.fnameescape(filename))

  vim.b.Junkfile = vim.fn.bufnr("%")

  return vim.b.Junkfile
end

return utils
