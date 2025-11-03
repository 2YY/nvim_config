-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require('lualine')

-- Color table for highlights
-- stylua: ignore
local colors = {
  bg       = '#202328',
  fg       = '#bbc2cf',
  yellow   = '#ECBE7B',
  cyan     = '#008080',
  darkblue = '#081633',
  green    = '#98be65',
  orange   = '#FF8800',
  violet   = '#a9a1e1',
  magenta  = '#c678dd',
  blue     = '#51afef',
  red      = '#ec5f67',
  white    = '#ffffff'
}
local colors_inactive = {
  bg       = '#25292f',
  fg       = '#60656f',
  yellow   = '#73644f',
  cyan     = '#194c51',
  darkblue = '#1c2434',
  green    = '#536447',
  orange   = '#7a4f20',
  violet   = '#595976',
  magenta  = '#644975',
  blue     = '#385e7b',
  red      = '#733f47',
  white    = '#7a7d82'
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    component_separators = '',
    section_separators = '',
    theme = {
      -- We are going to use lualine_c an lualine_x as left and
      -- right section. Both are highlighted by c theme .  So we
      -- are just setting default looks o statusline
      normal = { c = { fg = colors.fg, bg = colors.bg } },
      inactive = { c = { fg = colors.fg, bg = colors.bg } },
    },
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end
local function ins_left_inactive(component)
  table.insert(config.inactive_sections.lualine_c, component)
end

-- Inserts a component in lualine_x at right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end
local function ins_right_inactive(component)
  table.insert(config.inactive_sections.lualine_x, component)
end

local function fileSizeComponent(color)
  return {
    -- filesize component
    'filesize',
    cond = conditions.buffer_not_empty,
    color = { fg = color, gui = 'bold' }
  }
end
local function locationComponent(color)
  return {
    'location',
    color = { fg = color }
  }
end
-- local progressComponent = { 'progress', color = { fg = colors.fg, gui = 'bold' } }
local function progressComponent(color)
  return {
    'progress',
    color = { fg = color, gui = 'bold' }
  }
end
local function diagnosticsComponent(color_error, color_warn, color_info)
  return {
    'diagnostics',
    sources = { 'nvim_diagnostic' },
    symbols = { error = ' ', warn = ' ', info = ' ' },
    diagnostics_color = {
      error = { fg = color_error },
      warn = { fg = color_warn },
      info = { fg = color_info },
    },
  }
end
local function recordingComponent(color)
  return {
    function()
      local reg = vim.fn.reg_recording()
      if reg == "" then return "" end -- NOTE: マクロの記録中じゃない時は空文字にして非表示。
      return "󰑋 " .. reg
    end,
    color = { fg = color },
  }
end
local spacerComponent = {
  -- Insert mid section. You can make any number of sections in neovim :)
  -- for lualine it's any number greater then 2
  function()
    return '%='
  end
}
local function fileNameComponent(color)
  return {
    'filename',
    cond = conditions.buffer_not_empty,
    color = { fg = color, gui = 'bold' },
  }
end
local function lspServerNameComponent(color)
  return {
    function()
      local msg = 'No Active Lsp'
      local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
      local clients = vim.lsp.get_clients()
      if next(clients) == nil then
        return msg
      end
      for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
          return client.name
        end
      end
      return msg
    end,
    icon = ' LSP:',
    color = { fg = color, gui = 'bold' },
  }
end
local function fileTypeComponent(color)
  return {
    'filetype',
    cond = conditions.hide_in_width,
    color = { fg = color, gui = 'bold' },
  }
end
local function encodingComponent(color)
  return {
    'o:encoding', -- option component same as &encoding in viml
    fmt = string.upper, -- I'm not sure why it's upper case either ;)
    cond = conditions.hide_in_width,
    color = { fg = color, gui = 'bold' },
  }
end
local function fileFormatComponent(color)
  return {
    'fileformat',
    symbols = { unix = "LF", dos = "CRLF", mac = "CR" },
    fmt = string.upper,
    color = { fg = color, gui = 'bold' },
  }
end

-- NOTE: ウィンドウのフォーカスが消えたときに非表示になってガタツキが発生し気になるので、やむなく今は使っていない。
local function branchComponent(color)
  return {
    'branch',
    icon = '',
    color = { fg = color, gui = 'bold' },
  }
end

local function diffComponent(color_added, color_modified, color_removed)
  return {
    'diff',
    -- Is it me or the symbol for modified us really weird
    symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
    diff_color = {
    added = { fg = color_added },
    modified = { fg = color_modified },
    removed = { fg = color_removed },
  },
  cond = conditions.hide_in_width,
  }
end

ins_left(fileSizeComponent(colors.fg))
ins_left(locationComponent(colors.fg))
ins_left(progressComponent(colors.fg))
ins_left(diagnosticsComponent(colors.red, colors.yellow, colors.cyan))
ins_left(recordingComponent(colors.red))
ins_left(spacerComponent)
ins_left(fileNameComponent(colors.white))
ins_right(lspServerNameComponent(colors.white))
ins_right(fileTypeComponent(colors.fg))
ins_right(encodingComponent(colors.green))
ins_right(fileFormatComponent(colors.green))
-- ins_right(branchComponent(colors.violet))
ins_right(diffComponent(colors.green, colors.orange, colors.red))

ins_left_inactive(fileSizeComponent(colors_inactive.fg))
ins_left_inactive(locationComponent(colors_inactive.fg))
ins_left_inactive(progressComponent(colors_inactive.fg))
ins_left_inactive(diagnosticsComponent(colors_inactive.red, colors_inactive.yellow, colors_inactive.cyan))
ins_left_inactive(spacerComponent)
ins_left_inactive(fileNameComponent(colors_inactive.white))
ins_right_inactive(lspServerNameComponent(colors_inactive.white))
ins_right_inactive(fileTypeComponent(colors_inactive.fg))
ins_right_inactive(encodingComponent(colors_inactive.green))
ins_right_inactive(fileFormatComponent(colors_inactive.green))
-- ins_right_inactive(branchComponent(colors_inactive.violet))
ins_right_inactive(diffComponent(colors_inactive.green, colors_inactive.orange, colors_inactive.red))

-- Now don't forget to initialize lualine
lualine.setup(config)

