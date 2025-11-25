SMODS.Shader({ key = 'bioluminescent', path = 'bioluminescent.fs' })
SMODS.Edition {
    key = "bio",
    shader = 'bioluminescent',

    loc_txt = {
        name = 'Bioluminescent',
        label = 'Bioluminescent',
        text = {
            '{X:mult,C:white}x3{} Mult',
        },
    },
    
    config = { xmult = 3 },
    in_shop = true,
    weight = 8,
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

Warm = +15 mult
Hot  = +75 chips
Toasted = +10 mult

]]

SMODS.Shader({ key = 'warmsh', path = 'Heat/warmsh.fs' })
SMODS.Shader({ key = 'hotsh', path = 'Heat/hotsh.fs' })
SMODS.Shader({ key = 'toastedsh', path = 'Heat/toastedsh.fs' })


SMODS.Edition {
    key = "warm",
    shader = 'warmsh',

    loc_txt = {
        name = "Hot",
        label = "Hot",
        text = {
            [1] = '{X:mult,C:white}+15{} Mult'
        }
    },
    
    config = { mult = 15, WarmWeight = 1.5},
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
    key = "hot",
    shader = 'hotsh',

        loc_txt = {
        name = "Boiling",
        label = "Boiling",
        text = {
            [1] = '{X:mult,C:white}+50{} Mult'
        }
    },
    
    config = { mult = 50,},
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
    key = "toasted",
    shader = 'toastedsh',

            loc_txt = {
        name = "Scalding",
        label = "Scalding",
        text = {
            [1] = '{X:mult,C:white}X5{} Mult'
        }
    },
    
    config = { xmult = 5 },
    in_shop = false,
    weight = 0,
    extra_cost = 5,
    sound = { sound = "polychrome1", per = 1.2, vol = 0.7 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.edition.xmult } }
    end,
    get_weight = function(self)
        return 0 --(G.GAME.edition_rate - 1) * G.P_CENTERS["e_negative"].weight + G.GAME.edition_rate * self.weight
    end,
    calculate = function(self, card, context)
        if context.post_joker or (context.main_scoring and context.cardarea == G.play) then
            return {
                xmult = card.edition.xmult
            }
        end
    end
}