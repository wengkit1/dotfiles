return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      preset = {
        header = [[
                        ░░░░░░░░░░░              Z     
                     ░███████████████░         z       
                 ░░███░░░         ░░░███░       z      
                ░███░                ░░███    z        
               ░██░                     ░██░           
              ███░ ░█████     ░████░     ░██░          
             ░██░                         ███          
             ███         ░█               ░██░         
            ░██░                           ██░         
          ░░███░                           ███         
        ░░█████░             ░░░           ██░         
        ███                 ░██░     ░░   ░██░         
       ░██░                 ░██░   ░░██░  ░██░         
        ░███████░            ░███████░    ░██░         
         ░░░██░██░              ░░░       ░██░         
               ░███░                       ░██░        
                 ░░███░░                    ███░░      
                   ░░████████░░░░░░░░░░░██████████░░   
                        ░░░░░█████████████░░░          ]],
      },
      sections = {
        {
          section = "header",
          padding = 1,
        },
        {
          pane = 1,
          section = "keys",
          gap = 1,
          padding = 1,
        },
        {
          section = "startup",
          pane = 2,
          padding = 5,
        },
        {
          pane = 2,
          section = "recent_files",
          title = "Recent Files",
          padding = 5,
          limit = 5,
          gap = 1,
          indent = 2,
          format = function(item, ctx)
            return {
              { "●", hl = "SnacksDashboardIcon" },
              { " " .. vim.fn.fnamemodify(item.file, ":t"), hl = "SnacksDashboardDesc" },
              { " [" .. ctx.pos .. "]", hl = "SnacksDashboardKey" },
            }
          end,
        },
        {
          pane = 2,
          section = "projects",
          title = "Projects",
          padding = 1,
          limit = 3,
          gap = 1,
          indent = 2,
          format = function(item, ctx)
            return {
              { "📁", hl = "SnacksDashboardIcon" },
              { " " .. vim.fn.fnamemodify(item.file, ":t"), hl = "SnacksDashboardDesc" },
              { " [" .. (ctx.pos + 5) .. "]", hl = "SnacksDashboardKey" },
            }
          end,
        },
      },
    },
  },
}
