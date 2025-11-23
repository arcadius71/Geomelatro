SMODS.Joker {
    key = "sun",
    pos = {x=6, y=0}, -- why is it on default joker spritesheet

    config = { extra = { lifecycle = {
        "e_arcs_warm",
        "e_arcs_hot",
        "e_arcs_toasted",
        "e_arcs_burnt",
        "e_arcs_charcoal",
        "e_arcs_ash",
    } } },

    cost = 20, -- :trol:
    rarity = 4,
    blueprint_compat = false,
    
    atlas = 'CustomJokers',
    pools = { ["arcs_arcs_jokers"] = true },

    calculate = function(self, card, context)
       if context.before then -- at the end
            -- calc (short for calculate) base and height
            for i, v in ipairs(G.play.cards) do
                if v.base.suit == "Hearts" then
                    v.ability.sunCycle = (v.ability.sunCycle or 1) + 1
                    v:set_edition(card.ability.extra.lifecycle[v.ability.sunCycle])

                    card:juice_up()

                    return -- very important, if not return all cards will upgrade
                end
            end
        end
    end
}