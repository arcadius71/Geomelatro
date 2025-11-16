SMODS.Joker {
    key = "pi",
    pos = {x=2, y=0},
    
    config = { extra = { Chance = 3.141 } },
	loc_vars = function(self, info_queue, card)
		return { vars = {G.GAME.probabilities.normal, card.ability.extra.Chance}}
	end,

    cost = 6, -- :trol:
    rarity = 3,
    blueprint_compat = true,
    
    atlas = 'CustomJokers',
    pools = { ["arcs_arcs_jokers"] = true },

    calculate = function(self, card, context)
       if context.setting_blind and SMODS.pseudorandom_probability(card, 'piChance', G.GAME.probabilities.normal, card.ability.extra.Chance, 'identifier') then -- at the end
            if #G.jokers.cards + G.GAME.joker_buffer + 1 > G.jokers.config.card_limit then return end -- if theres too many already, 
            G.GAME.joker_buffer = G.GAME.joker_buffer + 1 -- make it so its prepared ig

                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card({ set = "arcs_arcs_jokers" }) -- create
                        G.GAME.joker_buffer = G.GAME.joker_buffer - 1 -- remove anything left
                        return true
                    end
                }))
        end
    end
}