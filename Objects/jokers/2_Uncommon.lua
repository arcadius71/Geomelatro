SMODS.Joker { --Jellyfish
    key = "jellyfish",
    pos = {x=5, y=0},
    config = { extra = { repetitions = 1 } },

    cost = 3,
    rarity = 2,
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