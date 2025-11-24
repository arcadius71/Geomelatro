SMODS.Rarity {
    key = "celestial",
    pools = {
        ["Joker"] = true
    },
    default_weight = 0.015,
    badge_colour = SMODS.Gradient({
        key = "celestialgrad",
        colours = {
        HEX("ebf5ee"),
        HEX("ff7829"),
        HEX("ffb555"),
        },
        cycle = 15
    }),
    loc_txt = {
        name = "Celestial"
    },
    get_weight = function(self, weight, object_type)
        return weight
    end,
}