SMODS.Back{
    name = "Deep Sea Deck",
    key = "deepseaback",
    atlas = "backs",
    pos = {x = 0, y = 0},
    config = {bio_cards = true, scaling = 10},
    loc_txt = {
        name = "Deep Sea Deck",
        text = {
            "Start with a Deck",
            "full of {C:dark_edition}Bioluminescent{} cards."
        },
    },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                for i = #G.playing_cards, 1, -1 do
                    G.playing_cards[i]:set_edition({
                        arcs_bio = true
                    }, true, true)
                end

                G.GAME.modifiers.scaling = self.config.scaling
                
                return true
            end
        }))
    end
}