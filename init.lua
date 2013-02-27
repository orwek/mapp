radar = {
	description = "map block",
	inventory_image = ("radar_block.png"),
	tiles = {"radar_block.png"},
	drawtype="normal",
	is_ground_content = true,
	groups = {crumbly=3},
	walkable=true,
	pointable=true,
	diggable=true,
	on_punch = function(pos, node, puncher)
  local map = ""
  for i = -16,16,1 do
      for j = -16,16,1 do
          local k=pos.y+100
          while true do
                 local pos1 = {x = pos.x+i, y = k, z = pos.z+j}
                 local node = minetest.env:get_node_or_nil(pos1)
                 if node ~=nil
                 then
                     local tile = ""
                     if node.name ~= "air"
                      then
                        local def = minetest.registered_nodes[node.name]
                        if def ~= nil then 
                           local tiles = def["tiles"]                        
                           if tiles ~= nil then 
                              tile = tiles[1]                              
                              if type(tile) == "table" then
                                 --minetest.debug(minetest.serialize(tiles))
                                 tile = tile["name"]
                              end                              
                           end
                        end                        
--                        local point = "image["..tostring(i+8).."/32,"..tostring(j+8).."/32;1/32,1/32;" ..tile.."]"
                        local point = "image[".. 0.15*(i+16) ..",".. 0.15*(j+16) ..";0.2,0.2;" ..tile.."]"
                        map = map .. point
                        break
                     end
                 end
                 k = k - 1     
          end          
      end     
  end
  
  local meta= minetest.env:get_meta(pos)
  local signal=""
  signal=map
  meta:set_string("formspec","size[5.1,4.9]"..
  signal)	  	
	end,
	
	  
}

minetest.register_node("mapp:map_block", radar)
	
minetest.register_craft({
	output = 'mapp:map_block',
	recipe = {
		{'', '', ''},
		{'', 'default:dirt', ''},
		{'default:dirt', 'default:dirt', 'default:dirt'},
	}
})
