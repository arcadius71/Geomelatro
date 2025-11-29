to_big = to_big or function(a) return a end
lenient_bignum = lenient_bignum or function(a) return a end

local geomelatro = SMODS.current_mod

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
local GradeReq = {
	{ -- requires custom code, so make it free n shit
		grade = "A++",

		met = true,
		score = {0},
		hands = 10,
		discards = 10,
		points = 4
	},
	{
		grade = "A+",

		met = true,
		othermet = true,
		score = {5, 10}, -- if [2] isnt met then othermet wont be true
		hands = 1,
		discards = 1,
		points = 3
	},
	{
		grade = "A",

		met = true,
		othermet = true,
		score = {2, 10},
		hands = 1,
		discards = 1,
		points = 3
	},
	{
		grade = "B+",

		met = true,
		othermet = true,
		score = {1, 3},
		hands = 2,
		discards = 10,
		points = 1
	},
	{
		grade = "B",

		met = true,
		othermet = true,
		score = {1, 2},
		hands = 2,
		discards = 10,
		points = 1
	},
	{
		grade = "C+",

		met = true,
		score = {1.5},
		hands = 3,
		discards = 10,
		points = 0
	},
	{
		grade = "C",

		met = true,
		score = {1},
		hands = 3,
		discards = 10,
		points = 0
	},
	{
		grade = "F",

		met = true,
		score = {1},
		hands = 3,
		discards = 10,
		points = -1
	},
	{
		grade = "F-",

		met = true,
		score = {0},
		hands = 3,
		discards = 10,
		points = -3
	},
}

	-- Function to check requirements
local function Grade() -- theres like 7 different "Grade" variables
	local discards = to_big(G.GAME.current_round.discards_used)
	local hands = to_big(G.GAME.current_round.hands_played)
	local required = to_big(G.GAME.blind.chips)
	local score = to_big(G.GAME.chips)
	local over = to_big(score / required)
	-- print("Discards: ".. discards, "Hands: ".. hands,
		--   "Score: ".. score, "Over: ".. over)

	local hPoint = -4
	local gradetbl

	-- Check Score requirements
	for _, grade in ipairs(GradeReq) do -- has to be ipairs since if its outta order A being before A+ would make A more priority than A+
		print([[


		]]..grade.grade..[[

		]])
		-- holy if statements | Def gonna want to beg balatro server to help me check if its good or not 😭
		if grade.grade == "A++" then
			-- custom stuff here
			-- else
			grade.met = false

			goto continue
		end
		-- score
		-- print(to_big(grade.score[2]) < over, "a2")
		-- print(to_big(grade.score[1]) < over, "a1")
		if to_big(grade.score[2]) < over then
			grade.othermet = false
		elseif to_big(grade.score[1]) < over then
			grade.met = false
		end

		-- print(to_big(grade.hands) > hands, "b")
		if to_big(grade.hands) > hands then grade.met = false end
			-- fuck that we're doing it in one line
			
		-- print(to_big(grade.discards) > discards, "c")
		if to_big(grade.discards) > discards then grade.met = false end

		-- print((grade.othermet or grade.met) and grade.points > hPoint, "d")
		if (grade.othermet or grade.met) then
			if grade.points > hPoint then
				hPoint = grade.points
				gradetbl = grade	
			end
			-- I found having them together broke it???? i still had the ()
		end
		grade.othermet = true
		grade.met = true
		-- print([[



		-- :3



		-- ]])
	    ::continue::
	end

	return gradetbl
end

geomelatro.calculate = function(self, context)
	if context.setting_blind then
		if G.GAME.Grades then
			G.GAME.Grades = G.GAME.Grades / 4
		else
			G.GAME.Grades = 0
		end
	elseif context.end_of_round and not context.game_over then
		local grading = Grade()
		-- print(grading.grade)
	elseif context.end_of_round and context.game_over and context.main_eval and SMODS.find_card("j_mr_bones") then
		G.GAME.Grades = G.GAME.Grades - 3
	end
end