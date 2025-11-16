SMODS.Joker {
    key = "rectangle",
    --pos = {x=3, y=0},

    cost = 4, -- :trol:
    rarity = 1,
    blueprint_compat = true,
    
    -- atlas = 'CustomJokers',
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