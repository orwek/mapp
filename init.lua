minetest.register_tool("mapp:map", {
	description = "map",
	inventory_image = "map_block.png",
	on_use = function(itemstack, user, pointed_thing)
	map_handler(itemstack,user,pointed_thing)
	end,
})
function map_handler (itemstack, user, pointed_thing)
		local pos = user:getpos()
		local player_name=user:get_player_name()
		local mapar = {}
		local map = ""
		local p = 0
		local po = {x = 0, y = 0, z = 0}
		local no = minetest.env:get_node(po)
		local node = ""
		local tile = ""
		local def = {}
		local tiles = {}
		local point = ""

		for i = -17,17,1 do
			mapar[i+17] = {}
			for j = -17,17,1 do
				mapar[i+17][j+17] = {}
				po = {x = pos.x+i, y = pos.y, z = pos.z+j}
				no = minetest.env:get_node(po)
				local k=po.y
				if no.name == "air" then
					while no.name == "air" do
						k=k-1
						po = {x = pos.x+i, y = k, z = pos.z+j}
						no = minetest.env:get_node(po)
					end
				elseif no.name ~= "air" and (no.name ~= "ignore")  then
						while (no.name ~= "air") and (no.name ~= "ignore") do
							k=k+1
							po = {x = pos.x+i, y = k, z = pos.z+j}
							no = minetest.env:get_node(po)
						end
				  k=k-1
				  po = {x = pos.x+i, y = k, z = pos.z+j}
				end

				node = minetest.env:get_node(po)
				tile = ""
				def = minetest.registered_nodes[node.name]				
				if def then tiles = def["tiles"] end
				if tiles ~=nil then
					tile = tiles[1]  
				end

				if type(tile)=="table" then 
				  tile=tile["name"] 
				end
				mapar[i+17][j+17].y = k
				mapar[i+17][j+17].im = tile
			end
		end

	for i=1,32,1 do
		for j=1,32,1 do
			if mapar[i][j].y ~= mapar[i][j+1].y then mapar[i][j].im = mapar[i][j].im .. "^1black_blockt.png" end
			if mapar[i][j].y ~= mapar[i][j-1].y then mapar[i][j].im = mapar[i][j].im .. "^1black_blockb.png" end
			if mapar[i][j].y ~= mapar[i-1][j].y then mapar[i][j].im = mapar[i][j].im .. "^1black_blockl.png" end
			if mapar[i][j].y ~= mapar[i+1][j].y then mapar[i][j].im = mapar[i][j].im .. "^1black_blockr.png" end
			point = "image[".. 0.15*(i) ..",".. 0.15*(32-j)+0.1 ..";0.2,0.2;" .. mapar[i][j].im .. "]"
			map = map .. point
		end
	end
minetest.show_formspec(player_name, "mapp:map", "size[5.2,5]"..map)
end


minetest.register_craft({
	output = 'mapp:map_block',
	recipe = {
		{'', '', ''},
		{'', 'default:dirt', ''},
		{'default:dirt', 'default:dirt', 'default:dirt'},
	}
})
