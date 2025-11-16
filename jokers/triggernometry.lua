SMODS.Joker{ --Trigger-Nometry
    key = "triggernometry",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Trigger-Nometry',
        ['text'] = {
            [1] = 'Retrigger played {C:attention}3\'s{},',
            [2] = '{C:attention}Aces\'{}, and {C:attention}4\'s{}.'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 3,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["arcs_arcs_jokers"] = true },
        config = { extra = { repetitions = 1 } },
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