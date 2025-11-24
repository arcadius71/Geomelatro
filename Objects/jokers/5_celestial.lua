SMODS.Joker({
    key = "sun",

    config = { extra = { lifecycle = {
        "e_arcs_warm",
        "e_arcs_hot",
        "e_arcs_toasted",
        "e_arcs_burnt",
        "e_arcs_charcoal",
        "e_arcs_ash",
    } } },

    cost = 11,
    rarity = "arcs_celestial",
    blueprint_compat = false,

    atlas = 'CustomJokers',
    pos = {x=6, y=0},
    pools = { ["arcs_arcs_jokers"] = true },

    calculate = function(self, card, context)
       if context.before then -- at the end
            -- calc (short for calculate) base and height
            for i, v in ipairs(context.scoring_hand) do
                if v.base.suit == "Hearts" then
                    local cycles = card.ability.extra.lifecycle

                    v.ability.sunCycle = (v.ability.sunCycle or 0) + 1
                    if v.ability.sunCycle > #cycles then
                        v.ability.sunCycle = #cycles
                    end
                    v:set_edition(cycles[v.ability.sunCycle])

                    card:juice_up()
                    v:juice_up()

                    return -- very important, if not return all cards will upgrade
                end
            end
        end
    end
})