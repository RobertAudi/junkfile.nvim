junkfile.nvim
=============

A plugin to create junk files.

Installation
------------

Use your favorite plugin manager. Using [packer.nvim](https://github.com/wbthomason/packer.nvim):

```lua
use("RobertAudi/junkfile.nvim")
```

Configuration
-------------

```lua
use({
  "RobertAudi/junkfile.nvim",
  config = function()
    require("junkfile").setup({
      -- Directory where junk files are created.
      -- Default: $XDG_CACHE_HOME/nvim/junkfile or "~/.cache/nvim/junkfile"
      directory = "~/.cache/nvim/junkfile",

      -- Ex command used when opening a junk file.
      -- Default: "edit"
      edit_command = "edit",

      -- Whether or not the commands should be defined automatically.
      -- Default: true
      define_commands = true,
    })
  end,
})
```

Lua API
-------

**Note: The functions are only available after calling `require("junkfile").setup({})`.**

### `junkfile.setup()`

```lua
-- Setup the junkfile plugin
-- Returns the junkfile modile
local junkfile = require("junkfile").setup({})
```

### `junkfile.default_options`

```lua
local junkfile = require("junkfile").setup({})

-- Variable holding the junkfile default options
junkfile.options -- { directory = "~/.cache/nvim/junkfile", edit_command = "edit", define_commands = true }
```

### `junkfile.options`

```lua
local junkfile = require("junkfile").setup({
  directory = "~/.cache/junkfile",
  edit_command = "split",
  define_commands = false,
})

-- Variable holding the junkfile configured options
junkfile.options -- { directory = "~/.cache/junkfile", edit_command = "split", define_commands = false }
```

### `junkfile.restore_defaults()`

```lua
local junkfile = require("junkfile").setup({})

-- Restore the default options
-- Returns the junkfile module
junkfile.restore_defaults()
```

### `junkfile.open()`

```lua
local junkfile = require("junkfile").setup({})

-- Open a new junk file using the configured edit command
junkfile.open()

-- Open a new junk file in the current window
junkfile.open(nil, { edit_command = "edit" })

-- Open a new junk file named "foo"
junkfile.open("foo", {})

-- Open a new junk file named "foo" and the ".lua" extention
junkfile.open("foo.lua", {})

-- Open a new junk file in a vertical split
junkfile.open(nil, { edit_command = "vsplit" })

-- Open a new junk file in a horizontal split
junkfile.open(nil, { edit_command = "split" })

-- Open a new junk file in a new tab
junkfile.open(nil, { edit_command = "tabedit" })

-- Open a new junk file with the contents of line 42
junkfile.open(nil, { line1 = 42 })

-- Open a new junk file with the contents of lines 42 through 73
junkfile.open(nil, { line1 = 42, line2 = 73 })

-- Open a new junk file named "foo" with the contents of lines 42 through 73
-- then append lines 6 through 22 to it
junkfile.open("foo", { line1 = 42, line2 = 73 })
junkfile.open("foo", { line1 = 6, line2 = 22 })
```

### `junkfile.save()`

```lua
local junkfile = require("junkfile").setup({})

-- Save the current buffer to a new junk file and open it using the configured edit command
junkfile.save()

-- Save the current buffer to a new junk file named "foo"
junkfile.save("foo", {})

-- Save the current buffer to a new junk file named "foo" and the ".lua" extention
junkfile.save("foo.lua", {})

-- Save the current buffer to a new junk file in a vertical split
junkfile.save(nil, { edit_command = "vsplit" })

-- Save the current buffer to a new junk file in a horizontal split
junkfile.save(nil, { edit_command = "split" })

-- Save the current buffer to a new junk file in a new tab
junkfile.save(nil, { edit_command = "tabedit" })
```

Commands
--------

| Command                            | Description                                                                      |
| :--------------------------------- | :------------------------------------------------------------------------------- |
| `:JunkfileOpen[!] [{filename}]`    | Open a junk file using the configured command.                                   |
| `:JunkfileEdit[!] [{filename}]`    | Open a junk file in the current window                                           |
| `:JunkfileVsplit[!] [{filename}]`  | Open a junk file in a horizontal split                                           |
| `:JunkfileSplit[!] [{filename}]`   | Open a junk file in a vertical split                                             |
| `:JunkfileTabEdit[!] [{filename}]` | Open a junk file in a new tab                                                    |
| `:JunkfileWrite [{filename}]`      | Save the current buffer to a junk file and open it using the configured command  |
| `:JunkfileSave [{filename}]`       | Save the current buffer to a junk file and open it in the current window         |
| `:JunkfileVsplitSave [{filename}]` | Save the current buffer to a junk file and open it in a vertical split           |
| `:JunkfileSplitSave [{filename}]`  | Save the current buffer to a junk file and open it in a new horizontal split     |
| `:JunkfileTabSave [{filename}]`    | Save the current buffer to a junk file and open it in a new tab                  |

Credits
-------

This plugin is a Lua rewrite of [junkfile.vim](https://github.com/Shougo/junkfile.vim) by [Shougo Matsushita](https://github.com/Shougo).

License
-------

<details>
  <summary>
    <a href="http://www.wtfpl.net/" rel="nofollow">WTFPL</a> – Do What the Fuck You Want to Public License
  </summary>
  <br>


```text
            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                    Version 2, December 2004

 Copyright (C) 2022 Robert Audi

 Everyone is permitted to copy and distribute verbatim or modified
 copies of this license document, and changing it is allowed as long
 as the name is changed.

            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

  0. You just DO WHAT THE FUCK YOU WANT TO.
```

</details>
