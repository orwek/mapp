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
  local p = 0
  for i = -16,16,1 do
      for j = -16,16,1 do
          local po = {x = pos.x+i, y = pos.y+100, z = pos.z+j}
          local no = minetest.env:get_node_or_nil(po)
		  if no ~= nil and no.name == "air" then
		     p = -1 
		  else
		     p =  1 
		  end
          local k=pos.y+100
          local pos1 = {x = pos.x+i, y = k, z = pos.z+j}
          local node = minetest.env:get_node_or_nil(pos1)
          if node ~= nil then
             while node.name ~= "air" do
                local tile = ""
                local def = minetest.registered_nodes[node.name]
                local tiles = def["tiles"]                        
                local tile = tiles[1]                              
                
                if type(tile)=="table" then tile=tile["name"] end
                local point = "image[".. 0.15*(i+16) ..",".. 0.15*(j+16) ..";0.2,0.2;" ..tile.."]"				

				ppp1 = {x=pos1.x+1,y=pos1.y,z=pos1.z}
				ppp2 = {x=pos1.x-1,y=pos1.y,z=pos1.z}
				ppp3 = {x=pos1.x,y=pos1.y+1,z=pos1.z}
				ppp4 = {x=pos1.x,y=pos1.y-1,z=pos1.z}
				ppp5 = {x=pos1.x,y=pos1.y,z=pos1.z+1}
				ppp6 = {x=pos1.x,y=pos1.y,z=pos1.z-1}				
				if (minetest.env:get_node(ppp1).name=='air')
				or (minetest.env:get_node(ppp2).name=='air')
				or (minetest.env:get_node(ppp3).name=='air')
				or (minetest.env:get_node(ppp4).name=='air')
				or (minetest.env:get_node(ppp5).name=='air')
				or (minetest.env:get_node(ppp6).name=='air')
				then
                map = map .. point
				end
                k = k - p     
                pos1 = {x = pos.x+i, y = k, z = pos.z+j}
                node = minetest.env:get_node_or_nil(pos1)
                minetest.debug("x = "..pos1.x..", y = ".. k .. ", z = ".. pos1.z.. "; p = "..p)						
				--break
             end
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
