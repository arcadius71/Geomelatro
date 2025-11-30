SMODS.Joker {
    key = "eulers",
    loc_txt = {
        name = "Euler's Number",
        text = {
            "Gains {C:mult}+0.1{} Mult",
            "every hand played",
            "{C:inactive}(Currently {C:inactive}+#1# Mult){}"
        }
    },
    config = { extra = { mult = 0 } },
    pos = {x = 0, y = 1},
    cost = 10,
    rarity = 2,
    blueprint_compat = true,
    atlas = 'CustomJokers',
    pools = { ["arcs_arcs_jokers"] = true },
    unlocked = true,
    discovered = true,
    
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                mult_mod = card.ability.extra.mult
            }
        end
        
        if context.after and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + 0.1
            return {}
        end
    end
}