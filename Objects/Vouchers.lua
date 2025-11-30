SMODS.Voucher {
    key = "homework",
    -- atlas = "",
    -- pos = {x=0,y=0},

    redeem = function(self, voucher)
        G.GAME.GradeMult = (G.GAME.GradeMult or 0) + 1.5
    end
}

SMODS.Voucher {
    key = "scholar",
    -- atlas = "",
    -- pos = {x=1,y=0},

    redeem = function(self, voucher)
        for _, tbl in pairs(G.Arcs.GradeReq) do
            tbl.hands = tbl.hands + 1
            tbl.discards = tbl.discards + 1
		    tbl.score = tbl.score - 0.5
        end
    end
}