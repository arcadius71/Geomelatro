SMODS.Back {
    key = "quasarback",
    name = "Quasar Deck",

    loc_txt = {
        name = "Quasar Deck",
        text = {"Starts with an", "{C:enhanced}Eternal{} Sun."},
    },

    atlas = "backs",
    pos = { x = 1, y = 0 },
    config = { card = "j_arcs_sun"},
    loc_vars = function(self, info_queue, cad)
        return {}
    end,
    apply = function(self, back)
        -- Apply the consumables
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                if G.jokers then
                    local card = create_card('Joker', G.jokers, nil, nil, nil, nil, self.config.card)
                    card:add_to_deck()
                    G.jokers:emplace(card)
                    card:set_eternal(true)
                end
                return true
            end
        }))
    end,
}