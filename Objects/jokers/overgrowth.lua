SMODS.Joker{ --Overgrowth
    key = "overgrowth",
    pos = {x=0, y=0},

    cost = 7,
    rarity = 3,
    blueprint_compat = true,

    atlas = 'CustomJokers',
    pools = { ["arcs_arcs_jokers"] = true },

    calculate = function(self, card, context)
        if context.first_hand_drawn and not context.blueprint then
            local eval = function() return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
        
        if context.before and G.GAME.current_round.hands_played == 0 and #context.full_hand == 5 then
            for i = 1, #context.full_hand do
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                local card_copied = SMODS.create_card({
                    set = "Playing Card",
                    rank = context.full_hand[i].base.value,
                    suit = context.full_hand[i].base.suit,
                    no_edition = true,
                    no_enhancement = true,
                })
                card_copied:add_to_deck()
                G.deck.config.card_limit = G.deck.config.card_limit + 1
                table.insert(G.playing_cards, card_copied)
                G.deck:emplace(card_copied)
            end
            
            return {
                message = "Copied!",
                colour = G.C.CHIPS,
            }
        end
    end,
}