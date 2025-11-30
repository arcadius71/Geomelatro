to_big = to_big or function(a) return a end
lenient_bignum = lenient_bignum or function(a) return a end

local geomelatro = SMODS.current_mod
G.Arcs = {}

-- Load Files and Folders

function geomelatro.Load_file(file) -- basically just SMODS.load_file() but safer, so i can accidentally have somethign break and it be chill
	local chunk = SMODS.load_file(file, "geomelatro")
	if chunk then
		local ok, func = pcall(chunk)
		if ok then
			print("Geomelatro | loaded ".. file)
			return func
		else
			print("Geomelatro | Failed on ".. file, " : ", func)
		end
	end
	return nil
end

function geomelatro.Load_Dir(directory)
	local files = NFS.getDirectoryItems(geomelatro.path .. "/" .. directory)
	local regular_files = {}

	for _, filename in ipairs(files) do -- iterate over all files in the directory
		local file_path = directory .. "/" .. filename
		if file_path:match(".lua$") then -- check if its lua
			if filename:match("^_") then -- i dont even know
				geomelatro.Load_file(file_path) -- load lua file
			else
				table.insert(regular_files, file_path) -- add non lua to other table
			end
		end
	end

	for _, file_path in ipairs(regular_files) do
		geomelatro.Load_file(file_path) -- load the other things
	end
end

geomelatro.Load_Dir("Objects")
geomelatro.Load_Dir("Objects/jokers")
geomelatro.Load_Dir("Objects/backs")
geomelatro.Load_Dir("Objects/rarities")



-- Grading stuff



	-- All requirements
G.Arcs.GradeReq = {
	{ -- requires custom code, so make it free n shit
		grade = "A++",

		met = true,
		score = {0},
		hands = 10,
		discards = 10,
		points = 6
	},
	{
		grade = "A+",

		met = true,
		score = 5,
		hands = 1,
		discards = 1,
		points = 4
	},
	{
		grade = "A",

		met = true,
		score = 2,
		hands = 1,
		discards = 2,
		points = 3
	},
	{
		grade = "B+",

		met = true,
		score = 2,
		hands = 2,
		discards = 3,
		points = 1.5
	},
	{
		grade = "B",

		met = true,
		score = 1.5,
		hands = 2,
		discards = 4,
		points = 1
	},
	{
		grade = "C+",

		met = true,
		score = 1.2,
		hands = 3,
		discards = 10,
		points = 0.5
	},
	{
		grade = "C",

		met = true,
		score = 1,
		hands = 3,
		discards = 10,
		points = 0
	},
	{
		grade = "F",

		met = true,
		score = 1,
		hands = 3,
		discards = 10,
		points = -1 -- I can do minus values since it automatically gets set to 1 if below 1
	},
	{
		grade = "F-",

		met = true,
		score = 0,
		hands = 3,
		discards = 10,
		points = -3 -- Bascially sets 1
	},
}
local GradeRewards = { -- Total == 1
	{ -- istg if I have to hard code this
		title = "Random Voucher",
		name = "R-vouch",
		weight = 0.05,
	},
	{
		title = "Random Pack",
		name = "R-pack",
		weight = 0.25,
	},
	{
		title = "Random Tag",
		name = "R-tag",
		weight = 0.2,
	},
	{
		title = "Random Joker",
		name = "R-joke",
		weight = 0.25,
	},
	{
		title = "Random Buff",
		name = "R-buff",
		weight = 0.25,
	},
}

	-- Function to check requirements

