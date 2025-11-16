to_big = to_big or function(a) return a end
lenient_bignum = lenient_bignum or function(a) return a end

local geomelatro = SMODS.current_mod


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