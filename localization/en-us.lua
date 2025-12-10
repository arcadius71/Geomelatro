return {
    descriptions = {
        Back = {},
        Blind = {},
        Enhanced = {},
        Joker = {
        -- common
            j_arcs_rectangle = {
                name = 'Rectangle',
                text = {
                    "Area of a square is {C:mult}B × H",
                    "Left most {C:attention}joker's{} price is {E:1}base",
                    "Right most {C:attention}joker's{} price is {E:1}height",
                },
            },
            j_arcs_triggernometry = {
                name = 'Trigger-Nometry',
                text = {
                    "Retrigger played {C:attention}3's",
                    "{C:attention}Aces'{}, and {C:attention}4's"
                },
            },
            j_arcs_sine = {
                name = 'Sine Wave',
                text = {
                    'Alternates between',
                    '{C:mult}+#1#{} Mult and',
                    '{C:mult}-#1#{} Mult',
                    'each hand played'
                }
            },
        -- uncommon
            j_arcs_eulers = {
                name = "Euler's Number",
                text = {
                    "Gains {C:mult}+0.1{} Mult",
                    "for every played card",
                    "{C:inactive}(Currently {C:inactive}+#1# Mult){}"
                }
            },
        -- rare
            j_arcs_overgrowth = {
                name = 'Overgrowth',
                text = {
                    "If {C:attention}first hand{} of round",
                    "has {C:attention}5{} cards",
                    "copy them to the deck."
                },
            },
            j_arcs_pi = {
                name = 'Pi',
                text = {
                    "at the beginning of a blind",
                    "{C:green}#1# in #2#{} chance to spawn a",
                    "Geomelatro Joker"
                },
            },
            j_arcs_triangle = {
                name = 'Triangle',
                text = {
                    "Area of a triangle is {C:white,X:mult}(B × H) ÷ 2",
                    "Left most {C:attention}joker's{} price is {E:1}base",
                    "Right most {C:attention}joker's{} price is {E:1}height",
                },
            },
            j_arcs_jellyfish = {
                name = 'Jellyfish',
                text = {
                    "If {C:attention}first played hand{} contains",
                    "{C:attention}2{} cards then give first card",
                    "{E:1, C:dark_edition}Bioluminescent{}.",
                },
            },
        -- celestial
            j_arcs_sun = {
                name = 'Sun',
                text = {
                    "First played {C:heart}Heart{} card",
                    "Scales {E:1,C:dark_edition}Heat{}.",
                },
            },
            j_arcs_pulsar = {
                name = 'Pulsar',
                text = {
                    "Every {C:attention}3rd hand{} played",
                    "gains {C:mult}+0.5{} Mult.",
                },
            },
            j_arcs_blackhole = {
                name = 'Black Hole',
                text = {
                    '{C:green}1 in #6#{} chance to',
                    'make a random {C:attention}Joker',
                    '{C:dark_edition}Negative{} at the',
                    'start of each blind.'
                }
            },
            j_arcs_moon = {
                name = 'The Moon',
                text = {
                    "First played {C:spades}Spade",
                    "card turns {C:dark_edition}Moonlit{}."
                }
            }
        },
        Other = {},
        Planet = {},
        Spectral = {},
        Stake = {},
        Tag = {},
        Tarot = {},
        Voucher = {
            v_arcs_homework = {
                name = "Homework",
                text = {"{C:attention}Better{} odds for", "Better pre-shop {C:attention}Prizes"}
            },
            v_arcs_scholar = {
                name = "Scholarship",
                text = {"{C:attention}Easier{} to get", "Better {C:attention}grades"}
            }
        },
    },
    misc = {
        achievement_descriptions = {},
        achievement_names = {},
        blind_states = {},
        challenge_names = {},
        collabs = {},
        dictionary = {},
        high_scores = {},
        labels = {},
        poker_hand_descriptions = {},
        poker_hands = {},
        quips = {},
        ranks = {},
        suits_plural = {},
        suits_singular = {},
        tutorial = {},
        v_dictionary = {},
        v_text = {},
    },
}



