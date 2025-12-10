SMODS.Joker {
    key = "sun",

    config = { extra = { lifecycle = {
        "e_arcs_warm",
        "e_arcs_hot",
        "e_arcs_toasted",
    } } },

    cost = 15,
    rarity = "arcs_celestial",
    blueprint_compat = true,

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
}

SMODS.Joker {
    key = "pulsar",

    config = {
        stored_mult = 0,
        gain_per_hand = 1,
        charge_threshold = 5,
        mult_bonus = 50
    },

    cost = 12,
    rarity = "arcs_celestial",
    blueprint_compat = true,

    atlas = 'CustomJokers',
    pos = {x=7, y=0},
    pools = { ["arcs_arcs_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.stored_mult or 0,
                card.ability.charge_threshold or 5,
                card.ability.gain_per_hand or 1,
                card.ability.mult_bonus or 50
            }
        }
    end,

    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            card.ability.stored_mult = card.ability.stored_mult + card.ability.gain_per_hand
            
            if card.ability.stored_mult < card.ability.charge_threshold then
                return {
                    message = "Charging... ",
                    colour = G.C.MULT
                }
            else
                return {
                    message = "Charged!",
                    colour = G.C.GREEN
                }
            end
        end
        
        if context.joker_main then
            if card.ability.stored_mult >= card.ability.charge_threshold then
                card.ability.stored_mult = 0
                
                return {
                    message = "+"..card.ability.mult_bonus.." Mult",
                    colour = G.C.MULT,
                    mult_mod = card.ability.mult_bonus
                }
            end
        end
    end,
}

SMODS.Joker {
    key = "blackhole",

    config = { extra = { odds = 6 } },
    rarity = "arcs_celestial",
    atlas = 'CustomJokers',
    pos = { x = 8, y = 0 },
        pools = { ["arcs_arcs_jokers"] = true },

    cost = 12,
    blueprint_compat = false,
    
    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.probabilities.normal or 1, card.ability.extra.odds } }
    end,
    
    calculate = function(self, card, context)
        if context.setting_blind and not card.getting_sliced and not context.blueprint then
            if pseudorandom('negative_chance') < G.GAME.probabilities.normal / card.ability.extra.odds then
                local eligible_jokers = {}
                for i = 1, #G.jokers.cards do
                    local joker = G.jokers.cards[i]
                    if joker ~= card and not joker.edition then
                        table.insert(eligible_jokers, joker)
                    end
                end
                
                if #eligible_jokers > 0 then
                    local target = pseudorandom_element(eligible_jokers, pseudoseed('negative_target'))
                    
                    target:set_edition({negative = true}, true)
                    
                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = localize('k_negative'),
                        colour = G.C.DARK_EDITION
                    })
                    
                    return {
                        message = localize('k_negative'),
                        colour = G.C.DARK_EDITION,
                        card = card
                    }
                end
            end
        end
    end
}

SMODS.Joker({
    key = "moon",

    cost = 11,
    rarity = "arcs_celestial",
    blueprint_compat = true,

    atlas = 'CustomJokers',
    pos = {x = 9, y = 0},
    pools = { ["arcs_arcs_jokers"] = true },

    calculate = function(self, card, context)
       if context.before then
            for i, v in ipairs(context.scoring_hand) do
                if v.base.suit == "Spades" and not v.ability.moonGiven then
                    v:set_edition("e_arcs_moon")
                    v.ability.moonGiven = true
                    
                    card:juice_up()
                    v:juice_up()
                    
                    return
                end
            end
        end
    end
})