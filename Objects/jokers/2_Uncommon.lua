SMODS.Joker { --Jellyfish
    key = "jellyfish",
    pos = {x=5, y=0},

    cost = 3,
    rarity = 2,
    blueprint_compat = true,

    atlas = 'CustomJokers',
    pools = { ["arcs_arcs_jokers"] = true },

    calculate = function(_, _, context)
        if context.before then
            if #G.play.cards == 2 then
                local EffectedCard = G.play.cards[1]
                EffectedCard:set_edition("e_arcs_bio", true)
            end
        end
    end
}