local awful = require('awful')




local function create(screen)
    local taglist = awful.widget.taglist {
        screen = screen,
        filter = awful.widget.taglist.filter.all,
    }



    



    return taglist
end



return create
