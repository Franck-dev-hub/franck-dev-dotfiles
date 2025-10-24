-- Associate extentions
vim.api.nvim_create_autocmd({"BufRead","BufNewFile"}, {
    pattern = {"*.gcode","*.nc"},
    callback = function()
        vim.bo.filetype = "gcode"

        -- Highlighting
        local set_hl = vim.api.nvim_set_hl
        set_hl(0, "GCodeGeneral", { fg = "#569CD6", bold = true })
        set_hl(0, "GCodeMovement", { fg = "#E06C75", bold = true })
        set_hl(0, "GCodeMachine", { fg = "#D19A66", bold = true })
        set_hl(0, "GCodeTool", { fg = "#C678DD", bold = true })
        set_hl(0, "GCodeAxis", { fg = "#98C379", bold = true })
        set_hl(0, "GCodeFSpeed", { fg = "#E06C75", bold = true })
        set_hl(0, "GCodeSSpeed", { fg = "#56B6C2", bold = true })
        set_hl(0, "GCodeLine", { fg = "#ABB2BF" })
        set_hl(0, "GCodeCycle", { fg = "#E0E050" })
        set_hl(0, "GCodeComment", { fg = "#5C6370", italic = true })
        set_hl(0, "GCodeName", { fg = "#A030A0", italic = true })

        vim.fn.matchadd("GCodeGeneral", "\\v[Gg]\\d+(\\.\\d+)?")
        vim.fn.matchadd("GCodeMovement", "\\v[Gg]0{1,2}")
        vim.fn.matchadd("GCodeMachine", "\\v[Mm]\\d+(\\.\\d+)?")
        vim.fn.matchadd("GCodeTool", "\\v[Tt]\\d+(\\.\\d+)?")
	vim.fn.matchadd("GCodeAxis", "\\v[XxYyZzAaBbCc][-+]?\\d+(\\.\\d+)?")
	vim.fn.matchadd("GCodeFSpeed", "\\v[Ff]\\d+(\\.\\d+)?")
	vim.fn.matchadd("GCodeSSpeed", "\\v[Ss]\\d+(\\.\\d+)?")
        vim.fn.matchadd("GCodeLine", "\\v[Nn]\\d+(\\.\\d+)?")
        vim.fn.matchadd("GCodeCycle", "\\v[RrQq]\\d+(\\.\\d+)?")
        vim.fn.matchadd("GCodeComment", ";.*$")
        vim.fn.matchadd("GCodeName", "%.*$")
    end
})

