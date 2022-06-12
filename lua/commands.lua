-- Module: junkfile.commands

local commands = {}

commands.define = function(junkfile)
  vim.api.nvim_create_user_command("JunkfileOpen", function(args)
    junkfile.open(args.fargs[1], { save = args.bang, line1 = args.line1, line2 = args.line2, range = args.range })
  end, { bang = true, range = 0, nargs = "?", desc = "Open a junk file using the configured command" })

  vim.api.nvim_create_user_command("JunkfileEdit", function(args)
    junkfile.open(
      args.fargs[1],
      { save = args.bang, edit_command = "edit", line1 = args.line1, line2 = args.line2, range = args.range }
    )
  end, { bang = true, range = 0, nargs = "?", desc = "Open a junk file in the current window" })

  vim.api.nvim_create_user_command("JunkfileVsplit", function(args)
    junkfile.open(
      args.fargs[1],
      { save = args.bang, edit_command = "vsplit", line1 = args.line1, line2 = args.line2, range = args.range }
    )
  end, { bang = true, range = 0, nargs = "?", desc = "Open a junk file in a vertical split" })

  vim.api.nvim_create_user_command("JunkfileSplit", function(args)
    junkfile.open(
      args.fargs[1],
      { save = args.bang, edit_command = "split", line1 = args.line1, line2 = args.line2, range = args.range }
    )
  end, { bang = true, range = 0, nargs = "?", desc = "Open a junk file in a horizontal split" })

  vim.api.nvim_create_user_command("JunkfileTabEdit", function(args)
    junkfile.open(
      args.fargs[1],
      { save = args.bang, edit_command = "tabedit", line1 = args.line1, line2 = args.line2, range = args.range }
    )
  end, { bang = true, range = 0, nargs = "?", desc = "Open a junk file in a new tab" })

  vim.api.nvim_create_user_command("JunkfileWrite", function(args)
    junkfile.save(args.fargs[1])
  end, { nargs = "?", desc = "Save the current buffer to a junk file and open it using the configured command" })

  vim.api.nvim_create_user_command("JunkfileSave", function(args)
    junkfile.save(args.fargs[1], "edit")
  end, { nargs = "?", desc = "Save the current buffer to a junk file and open it in the current window" })

  vim.api.nvim_create_user_command("JunkfileVsplitSave", function(args)
    junkfile.save(args.fargs[1], "vsplit")
  end, { nargs = "?", desc = "Save the current buffer to a junk file and open it in a vertical split" })

  vim.api.nvim_create_user_command("JunkfileSplitSave", function(args)
    junkfile.save(args.fargs[1], "split")
  end, { nargs = "?", desc = "Save the current buffer to a junk file and open it in a horizontal split" })

  vim.api.nvim_create_user_command("JunkfileTabSave", function(args)
    junkfile.save(args.fargs[1], "tabedit")
  end, { nargs = "?", desc = "Save the current buffer to a junk file and open it in a new tab" })
end

return commands
