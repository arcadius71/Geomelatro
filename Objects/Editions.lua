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
Toasted = +10 mult
Burnt = +25 mult
Charcoal = x2 mult
Ash = x4 mult

]]
SMODS.Shader({ key = 'warmsh', path = 'Heat/warmsh.fs' })
SMODS.Shader({ key = 'toastedsh', path = 'Heat/toastedsh.fs' })


SMODS.Edition {
    key = "warm",
    shader = 'warmsh',
    
    config = { chips = 25, WarmWeight = 1.5},
    in_shop = false,
    weight = 0,
    extra_cost = 5,
    sound = { sound = "polychrome1", per = 1.2, vol = 0.7 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.edition.chips } }
    end,
    get_weight = function(self)
        return 0
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
    key = "hot",
    shader = 'warmsh',
    
    config = { chips = 75,},
    in_shop = false,
    weight = 0,
    extra_cost = 5,
    sound = { sound = "polychrome1", per = 1.2, vol = 0.7 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.edition.chips } }
    end,
    get_weight = function(self)
        return 0
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
    
    config = { mult = 10 },
    in_shop = false,
    weight = 0,
    extra_cost = 5,
    sound = { sound = "polychrome1", per = 1.2, vol = 0.7 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.edition.mult } }
    end,
    get_weight = function(self)
        return 0 --(G.GAME.edition_rate - 1) * G.P_CENTERS["e_negative"].weight + G.GAME.edition_rate * self.weight
    end,
    calculate = function(self, card, context)
        if context.post_joker or (context.main_scoring and context.cardarea == G.play) then
            return {
                mult = card.edition.mult
            }
        end
    end
}

SMODS.Edition {
    key = "burnt",
    shader = 'warmsh',
    
    config = { mult = 25},
    in_shop = false,
    weight = 0,
    extra_cost = 5,
    sound = { sound = "polychrome1", per = 1.2, vol = 0.7 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.edition.mult } }
    end,
    get_weight = function(self)
        return 0
    end,
    calculate = function(self, card, context)
        if context.post_joker or (context.main_scoring and context.cardarea == G.play) then
            return {
                mult = card.edition.mult
            }
        end
    end
}

SMODS.Edition {
    key = "charcoal",
    shader = 'warmsh',
    
    config = { xmult = 2 },
    in_shop = false,
    weight = 0,
    extra_cost = 5,
    sound = { sound = "polychrome1", per = 1.2, vol = 0.7 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.edition.xmult } }
    end,
    get_weight = function(self)
        return 0
    end,
    calculate = function(self, card, context)
        if context.post_joker or (context.main_scoring and context.cardarea == G.play) then
            return {
                xmult = card.edition.xmult
            }
        end
    end
}

SMODS.Edition {
    key = "ash",
    shader = 'warmsh',
    
    config = { xmult = 4 },
    in_shop = false,
    weight = 0,
    extra_cost = 5,
    sound = { sound = "polychrome1", per = 1.2, vol = 0.7 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.edition.chips } }
    end,
    get_weight = function(self)
        return 0
    end,
    calculate = function(self, card, context)
        if context.post_joker or (context.main_scoring and context.cardarea == G.play) then
            return {
                xmult = card.edition.xmult
            }
        end
    end
}