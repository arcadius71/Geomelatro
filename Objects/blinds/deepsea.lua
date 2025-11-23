SMODS.Back{
    name = "Deep Sea Deck",
    key = "deepsea",
    pos = {x = 0, y = 0},
    config = {polyglass = true},
    loc_txt = {
        name = "Absolute Deck",
        text ={
            "Start with a Deck",
            "full of {C:cards"
        },
    },
    apply = function()
        G.E_MANAGER:add_event(Event({
            func = function()
                for i = #G.playing_cards, 1, -1 do
                    G.playing_cards[i]:set_edition({
                        bioluminescent = true
                    }, true, true)
                end
                return true
            end
        }))
    end
}