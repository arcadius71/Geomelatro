SMODS.Joker {
    key = "eulers",
    
    config = { extra = { mult = 0 } },
    pos = {x = 0, y = 1},
    cost = 10,
    rarity = 2,
    blueprint_compat = true,
    atlas = 'CustomJokers',
    pools = { ["arcs_arcs_jokers"] = true },
    discovered = true,
    
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + 0.1
        elseif context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
        
    end
}