SMODS.Voucher {
    key = "homework",
    atlas = "vouchers",
    pos = {x=0,y=0},

    redeem = function(self, voucher)
        if not G.GAME.GradeMult then
            G.GAME.GradeMult = 0
        end

        G.GAME.GradeMult = G.GAME.GradeMult + 1.5
    end
}

SMODS.Voucher {
    key = "scholar",
    atlas = "vouchers",
    pos = {x=1,y=0},

    requires = {'v_arcs_homework'},

    redeem = function(self, voucher)
        for _, tbl in pairs(G.Arcs.GradeReq) do
            tbl.hands = tbl.hands + 1
            tbl.discards = tbl.discards + 1
		    tbl.score = tbl.score - 0.5
        end
    end
}