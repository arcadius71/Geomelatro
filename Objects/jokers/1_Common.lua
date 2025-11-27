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
    config = { extra = { mult = 5, positive = true } },
    rarity = 2,
    cost = 3,
    blueprint_compat = true,
    pos = { x = 1, y = 1 },
    atlas = 'CustomJokers',
    pools = { ["arcs_arcs_jokers"] = true },
    
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            if card.ability.extra.positive then
                return {
                    message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                    mult_mod = card.ability.extra.mult
                }
            else
                return {
                    message = localize { type = 'variable', key = 'a_mult', vars = { -card.ability.extra.mult } },
                    mult_mod = -card.ability.extra.mult
                }
            end
        end
        
        if context.after and not context.blueprint then
            card.ability.extra.positive = not card.ability.extra.positive
            
            if card.ability.extra.positive then
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = "Next: +" .. card.ability.extra.mult,
                    colour = G.C.MULT
                })
            else
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = "Next: -" .. card.ability.extra.mult,
                    colour = G.C.RED
                })
            end
            
            return nil
        end
    end
}