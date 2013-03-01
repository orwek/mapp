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
          local po = {x = pos.x+i, y = pos.y, z = pos.z+j}                    
          local no = minetest.env:get_node(po)
          local k=po.y
		  if no.name == "air" then
             while no.name == "air" do
                 k=k-1                    
                 po = {x = pos.x+i, y = k, z = pos.z+j}                    
                 no = minetest.env:get_node(po)               
            end             
          else
             local no = minetest.env:get_node_or_nil(po)
             while (no.name ~= "air") and (no ~= nil) do
                 k=k+1                    
                 po = {x = pos.x+i, y = k, z = pos.z+j}                    
                 no = minetest.env:get_node(po)               
                 minetest.debug("x = "..po.x..", y = ".. k .. ", z = ".. po.z)						
            end             

		  end          
          local node = minetest.env:get_node(po)
          local tile = ""
          local def = minetest.registered_nodes[node.name]                
          local tiles = def["tiles"]
          if tiles ~=nil then                        
             local tile = tiles[1]                              
                         
          if type(tile)=="table" then tile=tile["name"] end
             local point = "image[".. 0.15*(i+16) ..",".. 0.15*(j+16) ..";0.2,0.2;" ..tile.."]"				

				ppp1 = {x=po.x+1,y=po.y,z=po.z}
				ppp2 = {x=po.x-1,y=po.y,z=po.z}
				ppp3 = {x=po.x,y=po.y+1,z=po.z}
				ppp4 = {x=po.x,y=po.y-1,z=po.z}
				ppp5 = {x=po.x,y=po.y,z=po.z+1}
				ppp6 = {x=po.x,y=po.y,z=po.z-1}				
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
