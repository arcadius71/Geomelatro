SMODS.Shader({ key = 'bioluminescent', path = 'bioluminescent.fs' })
SMODS.Edition {
    key = "bio",
    shader = 'bioluminescent',
    
    config = { xmult = 3 },
    in_shop = true,
    weight = 2,
    extra_cost = 5,
    sound = { sound = "polychrome1", per = 1.2, vol = 0.7 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.edition.xmult } }
    end,
    get_weight = function(self)
        return (G.GAME.edition_rate - 1) * G.P_CENTERS["e_negative"].weight + G.GAME.edition_rate * self.weight
    end,
    calculate = function(self, card, context)
        if context.post_joker or (context.main_scoring and context.cardarea == G.play) then
            return {
                xmult = card.edition.xmult
            }
        end
    end
}

-- Heat levels

--[[

Warm = +25 chips
Hot  = +75 chips
Toasted = +100 chips
Burnt = +10 mult
Charcoal = +20 mult
Ash = x1.5 mult
somethingelse = x2.5 mult

]]
SMODS.Shader({ key = 'warmsh', path = 'Heat/warmsh.fs' })
SMODS.Shader({ key = 'toastedsh', path = 'Heat/toastedsh.fs' })


SMODS.Edition {
    key = "warm",
    shader = 'warmsh',
    
    config = { chips = 3, WarmWeight = 1.5},
    in_shop = true,
    weight = 2,
    extra_cost = 5,
    sound = { sound = "polychrome1", per = 1.2, vol = 0.7 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.edition.chips } }
    end,
    get_weight = function(self)
        return (G.GAME.edition_rate - 1) * self.ability.WarmWeight + G.GAME.edition_rate * self.weight
    end,
    calculate = function(self, card, context)
        if context.post_joker or (context.main_scoring and context.cardarea == G.play) then
            return {
                chips = card.edition.chips
            }
        end
    end
}

SMODS.Edition {
    key = "toasted",
    shader = 'toastedsh',
    
    config = { chips = 100 },
    in_shop = true,
    weight = 2,
    extra_cost = 5,
    sound = { sound = "polychrome1", per = 1.2, vol = 0.7 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.edition.x_mult } }
    end,
    get_weight = function(self)
        return 0 --(G.GAME.edition_rate - 1) * G.P_CENTERS["e_negative"].weight + G.GAME.edition_rate * self.weight
    end,
    calculate = function(self, card, context)
        if context.post_joker or (context.main_scoring and context.cardarea == G.play) then
            return {
                chips = card.edition.chips
            }
        end
    end
}