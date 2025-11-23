SMODS.Rarity {
    key = "celestial",
    pools = {
        ["Joker"] = true
    },
    default_weight = 0.005,
    badge_colour = SMODS.Gradient({
        key = "celestialgrad",
        colours = {
        HEX("#ff7829ff"),
        HEX("#ffb555ff"),
        HEX("#EBF5EE"),
        },
        cycle = 20
    }),
    loc_txt = {
        name = "Celestial"
    },
    get_weight = function(self, weight, object_type)
        return weight
    end,
}