local function Grade() -- theres like 7 different "Grade" variables
	local discards = to_big(G.GAME.current_round.discards_used)
	local hands = to_big(G.GAME.current_round.hands_played)
	local required = to_big(G.GAME.blind.chips)
	local score = to_big(G.GAME.chips)
	local over = to_big(score / required)

	local hPoint = -4
	local gradetbl

	-- Check Score requirements
	for _, grade in ipairs(G.Arcs.GradeReq) do -- has to be ipairs since if its outta order A being before A+ would make A more priority than A+
		-- holy if statements | Def gonna want to beg balatro server to help me check if its good or not 😭
		if grade.grade == "A++" then
			-- custom stuff here
			-- -- else
			-- grade.met = false

			goto continue
		end

		if over < to_big(grade.score) then grade.met = false end

		if to_big(grade.hands) < hands then grade.met = false end
			-- fuck that we're doing it in one line

		if to_big(grade.discards) < discards then grade.met = false end

		if grade.met then
			if grade.points > hPoint then
				hPoint = grade.points
				gradetbl = grade
			end
			-- I found having them together broke it???? i still had the ()
		end
		grade.met = true
	    ::continue::
	end

	return gradetbl or G.Arcs.GradeReq[#G.Arcs.GradeReq] -- gives lowest grade
end

function RandReward()
	local score = G.GAME.Grades

-- set up copy
	local RewCopy = {}
	for i, v in pairs(GradeRewards) do
		if type(v) ~= "table" then
			RewCopy[i] = v
		else
			local table = {}
			for k, obj in pairs(v) do
				table[k] = obj -- will need another layer if i add some table in it
			end
			RewCopy[i] = table
		end
	end

-- Get the random
    local totalWeight = 0
	for i, reward in pairs(RewCopy) do
		print(reward)
		reward.weight = reward.weight ^ (score ^ -1)
		print(reward)
		-- say weight is 0.66 and score is 2.3, then its now 0.8347
        totalWeight = totalWeight + reward.weight
	end

    local randomNumber = math.random() * totalWeight

    local selectedIndex = nil
    for index, item in ipairs(RewCopy) do
		-- print(item)
        randomNumber = randomNumber - item.weight
        if randomNumber <= 0 then
            selectedIndex = index
            break
        end
    end

	return GradeRewards[selectedIndex]
end

geomelatro.calculate = function(self, context)
	if context.setting_blind then
		if G.GAME.Grades then
			G.GAME.Grades = math.floor(G.GAME.Grades / 4) < 1 and 1 or G.GAME.Grades / 4
		else
			G.GAME.Grades = 1
		end
	elseif context.end_of_round and not context.game_over and context.main_eval then
		local grading = Grade()
		G.GAME.Grades = G.GAME.Grades + grading.points * (G.GAME.GradeMult or 1)

		local reward = RandReward()
		G.GAME.LastGrade = grading
		G.GAME.LG_Reward = reward
		print(grading.grade)
		print("Awarding: ", reward)
		
		-- give hte award, for now its built in :(
			--- Majority from vremade btwwww
	elseif context.starting_shop then
		local reward = G.GAME.LG_Reward

		if reward.name == "R-vouch" then
			local voucher_pool = get_current_pool('Voucher')
			local selected_voucher = pseudorandom_element(voucher_pool, 'arcs_R_vouch')
			local it = 1
			while selected_voucher == 'UNAVAILABLE' do
				it = it + 1
				selected_voucher = pseudorandom_element(voucher_pool, 'arcs_seed' .. it)
			end
			local voucher_card = SMODS.create_card({ area = G.play, key = selected_voucher }) -- Ignore the previous code and just use a key for a prefined voucher
			voucher_card:start_materialize()
			voucher_card.cost = 0
			G.play:emplace(voucher_card)
			delay(0.8)
			voucher_card:redeem()

			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.5,
				func = function()
					voucher_card:start_dissolve()
					return true
				end
			}))
		elseif reward.name == "R-pack" then
			local lock = "R-pack-".. math.random()
			G.CONTROLLER.locks[lock] = true
			G.E_MANAGER:add_event(Event({
				func = function()
					local booster = SMODS.create_card { key = 'p_standard_mega_1', area = G.play }
					booster.T.x = G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2
					booster.T.y = G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2
					booster.T.w = G.CARD_W * 1.27
					booster.T.h = G.CARD_H * 1.27
					booster.cost = 0
					booster.from_tag = false

					G.FUNCS.use_card({ config = { ref_table = booster } })
					booster:start_materialize()
					G.CONTROLLER.locks[lock] = nil
					return true
				end
			}))
		elseif reward.name == "R-tag" then
			local tag_pool = get_current_pool('Tag')
			local selected_tag = pseudorandom_element(tag_pool, 'arcs_R_tag')
			local it = 1
			while selected_tag == 'UNAVAILABLE' do
				it = it + 1
				selected_tag = pseudorandom_element(tag_pool, 'arcs_seed_resample'..it)
			end
			add_tag(Tag(selected_tag, false, 'Small')) -- Ignore the previous code and just use a key for a prefined tag
		elseif reward.name == "R-joke" and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
			SMODS.add_card{ -- For a random one
				set = "Joker", -- You can use a custom pool/ObjectType. See `What's a pool/set?`
				key_append = "arcs_append" -- Optional, key for randomization/pool checking
			}
		end
	elseif context.end_of_round and context.game_over and context.main_eval and SMODS.find_card("j_mr_bones") then
		G.GAME.Grades = 1
	end
end