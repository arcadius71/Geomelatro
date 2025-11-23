SMODS.Back {
    key = "quasarback",
    name = "Quasar Deck",
    
    atlas = "backatlas",
    pos = { x = 0, y = 0 },
    config = { card = "j_arcs_sun"},
	loc_vars = function(self, info_queue, cad)
		return {}
	end,
    apply = function(self, back)
        -- Apply the consumables
        delay(0.4)
        G.E_MANAGER:add_event(Event({
            func = function()
                SMODS.add_card({ key = self.config.card, stickers = {'eternal'}, force_stickers = true })
                return true
            end
        }))
    end,
}