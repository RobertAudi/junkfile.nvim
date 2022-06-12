-- Module: junkfile

local utils = require("junkfile.utils")
local M = {}

M.default_options = {
  directory = utils.resolve_default_directory(),
  edit_command = "edit",
  define_commands = true,
}

M.setup = function(opts)
  M.options = utils.generate_configuration(opts, M.options, M.default_options)

  M.restore_defaults = function()
    M.options = utils.generate_configuration({}, {}, M.default_options)

    return M
  end

  M.open = function(filename, opts)
    opts = opts or {}

    local line1 = tonumber(opts.line1) or 0
    local line2 = tonumber(opts.line2) or 0
    local range = tonumber(opts.range)

    if line1 == line2 then
      if range == nil or range == 0 then
        line1 = 0
      end

      line2 = 0
    end

    local lines = {}

    if line1 > 0 then
      if line2 > 0 then
        lines = vim.fn.getline(line1, line2)
      else
        lines = vim.fn.getline(line1)
      end
    end

    local filename = utils.make_junk_tree(M.options.directory) .. "/" .. utils.get_filename(filename)
    local edit_command = utils.to_string(opts.edit_command or M.options.edit_command)

    utils.open_junkfile(filename, edit_command)

    if not utils.is_empty(lines) then
      local line_number = vim.fn.line("$")

      if line_number > 1 then
        line_number = line_number + 1
      end

      vim.fn.setline(line_number, lines)
      vim.fn.cursor({ line_number, 1 })
    end

    if opts.save then
      vim.api.nvim_command("write!")
    end
  end

  M.save = function(filename, edit_command)
    local filename = utils.make_junk_tree(M.options.directory) .. "/" .. utils.get_filename(filename)
    edit_command = utils.to_string(edit_command or M.options.edit_command)

    vim.pretty_print(filename)

    vim.api.nvim_command("write! " .. vim.fn.fnameescape(filename))
    utils.open_junkfile(filename, edit_command)
  end

  if M.options.define_commands then
    require("junkfile.commands").define(M)
  end

  return M
end

return M
