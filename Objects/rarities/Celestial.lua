SMODS.Gradient({
    key = "arcs_celestialgrad",
    colours = {
        HEX("ebf5ee"),
        HEX("ff7829"),
        HEX("ffb555")
    },
    cycle = 50
})

SMODS.Rarity {
    key = "celestial",
    loc_txt = {
        name = "Celestial"
    },

    pools = {
        ["Joker"] = true
    },
    default_weight = 0.005,
    badge_colour = SMODS.Gradient["arcs_celestialgrad"],
    get_weight = function(self, weight, object_type)
        return weight
    end,
}