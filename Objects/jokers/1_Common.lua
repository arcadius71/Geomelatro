SMODS.Joker {
    key = "rectangle",
    pos = {x=4, y=0},

    cost = 4, -- :trol:
    rarity = 1,
    blueprint_compat = true,
    
    atlas = 'CustomJokers',
    pools = { ["arcs_arcs_jokers"] = true },

    set_badges = function(_, _, badges)
        badges[#badges+1] = create_badge("Area", G.C.GREEN)
    end,

    calculate = function(self, card, context)
       if context.joker_main then -- at the end
            -- calc (short for calculate) base and height
            local base = G.jokers.cards[1].sell_cost
            local height = G.jokers.cards[#G.jokers.cards].sell_cost

            local area = base * height

            return {
                mult = area
            }
        end
    end
}

SMODS.Joker { --Trigger-Nometry
    key = "triggernometry",
    pos = {x=1, y=0},
    config = { extra = { repetitions = 1 } },

    cost = 3,
    rarity = 1,
    blueprint_compat = true,

    atlas = 'CustomJokers',
    pools = { ["arcs_arcs_jokers"] = true },

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 14 or
                context.other_card:get_id() == 3 or
                context.other_card:get_id() == 4 then
                return {
                message = localize('k_again_ex'),
                repetitions = card.ability.extra.repetitions,
                card = card
                }
            end
        end
    end
}

SMODS.Joker {
    key = 'sine',
    loc_txt = {
        name = 'Sine Wave',
        text = {
            'Alternates between',
            '{C:mult}+#1#{} Mult and',
            '{C:mult}-#1#{} Mult',
            'each hand played'
        }
    },
    config = { extra = { mult = 10, positive = true } },
    rarity = 1,
    cost = 3,
    blueprint_compat = true,
    pos = { x = 1, y = 1 },
    atlas = 'CustomJokers',
    pools = { ["arcs_arcs_jokers"] = true },
    
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    
    calculate = function(self, card, context)
        local config = card.ability.extra
        if context.joker_main then
            return {
                mult = config.positive and config.mult or -config.mult
            }
        end
        
        if context.after and not context.blueprint then
            config.positive = not config.positive

            return {
                message = "Next: ".. config.positive and "+".. config.mult or "-".. config.mult
            }
        end
    end
}