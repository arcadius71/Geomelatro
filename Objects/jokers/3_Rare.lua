SMODS.Joker{ --Overgrowth
    key = "overgrowth",
    pos = {x=0, y=0},

    cost = 12,
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

SMODS.Joker {
    key = "pi",
    pos = {x=2, y=0},
    
    config = { extra = { Chance = 3.141 } },
	loc_vars = function(self, info_queue, card)
		return { vars = {G.GAME.probabilities.normal, card.ability.extra.Chance}}
	end,

    cost = 10, -- :trol:
    rarity = 3,
    blueprint_compat = true,
    
    atlas = 'CustomJokers',
    pools = { ["arcs_arcs_jokers"] = true },

    calculate = function(self, card, context)
       if context.setting_blind and SMODS.pseudorandom_probability(card, 'piChance', G.GAME.probabilities.normal, card.ability.extra.Chance, 'identifier') then -- at the end
            if #G.jokers.cards + G.GAME.joker_buffer + 1 > G.jokers.config.card_limit then return end -- if theres too many already, 
            G.GAME.joker_buffer = G.GAME.joker_buffer + 1 -- make it so its prepared ig

                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card({ set = "arcs_arcs_jokers" }) -- create
                        G.GAME.joker_buffer = G.GAME.joker_buffer - 1 -- remove anything left
                        return true
                    end
                }))
        end
    end
}

SMODS.Joker {
    key = "triangle",
    pos = {x=3, y=0}, -- why is it on default joker spritesheet

    cost = 9, -- :trol:
    rarity = 3,
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

            local area = (base*height) / 2

            return {
                xmult = area
            }
        end
    end
}

SMODS.Joker { --Jellyfish
    key = "jellyfish",
    pos = {x=5, y=0},

    cost = 8,
    rarity = 3,
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