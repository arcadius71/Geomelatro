SMODS.Shader({ key = 'bioluminescent', path = 'bioluminescent.fs' })

SMODS.Edition {
    key = "bio",
    shader = 'bioluminescent',
    loc_txt = {
        name = 'Bioluminescent',
        label = 'Bioluminescent',
        text = {
            '{C:white,X:mult}X3{} Mult',
        }
    },
    config = { x_mult = 3 },
    in_shop = true,
    weight = 2,
    extra_cost = 5,
    sound = { sound = "polychrome1", per = 1.2, vol = 0.7 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.edition.x_mult } }
    end,
    get_weight = function(self)
        return (G.GAME.edition_rate - 1) * G.P_CENTERS["e_negative"].weight + G.GAME.edition_rate * self.weight
    end,
    calculate = function(self, card, context)
        if context.post_joker or (context.main_scoring and context.cardarea == G.play) then
            return {
                x_mult = card.edition.x_mult
            }
        end
    end
}